//------------------------------------------------------------------------------
// tb_port_cov.sv
// TB-only functional coverage for gate-level:
// - input handshake (valid_in && ready_in)
// - output activity (valid_out)
// - packet "type" inferred from target bits (single/mcast/bcast)
// - backpressure observation (ready_in==0)
//------------------------------------------------------------------------------

module tb_port_cov #(
  parameter int unsigned TARGET_W = 4
)(
  input  logic             clk,
  input  logic             rst_n,

  // Ingress (TB -> DUT)
  input  logic             valid_in,
  input  logic             ready_in,
  input  logic [TARGET_W-1:0] target_in,

  // Egress (DUT -> TB)
  input  logic             valid_out,
  input  logic [TARGET_W-1:0] target_out
);

  // Inferred "type" from target mask
  function automatic int pkt_type(input logic [TARGET_W-1:0] t);
	int ones;
	ones = $countones(t);
	if (t == '0)                    return 0; // illegal/none
	else if (t == {TARGET_W{1'b1}}) return 3; // broadcast
	else if (ones == 1)             return 1; // single
	else                            return 2; // multicast
  endfunction

  // Count ones for ?fanout? coverage
  function automatic int fanout(input logic [TARGET_W-1:0] t);
	return $countones(t);
  endfunction

  // A transfer into DUT happens when TB asserts valid and DUT is ready
  logic in_xfer;
  always_comb in_xfer = valid_in && ready_in;

  // A transfer out of DUT happens when valid_out is asserted (your design has no ready_out)
  logic out_xfer;
  always_comb out_xfer = valid_out;

  covergroup port_cg @(posedge clk);
	option.per_instance = 1;

	// Gate all TB functional coverage out of reset
	in_xfer_cp  : coverpoint in_xfer  iff (rst_n) { bins hit = {1'b1}; }
	out_xfer_cp : coverpoint out_xfer iff (rst_n) { bins hit = {1'b1}; }

	// Backpressure seen on this ingress
	ready_cp : coverpoint ready_in iff (rst_n) {
	  bins ready     = {1'b1};
	  bins not_ready = {1'b0};
	}

	// Input target classification (what we *asked* to send)
	in_type_cp : coverpoint pkt_type(target_in) iff (rst_n && in_xfer) {
	  bins single    = {1};
	  bins multicast = {2};
	  bins broadcast = {3};
	  // optional: illegal = {0};
	}

	// Output target classification (what DUT *presents* as remaining_targets)
	out_type_cp : coverpoint pkt_type(target_out) iff (rst_n && out_xfer) {
	  bins single    = {1};
	  bins multicast = {2};
	  bins broadcast = {3};
	  // optional: illegal = {0};
	}

	// Fanout coverage (how many destinations in mask)
	in_fanout_cp : coverpoint fanout(target_in) iff (rst_n && in_xfer) {
	  bins one  = {1};
	  bins two  = {2};
	  bins three= {3};
	  bins four = {4};
	}

	out_fanout_cp : coverpoint fanout(target_out) iff (rst_n && out_xfer) {
	  bins one  = {1};
	  bins two  = {2};
	  bins three= {3};
	  bins four = {4};
	}


  endgroup

  port_cg cov = new();

endmodule
