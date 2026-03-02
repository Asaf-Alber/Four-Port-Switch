//------------------------------------------------------------------------------
// checker.sv
// Scoreboard/checker for the 4-port switch.
// - Sequencer calls add_expected() before driving
// - Monitors call run_comparison() on observed outputs
// - Matching is order-independent per output port queue
// - Delivery-based matching: (source,data) + expected target contains port
//   (DUT is not required to preserve the full original target mask on output)
//------------------------------------------------------------------------------
class \checker extends component_base;

  int match_count          = 0;
  int mismatch_count       = 0;
  int unexpected_count     = 0;

  int total_expected_count = 0; // expected destination hits
  int total_received_count = 0; // monitor-observed packets

  bit session_started      = 0;

  // expected_pkts[port_id] holds packets expected to emerge from that port
  packet expected_pkts[4][$];

  function new(string n, component_base p = null);
	super.new(n, p);
  endfunction

  // Infer type from target mask (debug/helper)
  function automatic packet::pkt_type_e infer_type(bit [3:0] t);
	if (t == 4'b1111)            return packet::BROADCAST;
	else if ($countones(t) == 1) return packet::SINGLE;
	else                         return packet::MULTICAST;
  endfunction

  // Exact match (source,data,target)
  function automatic int find_expected_exact(int port_id, packet p);
	foreach (expected_pkts[port_id][k]) begin
	  if ((expected_pkts[port_id][k].data   == p.data)   &&
		  (expected_pkts[port_id][k].source == p.source) &&
		  (expected_pkts[port_id][k].target == p.target)) begin
		return k;
	  end
	end
	return -1;
  endfunction

  // Partial match (source,data)
  function automatic int find_expected_by_src_data(int port_id, packet p);
	foreach (expected_pkts[port_id][k]) begin
	  if ((expected_pkts[port_id][k].data   == p.data) &&
		  (expected_pkts[port_id][k].source == p.source)) begin
		return k;
	  end
	end
	return -1;
  endfunction

  // Delivery-based match: (source,data) and expected target includes this port
  function automatic int find_expected_delivery(int port_id, packet actual_pkt);
	foreach (expected_pkts[port_id][k]) begin
	  if ((expected_pkts[port_id][k].data          == actual_pkt.data)   &&
		  (expected_pkts[port_id][k].source        == actual_pkt.source) &&
		  (expected_pkts[port_id][k].target[port_id] == 1'b1)) begin
		return k;
	  end
	end
	return -1;
  endfunction

  // Drain helper (best-effort delete) to avoid pending-expected deadlocks 
  function automatic bit drain_expected(int port_id, packet actual_pkt, output packet drained);
	int k;
	drained = null;

	k = find_expected_delivery(port_id, actual_pkt);
	if (k == -1) k = find_expected_exact(port_id, actual_pkt);
	if (k == -1) k = find_expected_by_src_data(port_id, actual_pkt);

	if (k != -1) begin
	  drained = expected_pkts[port_id][k];
	  expected_pkts[port_id].delete(k);
	  return 1'b1;
	end

	return 1'b0;
  endfunction

  //--------------------------------------------------------------------------
  // add_expected(): called by sequencer BEFORE driving into DUT
  // Push a deep-copy into each destination queue.
  //--------------------------------------------------------------------------

  function void add_expected(packet pkt);
	session_started = 1;

	if (pkt.target == 4'b0000) begin
	  $error("[%0t] %s: add_expected() got illegal pkt with target=0 (tag=%0d)",
			 $time, pathname(), pkt.tag);
	end

	for (int d = 0; d < 4; d++) begin
	  if (pkt.target[d]) begin
		// Skip self-routing for non-broadcast packets
		if ((pkt.pkt_type != packet::BROADCAST) && pkt.source[d])
		  continue;

		expected_pkts[d].push_back(pkt.copy());
		total_expected_count++;
	  end
	end
  endfunction

  //--------------------------------------------------------------------------
  // run_comparison(): called by monitor when packet emerges on port_id
  //--------------------------------------------------------------------------

  virtual task run_comparison(packet actual_pkt, int port_id);
	int idx = -1;

	if (actual_pkt == null) begin
	  $error("[%0t] %s: INTERNAL ERROR: run_comparison got null actual_pkt at port %0d",
			 $time, pathname(), port_id);
	  mismatch_count++;
	  total_received_count++;
	  return;
	end

	// Sanity: target must not be zero
	if (actual_pkt.target == 4'b0000) begin
	  packet drained; bit did_drain;
	  did_drain = drain_expected(port_id, actual_pkt, drained);

	  $error("[%0t] %s: Protocol ERROR: actual packet at port %0d has target=0 (data=0x%0h src=%b)%s",
			 $time, pathname(), port_id, actual_pkt.data, actual_pkt.source,
			 did_drain ? $sformatf(" | Drained expected(tag=%0d tgt=%b)", drained.tag, drained.target)
					   : " | No expected drained");

	  mismatch_count++;
	  total_received_count++;
	  return;
	end

	// Sanity: packet must only appear on an intended destination port
	if (!actual_pkt.target[port_id]) begin
	  packet drained; bit did_drain;
	  did_drain = drain_expected(port_id, actual_pkt, drained);

	  $error("[%0t] %s: Routing ERROR: packet observed at port %0d but target bit not set. got(tgt=%b src=%b data=0x%0h)%s",
			 $time, pathname(), port_id, actual_pkt.target, actual_pkt.source, actual_pkt.data,
			 did_drain ? $sformatf(" | Drained expected(tag=%0d tgt=%b)", drained.tag, drained.target)
					   : " | No expected drained");

	  mismatch_count++;
	  total_received_count++;
	  return;
	end

	// Delivery-based match
	idx = find_expected_delivery(port_id, actual_pkt);

	if (idx != -1) begin
	  packet exp;
	  exp = expected_pkts[port_id][idx];
	  expected_pkts[port_id].delete(idx);

	  // Informational: compare inferred actual type vs expected type
	  if (infer_type(actual_pkt.target) != exp.pkt_type) begin
		$warning("[%0t] %s: Type INFO: expected type=%s but inferred actual type=%s (tag=%0d port=%0d got_tgt=%b exp_tgt=%b)",
				 $time, pathname(),
				 exp.pkt_type.name(),
				 infer_type(actual_pkt.target).name(),
				 exp.tag, port_id, actual_pkt.target, exp.target);
	  end

	  // DUT may localize target on output
	  if (actual_pkt.target != exp.target) begin
		$warning("[%0t] %s: Target INFO: expected tgt=%b but DUT reported tgt=%b at port %0d (tag=%0d)",
				 $time, pathname(), exp.target, actual_pkt.target, port_id, exp.tag);
	  end

	  $display("[%0t] %s: MATCH at Port %0d | tag=%0d | src=%b | got_tgt=%b | data=0x%0h | type=%s",
			   $time, pathname(), port_id,
			   exp.tag, actual_pkt.source, actual_pkt.target, actual_pkt.data,
			   infer_type(actual_pkt.target).name());

	  match_count++;
	end
	else begin
	  // Diagnostic: try partial match (source,data)
	  int partial = -1;
	  partial = find_expected_by_src_data(port_id, actual_pkt);

	  if (partial != -1) begin
		packet e2 = expected_pkts[port_id][partial];

		// Delete to avoid pending-expected hang; still count mismatch
		expected_pkts[port_id].delete(partial);

		$error("[%0t] %s: MISMATCH at Port %0d | exp(tag=%0d src=%b tgt=%b data=0x%0h) got(src=%b tgt=%b data=0x%0h)",
			   $time, pathname(), port_id,
			   e2.tag, e2.source, e2.target, e2.data,
			   actual_pkt.source, actual_pkt.target, actual_pkt.data);
		mismatch_count++;
	  end
	  else begin
		$error("[%0t] %s: UNEXPECTED packet at Port %0d | src=%b tgt=%b data=0x%0h",
			   $time, pathname(), port_id, actual_pkt.source, actual_pkt.target, actual_pkt.data);
		unexpected_count++;
	  end
	end

	total_received_count++;
  endtask

  // Done once traffic started and all expected queues are empty
  function bit is_done();
	if (!session_started) return 0;

	for (int i = 0; i < 4; i++) begin
	  if (expected_pkts[i].size() != 0) return 0;
	end

	return 1;
  endfunction

  function int pending_expected();
	int p = 0;
	for (int i = 0; i < 4; i++) p += expected_pkts[i].size();
	return p;
  endfunction

  function void report();
	$display("\n--- %s FINAL REPORT ---", pathname());
	$display("Total Matches:       %0d", match_count);
	$display("Total Mismatches:    %0d", mismatch_count);
	$display("Unexpected:          %0d", unexpected_count);
	$display("Total Expected Hits: %0d (info)", total_expected_count);
	$display("Total Received:      %0d (info)", total_received_count);
	$display("Pending Expected:    %0d", pending_expected());

	if (mismatch_count == 0 && unexpected_count == 0 && is_done())
	  $display("TEST STATUS: PASSED");
	else
	  $display("TEST STATUS: FAILED");
  endfunction

endclass
