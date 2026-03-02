//------------------------------------------------------------------------------
// fifo.sv
// Synchronous FIFO with overflow/underflow protection.
// - Write is ignored when full (unless a read in the same cycle frees space)
// - Read is ignored when empty
// - dout is combinational (FWFT-like) to match switch_port usage
//------------------------------------------------------------------------------

module fifo #(
  parameter int unsigned DATA_WIDTH = 16,
  parameter int unsigned DEPTH      = 8
)(
  input  wire                  clk,
  input  wire                  rst_n,

  // Write
  input  wire                  wr_en,
  input  wire [DATA_WIDTH-1:0] din,

  // Read
  input  wire                  rd_en,
  output wire [DATA_WIDTH-1:0] dout,

  // Status
  output wire                  full,
  output wire                  empty
);

  localparam int unsigned PTR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH);

  // Storage and state
  reg [DATA_WIDTH-1:0] mem   [0:DEPTH-1];
  reg [PTR_W-1:0]      wr_ptr;
  reg [PTR_W-1:0]      rd_ptr;
  reg [PTR_W:0]        count;   // 0..DEPTH

  // Flags
  assign full  = (count == DEPTH);
  assign empty = (count == 0);

  // FWFT-style combinational read
  assign dout  = mem[rd_ptr];

  // Effective operations (protected)
  wire do_read  = rd_en && !empty;
  wire do_write = wr_en && (!full || do_read); // allow write when full if read frees space

  // Illegal attempts (for assertions/logging)
  wire overflow_attempt  = wr_en && full  && !do_read;
  wire underflow_attempt = rd_en && empty;

  //--------------------------------------------------------------------------
  // Sequential state update
  //--------------------------------------------------------------------------

  always_ff @(posedge clk) begin
	if (!rst_n) begin
	  wr_ptr <= '0;
	  rd_ptr <= '0;
	  count  <= '0;
	end
	else begin
	  if (do_write) begin
		mem[wr_ptr] <= din;
		wr_ptr      <= wr_ptr + 1'b1;
	  end

	  if (do_read) begin
		rd_ptr <= rd_ptr + 1'b1;
	  end

	  unique case ({do_write, do_read})
		2'b10: count <= count + 1'b1; // write only
		2'b01: count <= count - 1'b1; // read only
		default: count <= count;      // 00 or 11: unchanged
	  endcase
	end
  end

`ifdef ASSERTIONS
  // Defensive assertions (may not be exercised by a well-behaved TB)

  // A) Overflow attempt must not corrupt state
  property p_overflow_protected;
	@(posedge clk) disable iff (!rst_n)
	  overflow_attempt |-> ($stable(wr_ptr) && $stable(count));
  endproperty
  assert_overflow_protected: assert property (p_overflow_protected)
	else $error("FIFO overflow attempt: state changed unexpectedly at time %0t", $time);

  // B) Underflow attempt must not corrupt state
  property p_underflow_protected;
	@(posedge clk) disable iff (!rst_n)
	  underflow_attempt |-> ($stable(rd_ptr) && $stable(count));
  endproperty
  assert_underflow_protected: assert property (p_underflow_protected)
	else $error("FIFO underflow attempt: state changed unexpectedly at time %0t", $time);

  // C) Count must stay within [0..DEPTH]
  property p_count_in_range;
	@(posedge clk) disable iff (!rst_n)
	  (count <= DEPTH);
  endproperty
  assert_count_in_range: assert property (p_count_in_range)
	else $error("FIFO count out of range: count=%0d DEPTH=%0d at time %0t",
				count, DEPTH, $time);

  // D) Flag consistency
  property p_empty_consistent;
	@(posedge clk) disable iff (!rst_n)
	  empty |-> (count == 0);
  endproperty
  assert_empty_consistent: assert property (p_empty_consistent);

  property p_full_consistent;
	@(posedge clk) disable iff (!rst_n)
	  full |-> (count == DEPTH);
  endproperty
  assert_full_consistent: assert property (p_full_consistent);

`endif

endmodule
