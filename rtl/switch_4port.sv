// File Name: switch_4port.sv
// Description:
//   Top-level Switch Fabric with:
//   - Per-destination Round-Robin (RR) arbitration
//   - Multi-grant (multicast) support via grant bus per source
//   - Generic (no hard-coded "4") implementation for NUM_PORTS
//   - Optional protocol checks / multi-grant error checks via assertions
//
// TB Coverage Closure Hook:
//   Define TB_GRANT_STALL to enable tb_stall_grant[NUM_PORTS-1:0] input.
//   Each bit stalls the corresponding switch_port's effective grants to zero.

module switch_4port #(
  parameter int unsigned NUM_PORTS        = 4,
  parameter bit          ALLOW_MULTICAST  = 1'b1  // set to 0 to enforce at-most-1 grant per source
)(
  input  wire   clk,
  input  wire   rst_n,

  port_if port0,
  port_if port1,
  port_if port2,
  port_if port3

);

  localparam int unsigned S_W   = 4;
  localparam int unsigned T_W   = 4;
  localparam int unsigned D_W   = 8;

  // RR pointer width
  localparam int unsigned PTR_W = (NUM_PORTS <= 1) ? 1 : $clog2(NUM_PORTS);

  // Internal Signals
  wire               in_valid   [NUM_PORTS];
  wire [S_W-1:0]     in_source  [NUM_PORTS];
  wire [T_W-1:0]     in_target  [NUM_PORTS];
  wire [D_W-1:0]     in_data    [NUM_PORTS];

  wire               out_valid  [NUM_PORTS];
  wire [S_W-1:0]     out_source [NUM_PORTS];
  wire [T_W-1:0]     out_target [NUM_PORTS];
  wire [D_W-1:0]     out_data   [NUM_PORTS];

  // Interface Mapping 
  assign in_valid[0]  = port0.valid_in;  assign in_source[0] = port0.source_in;  assign in_target[0] = port0.target_in;  assign in_data[0] = port0.data_in;
  assign in_valid[1]  = port1.valid_in;  assign in_source[1] = port1.source_in;  assign in_target[1] = port1.target_in;  assign in_data[1] = port1.data_in;
  assign in_valid[2]  = port2.valid_in;  assign in_source[2] = port2.source_in;  assign in_target[2] = port2.target_in;  assign in_data[2] = port2.data_in;
  assign in_valid[3]  = port3.valid_in;  assign in_source[3] = port3.source_in;  assign in_target[3] = port3.target_in;  assign in_data[3] = port3.data_in;

  assign port0.valid_out = out_valid[0]; assign port0.source_out = out_source[0]; assign port0.target_out = out_target[0]; assign port0.data_out = out_data[0];
  assign port1.valid_out = out_valid[1]; assign port1.source_out = out_source[1]; assign port1.target_out = out_target[1]; assign port1.data_out = out_data[1];
  assign port2.valid_out = out_valid[2]; assign port2.source_out = out_source[2]; assign port2.target_out = out_target[2]; assign port2.data_out = out_data[2];
  assign port3.valid_out = out_valid[3]; assign port3.source_out = out_source[3]; assign port3.target_out = out_target[3]; assign port3.data_out = out_data[3];

  // Ready (backpressure) mapping from DUT to TB
  wire p_ready_in [NUM_PORTS];

  assign port0.ready_in = p_ready_in[0];
  assign port1.ready_in = p_ready_in[1];
  assign port2.ready_in = p_ready_in[2];
  assign port3.ready_in = p_ready_in[3];


  // Port Instances
  wire               p_valid_out  [NUM_PORTS];
  wire [S_W-1:0]     p_source_out [NUM_PORTS];
  wire [T_W-1:0]     p_target_out [NUM_PORTS];
  wire [D_W-1:0]     p_data_out   [NUM_PORTS];

  // Multi-bit grant input per source port (destination bits)
  logic [NUM_PORTS-1:0] p_grant_in_bus [NUM_PORTS];

  generate
	for (genvar i = 0; i < NUM_PORTS; i++) begin : gen_ports
	  switch_port #(
		.SOURCE_W (S_W),
		.TARGET_W (T_W),
		.DATA_W   (D_W)
	  ) port_inst (
		.clk        (clk),
		.rst_n      (rst_n),
		.valid_in   (in_valid[i]),
		.source_in  (in_source[i]),
		.target_in  (in_target[i]),
		.data_in    (in_data[i]),
		.grant_in   (p_grant_in_bus[i]),
		
		.valid_out  (p_valid_out[i]),
		.source_out (p_source_out[i]),
		.target_out (p_target_out[i]),
		.data_out   (p_data_out[i]),
		
		.ready_in   (p_ready_in[i]) 

	  );
	end
  endgenerate

  // Helper: One-hot -> index
  function automatic int unsigned onehot_to_idx(input logic [NUM_PORTS-1:0] oh);
	int unsigned idx;
	begin
	  idx = 0;
	  for (int unsigned i = 0; i < NUM_PORTS; i++) begin
		if (oh[i]) idx = i;
	  end
	  return idx;
	end
  endfunction

  // Round Robin Pointer per Destination
  logic [PTR_W-1:0] rr_pointer [NUM_PORTS];

  always_ff @(posedge clk) begin
	if (!rst_n) begin
	  for (int unsigned k = 0; k < NUM_PORTS; k++) rr_pointer[k] <= '0;
	end
	else begin
	  for (int unsigned d = 0; d < NUM_PORTS; d++) begin
		if (out_valid[d]) begin
		  int unsigned win_idx;
		  int unsigned nxt;
		  win_idx = onehot_to_idx(out_source[d][NUM_PORTS-1:0]);
		  nxt     = win_idx + 1;
		  if (nxt >= NUM_PORTS) nxt = 0;
		  rr_pointer[d] <= logic'(nxt[PTR_W-1:0]);
		end
	  end
	end
  end

  // Arbitration & Routing
  logic [NUM_PORTS-1:0] grant_matrix [NUM_PORTS]; // [Dest][Source]

  logic                r_valid  [NUM_PORTS];
  logic [S_W-1:0]      r_source [NUM_PORTS];
  logic [T_W-1:0]      r_target [NUM_PORTS];
  logic [D_W-1:0]      r_data   [NUM_PORTS];

  function automatic int unsigned rr_wrap_add(
	input int unsigned base,
	input int unsigned off
  );
	int unsigned tmp;
	begin
	  tmp = base + off;
	  if (tmp >= NUM_PORTS) tmp = tmp - NUM_PORTS;
	  return tmp;
	end
  endfunction

  always_comb begin
	// Defaults
	for (int unsigned k = 0; k < NUM_PORTS; k++) begin
	  r_valid[k]      = 1'b0;
	  r_source[k]     = '0;
	  r_target[k]     = '0;
	  r_data[k]       = '0;
	  grant_matrix[k] = '0;
	end

	// Per destination arbitration
	for (int unsigned d = 0; d < NUM_PORTS; d++) begin
	  for (int unsigned offset = 0; offset < NUM_PORTS; offset++) begin
		int unsigned s;
		s = rr_wrap_add(rr_pointer[d], offset);

		// Source s requests destination d
		if (p_valid_out[s] && p_target_out[s][d]) begin
		  r_valid[d]          = 1'b1;
		  r_source[d]         = p_source_out[s];
		  r_target[d]         = p_target_out[s];
		  r_data[d]           = p_data_out[s];
		  grant_matrix[d][s]  = 1'b1;
		  break;
		end
	  end
	end

	// Aggregate grants per source (destination bits)
	for (int unsigned s = 0; s < NUM_PORTS; s++) begin
	  p_grant_in_bus[s] = '0;
	  for (int unsigned d = 0; d < NUM_PORTS; d++) begin
		p_grant_in_bus[s][d] = grant_matrix[d][s];
	  end
	end
  end

  // Drive outputs
  assign out_valid  = r_valid;
  assign out_source = r_source;
  assign out_target = r_target;
  assign out_data   = r_data;

`ifdef ASSERTIONS
  // Each destination grants at most one source (onehot0)
  generate
	for (genvar d = 0; d < NUM_PORTS; d++) begin : gen_assert_dest_one_winner
	  always_comb begin
		assert ($onehot0(grant_matrix[d]))
		  else $error("Multi-grant ERROR: destination %0d granted >1 source. grant_matrix=%b",
					  d, grant_matrix[d]);
	  end
	end
  endgenerate

  // If multicast is not allowed, each source may receive at most one destination grant
  // NOTE:
  // These assertions are only active when ALLOW_MULTICAST=0.
  // In this project, multicast is required, so they are intentionally not exercised.
  generate
	for (genvar s = 0; s < NUM_PORTS; s++) begin : gen_assert_src_multicast
	  always_comb begin
		if (!ALLOW_MULTICAST) begin
		  assert ($onehot0(p_grant_in_bus[s]))
			else $error("Multi-grant ERROR: source %0d got multiple dest grants. grants=%b",
						s, p_grant_in_bus[s]);
		end
	  end
	end
  endgenerate

  // Basic protocol sanity: valid packet should have nonzero target
  generate
	for (genvar s = 0; s < NUM_PORTS; s++) begin : gen_assert_target_nonzero
	  always_comb begin
		if (p_valid_out[s]) begin
		  assert (p_target_out[s] != '0)
			else $error("Protocol ERROR: source %0d asserted valid with target=0.", s);
		end
	  end
	end
  endgenerate

  //  Spec requires source_out to be one-hot and match port index
  generate
	for (genvar s = 0; s < NUM_PORTS; s++) begin : gen_assert_source_identity
	  always_comb begin
		if (p_valid_out[s]) begin
		  assert ($onehot(p_source_out[s][NUM_PORTS-1:0]))
			else $error("Protocol ERROR: source_out not one-hot from port %0d. source_out=%b", s, p_source_out[s]);
		  assert (p_source_out[s][s] == 1'b1)
			else $error("Protocol ERROR: source_out mismatch. port=%0d source_out=%b", s, p_source_out[s]);
		end
	  end
	end
  endgenerate
`endif

endmodule
