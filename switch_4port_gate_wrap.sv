module switch_4port_gate_wrap (
	input  logic clk,
	input  logic rst_n,
	port_if port0,
	port_if port1,
	port_if port2,
	port_if port3
  );

	// -----------------------------
	// Port 0 nets
	// -----------------------------
	wire        port0_valid_in_w;
	wire [3:0]  port0_source_in_w;
	wire [3:0]  port0_target_in_w;
	wire [7:0]  port0_data_in_w;
	wire        port0_ready_in_w;     // DUT -> TB

	wire        port0_valid_out_w;
	wire [3:0]  port0_source_out_w;
	wire [3:0]  port0_target_out_w;
	wire [7:0]  port0_data_out_w;

	// TB -> DUT
	assign port0_valid_in_w  = port0.valid_in;
	assign port0_source_in_w = port0.source_in;
	assign port0_target_in_w = port0.target_in;
	assign port0_data_in_w   = port0.data_in;

	// DUT -> TB
	assign port0.ready_in    = port0_ready_in_w;
	assign port0.valid_out   = port0_valid_out_w;
	assign port0.source_out  = port0_source_out_w;
	assign port0.target_out  = port0_target_out_w;
	assign port0.data_out    = port0_data_out_w;

	// -----------------------------
	// Port 1 nets
	// -----------------------------
	wire        port1_valid_in_w;
	wire [3:0]  port1_source_in_w;
	wire [3:0]  port1_target_in_w;
	wire [7:0]  port1_data_in_w;
	wire        port1_ready_in_w;     // DUT -> TB

	wire        port1_valid_out_w;
	wire [3:0]  port1_source_out_w;
	wire [3:0]  port1_target_out_w;
	wire [7:0]  port1_data_out_w;

	assign port1_valid_in_w  = port1.valid_in;
	assign port1_source_in_w = port1.source_in;
	assign port1_target_in_w = port1.target_in;
	assign port1_data_in_w   = port1.data_in;

	assign port1.ready_in    = port1_ready_in_w;
	assign port1.valid_out   = port1_valid_out_w;
	assign port1.source_out  = port1_source_out_w;
	assign port1.target_out  = port1_target_out_w;
	assign port1.data_out    = port1_data_out_w;

	// -----------------------------
	// Port 2 nets
	// -----------------------------
	wire        port2_valid_in_w;
	wire [3:0]  port2_source_in_w;
	wire [3:0]  port2_target_in_w;
	wire [7:0]  port2_data_in_w;
	wire        port2_ready_in_w;     // DUT -> TB

	wire        port2_valid_out_w;
	wire [3:0]  port2_source_out_w;
	wire [3:0]  port2_target_out_w;
	wire [7:0]  port2_data_out_w;

	assign port2_valid_in_w  = port2.valid_in;
	assign port2_source_in_w = port2.source_in;
	assign port2_target_in_w = port2.target_in;
	assign port2_data_in_w   = port2.data_in;

	assign port2.ready_in    = port2_ready_in_w;
	assign port2.valid_out   = port2_valid_out_w;
	assign port2.source_out  = port2_source_out_w;
	assign port2.target_out  = port2_target_out_w;
	assign port2.data_out    = port2_data_out_w;

	// -----------------------------
	// Port 3 nets
	// -----------------------------
	wire        port3_valid_in_w;
	wire [3:0]  port3_source_in_w;
	wire [3:0]  port3_target_in_w;
	wire [7:0]  port3_data_in_w;
	wire        port3_ready_in_w;     // DUT -> TB

	wire        port3_valid_out_w;
	wire [3:0]  port3_source_out_w;
	wire [3:0]  port3_target_out_w;
	wire [7:0]  port3_data_out_w;

	assign port3_valid_in_w  = port3.valid_in;
	assign port3_source_in_w = port3.source_in;
	assign port3_target_in_w = port3.target_in;
	assign port3_data_in_w   = port3.data_in;

	assign port3.ready_in    = port3_ready_in_w;
	assign port3.valid_out   = port3_valid_out_w;
	assign port3.source_out  = port3_source_out_w;
	assign port3.target_out  = port3_target_out_w;
	assign port3.data_out    = port3_data_out_w;

	// -----------------------------
	// Gate-level DUT instantiation
	// (flat ports, per your edited netlist)
	// -----------------------------
	switch_4port dut (
	  .clk             (clk),
	  .rst_n           (rst_n),

	  .port0_clk       (clk),
	  .port0_rst_n     (rst_n),
	  .port0_valid_in  (port0_valid_in_w),
	  .port0_source_in (port0_source_in_w),
	  .port0_target_in (port0_target_in_w),
	  .port0_data_in   (port0_data_in_w),
	  .port0_ready_in  (port0_ready_in_w),
	  .port0_valid_out (port0_valid_out_w),
	  .port0_source_out(port0_source_out_w),
	  .port0_target_out(port0_target_out_w),
	  .port0_data_out  (port0_data_out_w),

	  .port1_clk       (clk),
	  .port1_rst_n     (rst_n),
	  .port1_valid_in  (port1_valid_in_w),
	  .port1_source_in (port1_source_in_w),
	  .port1_target_in (port1_target_in_w),
	  .port1_data_in   (port1_data_in_w),
	  .port1_ready_in  (port1_ready_in_w),
	  .port1_valid_out (port1_valid_out_w),
	  .port1_source_out(port1_source_out_w),
	  .port1_target_out(port1_target_out_w),
	  .port1_data_out  (port1_data_out_w),

	  .port2_clk       (clk),
	  .port2_rst_n     (rst_n),
	  .port2_valid_in  (port2_valid_in_w),
	  .port2_source_in (port2_source_in_w),
	  .port2_target_in (port2_target_in_w),
	  .port2_data_in   (port2_data_in_w),
	  .port2_ready_in  (port2_ready_in_w),
	  .port2_valid_out (port2_valid_out_w),
	  .port2_source_out(port2_source_out_w),
	  .port2_target_out(port2_target_out_w),
	  .port2_data_out  (port2_data_out_w),

	  .port3_clk       (clk),
	  .port3_rst_n     (rst_n),
	  .port3_valid_in  (port3_valid_in_w),
	  .port3_source_in (port3_source_in_w),
	  .port3_target_in (port3_target_in_w),
	  .port3_data_in   (port3_data_in_w),
	  .port3_ready_in  (port3_ready_in_w),
	  .port3_valid_out (port3_valid_out_w),
	  .port3_source_out(port3_source_out_w),
	  .port3_target_out(port3_target_out_w),
	  .port3_data_out  (port3_data_out_w)
	);

  endmodule
