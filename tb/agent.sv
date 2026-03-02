//------------------------------------------------------------------------------
// agent.sv
// Verification agent:
// - sequencer generates transactions
// - driver drives transactions into the DUT via virtual interface
// - monitor observes DUT outputs via virtual interface
//------------------------------------------------------------------------------

class agent extends component_base;

  // Sub-components
  sequencer sqr;
  driver    drv;
  monitor   mon;

  function new(string n, component_base p = null);
	super.new(n, p);

	// Sub-hierarchy: agent.sqr / agent.drv / agent.mon
	sqr = new("sqr", this);
	drv = new("drv", this);
	mon = new("mon", this);
  endfunction

  // Internal wiring (driver pulls from this agent's sequencer)
  virtual function void build();
	if ((sqr == null) || (drv == null) || (mon == null)) begin
	  $fatal(1, "%s: build() failed - null sub-component handle", pathname());
	end
	drv.sqr = sqr;
  endfunction

  // Start driver + monitor concurrently
  virtual task run(int num_pkts);
	fork
	  drv.run(num_pkts);
	  mon.run();
	join_none
  endtask

endclass
