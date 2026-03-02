//------------------------------------------------------------------------------
// packet_vc.sv
// Verification Component (VC) for a single DUT port.
// - Wraps an agent (sequencer + driver + monitor)
// - Connects virtual interface and shared checker
// - Assigns a unique port_id (0..3)
//------------------------------------------------------------------------------

class packet_vc extends component_base;

  // Sub-environment for this port
  agent agnt;

  // Shared checker across all ports
  \checker chk;

  // Virtual interface for this port
  virtual port_if vif;

  // Port index (0..3)
  int port_id;

  function new(string n, component_base p = null);
	super.new(n, p);
	agnt = new("agnt", this);
  endfunction

  //--------------------------------------------------------------------------
  // configure()
  // - Bind virtual interface to driver/monitor
  // - Bind checker to monitor (actuals) and sequencer (expecteds)
  // - Set port context (port_id / port_index)
  //--------------------------------------------------------------------------
  function void configure(virtual port_if v, int id, \checker c);

	// Sanity checks
	if (v == null) begin
	  $fatal(1, "[%0t] %s: configure() got null virtual interface!", $time, pathname());
	end
	if (c == null) begin
	  $fatal(1, "[%0t] %s: configure() got null checker handle!", $time, pathname());
	end
	if (!(id inside {[0:3]})) begin
	  $fatal(1, "[%0t] %s: configure() got illegal port id=%0d (expected 0..3)!",
			 $time, pathname(), id);
	end
	if (agnt == null) begin
	  $fatal(1, "[%0t] %s: configure() agnt is null!", $time, pathname());
	end

	// Store handles / context
	this.vif     = v;
	this.port_id = id;
	this.chk     = c;

	// BFM connectivity
	agnt.drv.vif = v;
	agnt.mon.vif = v;

	// Checker connectivity
	agnt.mon.chk_h   = c;   // observed packets (destination context)
	agnt.mon.port_id = id;

	agnt.sqr.chk_h      = c; // expected packets registration
	agnt.sqr.port_index = id;

	// Finalize agent internal wiring (drv<->sqr, etc.)
	agnt.build();
  endfunction

  // Start this VC with a bounded number of packets
  virtual task run(int num_pkts);
	agnt.run(num_pkts);
  endtask

endclass
