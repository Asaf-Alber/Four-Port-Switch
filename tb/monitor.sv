//------------------------------------------------------------------------------
// monitor.sv
// Passive monitor:
// - Collects packets from DUT output via port_if.collect_packet()
// - Samples functional coverage on observed packets
// - Forwards observed packets to the shared checker
//------------------------------------------------------------------------------

// Forward declaration (avoids compile-order issues)
typedef class checker;

class monitor extends component_base;

  // Configuration 
  virtual port_if vif;
  \checker chk_h;
  int port_id;

  // Coverage sample handle
  packet pkt_to_sample;

  // Coverage: packet type and whether this port receives single/multicast traffic
  covergroup packet_cg;
	option.per_instance = 1;

	// Type inferred from target mask (coverage-only)
	type_cp: coverpoint infer_type(pkt_to_sample.target)
	  iff (pkt_to_sample != null) {
		bins single    = {packet::SINGLE};
		bins multicast = {packet::MULTICAST};
		bins broadcast = {packet::BROADCAST};
	  }

	single_to_me_cp: coverpoint (pkt_to_sample.target == (4'b0001 << port_id))
	  iff (pkt_to_sample != null) { bins hit = {1'b1}; }

	multi_to_me_cp: coverpoint ( ($countones(pkt_to_sample.target) > 1) &&
								 ((pkt_to_sample.target & (4'b0001 << port_id)) != 0) )
	  iff (pkt_to_sample != null) { bins hit = {1'b1}; }
  endgroup

  function new(string n, component_base p = null);
	super.new(n, p);
	packet_cg = new();
  endfunction

  function automatic packet::pkt_type_e infer_type(bit [3:0] tgt);
	if (tgt == 4'b1111)         return packet::BROADCAST;
	else if ($countones(tgt)==1) return packet::SINGLE;
	else                        return packet::MULTICAST;
  endfunction

  virtual task run();
	packet pkt;

	if (vif == null) begin
	  $fatal(1, "[%0t] Monitor %s: No interface connected!", $time, pathname());
	end

	// Avoid sampling during reset
	wait (vif.rst_n === 1);
	@(posedge vif.clk);

	forever begin
	  vif.collect_packet(pkt);

	  if (pkt == null) begin
		$fatal(1, "[%0t] Monitor %s: collect_packet returned null!", $time, pathname());
	  end

	  // Coverage (non-intrusive)
	  pkt_to_sample = pkt;
	  packet_cg.sample();

	  // Scoreboarding
	  if (chk_h != null) begin
		chk_h.run_comparison(pkt, port_id);
	  end
	  else begin
		$warning("[%0t] Monitor %s: chk_h is null; packet not checked", $time, pathname());
	  end
	end
  endtask

endclass
