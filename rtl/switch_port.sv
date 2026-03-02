//------------------------------------------------------------------------------
// switch_port.sv
// Port controller with FIFO and explicit FSM.
// - FWFT-style FIFO usage (latch in RECEIVE, pop in TRANSMIT)
// - Multicast support via remaining_targets mask
// - Optional TB grant stall hook
//------------------------------------------------------------------------------

module switch_port #(
  parameter int unsigned SOURCE_W = 4,
  parameter int unsigned TARGET_W = 4,
  parameter int unsigned DATA_W   = 8
)(
  input  wire                    clk,
  input  wire                    rst_n,

  // Ingress
  input  wire                    valid_in,
  input  wire [SOURCE_W-1:0]     source_in,
  input  wire [TARGET_W-1:0]     target_in,
  input  wire [DATA_W-1:0]       data_in,

  // Fabric
  input  wire [TARGET_W-1:0]     grant_in,
  output reg                     valid_out,
  output wire [SOURCE_W-1:0]     source_out,
  output wire [TARGET_W-1:0]     target_out,
  output wire [DATA_W-1:0]       data_out,
  output wire                    ready_in
);

  localparam int unsigned FIFO_W = SOURCE_W + TARGET_W + DATA_W;

  // FIFO interface
  wire              fifo_wr_en;
  reg               fifo_rd_en;
  wire              fifo_full;
  wire              fifo_empty;
  wire [FIFO_W-1:0] fifo_din;
  wire [FIFO_W-1:0] fifo_dout;

  assign fifo_din   = {source_in, target_in, data_in};
  assign fifo_wr_en = valid_in && !fifo_full;
  assign ready_in   = !fifo_full;   

  fifo #(.DATA_WIDTH(FIFO_W), .DEPTH(8)) my_fifo (
	.clk   (clk),
	.rst_n (rst_n),
	.wr_en (fifo_wr_en),
	.din   (fifo_din),
	.rd_en (fifo_rd_en),
	.dout  (fifo_dout),
	.full  (fifo_full),
	.empty (fifo_empty)
  );

  // Latched packet fields
  reg [SOURCE_W-1:0] r_source;
  reg [TARGET_W-1:0] r_target;           // informational
  reg [DATA_W-1:0]   r_data;
  reg [TARGET_W-1:0] remaining_targets;  // pending destinations

  // FSM
  typedef enum logic [1:0] {
	S_IDLE,
	S_RECEIVE,
	S_ROUTE,
	S_TRANSMIT
  } state_t;

  state_t current_state, next_state;

  // Effective grant (TB may stall grants)
  wire [TARGET_W-1:0] grant_eff =
`ifdef TB_GRANT_STALL
	(tb_stall_grant ? '0 : grant_in);
`else
	grant_in;
`endif

  //--------------------------------------------------------------------------
  // Sequential state
  //--------------------------------------------------------------------------

  always_ff @(posedge clk) begin
	if (!rst_n) begin
	  current_state     <= S_IDLE;
	  r_source          <= '0;
	  r_target          <= '0;
	  r_data            <= '0;
	  remaining_targets <= '0;
	end
	else begin
	  current_state <= next_state;

	  case (current_state)
		S_RECEIVE: begin
		  {r_source, r_target, r_data} <= fifo_dout;
		  remaining_targets            <= fifo_dout[DATA_W + TARGET_W - 1 -: TARGET_W];
		end

		S_ROUTE: begin
		  remaining_targets <= remaining_targets & ~grant_eff;
		end

		default: ; // no-op
	  endcase
	end
  end

  // Outputs
  assign source_out = r_source;
  assign target_out = remaining_targets;
  assign data_out   = r_data;

  //--------------------------------------------------------------------------
  // FSM combinational logic
  //--------------------------------------------------------------------------

  always_comb begin
	next_state = current_state;
	valid_out  = 1'b0;
	fifo_rd_en = 1'b0;

	case (current_state)
	  S_IDLE: begin
		if (!fifo_empty) next_state = S_RECEIVE;
	  end

	  S_RECEIVE: begin
		next_state = S_ROUTE;
	  end

	  S_ROUTE: begin
		valid_out = |remaining_targets;
		if ((remaining_targets & ~grant_eff) == '0)
		  next_state = S_TRANSMIT;
	  end

	  S_TRANSMIT: begin
		fifo_rd_en = 1'b1;
		next_state = S_IDLE;
	  end

	  default: next_state = S_IDLE;
	endcase
  end
  
  `ifndef SYNTHESIS
	  //--------------------------------------------------------------------------
	  // FSM coverage
	  //--------------------------------------------------------------------------
	
	  covergroup fsm_cg @(posedge clk);
		option.per_instance = 1;
		// Cover presence of each FSM state
		state_cp: coverpoint current_state;
		// Cover FSM next-state encoding
		next_cp : coverpoint next_state;
	
		// Cover legal state transitions
		state_x_next: coverpoint current_state {
		  bins idle_to_receive   = (S_IDLE     => S_RECEIVE);
		  bins receive_to_route  = (S_RECEIVE  => S_ROUTE);
		  bins route_to_transmit = (S_ROUTE    => S_TRANSMIT);
		  bins transmit_to_idle  = (S_TRANSMIT => S_IDLE);
		}
		// Cover FIFO boundary conditions
		fifo_full_cp  : coverpoint fifo_full;
		fifo_empty_cp : coverpoint fifo_empty;
		// Cover valid_out assertion during routing
		valid_out_in_route_cp: coverpoint valid_out
		  iff (current_state == S_ROUTE) { bins asserted = {1'b1}; }
		// Cover completion of routing for a packet
		route_done_cp: coverpoint ((current_state == S_ROUTE) &&
								   ((remaining_targets & ~grant_eff) == '0));
	  endgroup
	  // Instantiate per switch_port instance
	  fsm_cg fsm_cov = new();  
  `endif 
  

  `ifdef ASSERTIONS

  // Valid packets must request at least one destination
  assert_in_target_nonzero: assert property (@(posedge clk) disable iff(!rst_n)
	valid_in |-> (target_in != '0)
  );

  // Fabric may only grant destinations that are still pending
  assert_grant_subset: assert property (@(posedge clk) disable iff(!rst_n)
	(current_state == S_ROUTE) |-> ((grant_eff & ~remaining_targets) == '0)
  );

  // In ROUTE, valid_out reflects existence of pending destinations
  assert_valid_out_def: assert property (@(posedge clk) disable iff(!rst_n)
	(current_state == S_ROUTE) |-> (valid_out == (|remaining_targets))
  );

  // FIFO pop is only allowed in TRANSMIT state
  assert_rd_only_in_transmit: assert property (@(posedge clk) disable iff(!rst_n)
	fifo_rd_en |-> (current_state == S_TRANSMIT)
  );

  // Ingress source encoding must be one-hot
  assert_source_onehot: assert property (@(posedge clk) disable iff(!rst_n)
	valid_in |-> $onehot(source_in)
  );

`endif

endmodule
