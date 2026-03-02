`timescale 1ps/1ps

module switch_test;

  //--------------------------------------------------------------------------
  // Clock / reset - Adjusted for 10ns Period (100MHz) to match SDC
  //--------------------------------------------------------------------------
  // SDC period is 10.0ns. 
  // 10ns = 10,000ps. Half-period = 5,000ps.
  parameter int CLK_PERIOD_PS    = 10000; 
  parameter int CLK_HALF_PS      = CLK_PERIOD_PS / 2;

  parameter int RESET_CYCLES     = 5;
  parameter int POST_RESET_CYCLES= 2;
  parameter int TIMEOUT_CYCLES   = 2000;

  bit clk = 0;
  always begin
	#CLK_HALF_PS;
	clk = ~clk;
  end

  bit rst_n;

  // Watchdog bookkeeping
  int idle_cycles;
  int pending;

  //--------------------------------------------------------------------------
  // DUT interfaces (one per port)
  //--------------------------------------------------------------------------
  port_if port0(clk, rst_n);
  port_if port1(clk, rst_n);
  port_if port2(clk, rst_n);
  port_if port3(clk, rst_n);

  tb_port_cov #(.TARGET_W(4)) cov_p0 (
	  .clk(clk), .rst_n(rst_n),
	  .valid_in (port0.valid_in),
	  .ready_in (port0.ready_in),
	  .target_in(port0.target_in),
	  .valid_out (port0.valid_out),
	  .target_out(port0.target_out)
	);

	tb_port_cov #(.TARGET_W(4)) cov_p1 ( .clk(clk), .rst_n(rst_n),
	  .valid_in (port1.valid_in), .ready_in (port1.ready_in),
	  .target_in(port1.target_in), .valid_out(port1.valid_out),
	  .target_out(port1.target_out)
	);

	tb_port_cov #(.TARGET_W(4)) cov_p2 ( .clk(clk), .rst_n(rst_n),
	  .valid_in (port2.valid_in), .ready_in (port2.ready_in),
	  .target_in(port2.target_in), .valid_out(port2.valid_out),
	  .target_out(port2.target_out)
	);

	tb_port_cov #(.TARGET_W(4)) cov_p3 ( .clk(clk), .rst_n(rst_n),
	  .valid_in (port3.valid_in), .ready_in (port3.ready_in),
	  .target_in(port3.target_in), .valid_out(port3.valid_out),
	  .target_out(port3.target_out)
	);

  // DUT (Gate-level via wrapper)
  switch_4port_gate_wrap dut (
	.clk  (clk),
	.rst_n(rst_n),
	.port0(port0),
	.port1(port1),
	.port2(port2),
	.port3(port3)
  );

  //--------------------------------------------------------------------------
  // Reset sequence (gate-level safe):
  // - Assert reset for N posedges
  // - Deassert on negedge + tiny offset (avoids $setup on reset pins)
  // - Allow a couple cycles to settle
  //--------------------------------------------------------------------------
  task automatic apply_reset();
	rst_n = 1'b0;
	repeat (RESET_CYCLES) @(posedge clk);

	// Deassert away from posedge clk to avoid $setup violations on reset pins
	@(negedge clk);
	#1;                 // 1ps offset (given `timescale 1ps/1ps)
	rst_n = 1'b1;

	repeat (POST_RESET_CYCLES) @(posedge clk);
  endtask

  //--------------------------------------------------------------------------
  // Wait until all DUT outputs stay idle for N cycles
  //--------------------------------------------------------------------------
  task automatic wait_outputs_idle(input int n_idle);
	int c;
	c = 0;
	while (c < n_idle) begin
	  @(posedge clk);
	  if (port0.valid_out || port1.valid_out || port2.valid_out || port3.valid_out)
		c = 0;
	  else
		c++;
	end
  endtask

  //--------------------------------------------------------------------------
  // Drive a single directed packet into a chosen ingress port
  //--------------------------------------------------------------------------
  task automatic drive_one(input int in_port,
						   input logic [3:0] tgt,
						   input byte data);
	packet p;
	p = new($sformatf("dir_in%0d_t%0h_%0h", in_port, tgt, data));

	case (in_port)
	  0: p.source = 4'b0001;
	  1: p.source = 4'b0010;
	  2: p.source = 4'b0100;
	  3: p.source = 4'b1000;
	  default: p.source = 4'b0001;
	endcase

	p.target = tgt;
	p.data   = data;

	case (in_port)
	  0: port0.drive_packet(p);
	  1: port1.drive_packet(p);
	  2: port2.drive_packet(p);
	  3: port3.drive_packet(p);
	endcase
  endtask

  //--------------------------------------------------------------------------
  // Directed stimulus phase to force FIFO-full coverage (optional)
  //--------------------------------------------------------------------------
  task automatic force_all_fifos_full_coverage();
	int t, i;
	logic [3:0] tgt_1hot;

	wait (rst_n === 1'b1);
	repeat (5) @(posedge clk);

	for (t = 0; t < 4; t++) begin
	  tgt_1hot = 4'b0001 << t;
	  $display("[%0t] Directed FULL stimulus for TARGET=%0d (onehot=%b) starting...",
			   $time, t, tgt_1hot);

	  for (i = 0; i < 32; i++) begin
		fork
		  drive_one(0, tgt_1hot, byte'(i));
		  drive_one(1, tgt_1hot, byte'(i + 8'h40));
		  drive_one(2, tgt_1hot, byte'(i + 8'h80));
		  drive_one(3, tgt_1hot, byte'(i + 8'hC0));
		join
	  end

	  wait_outputs_idle(50);
	  $display("[%0t] Directed FULL stimulus for TARGET=%0d completed and drained.",
			   $time, t);
	end

	wait_outputs_idle(80);
	$display("[%0t] All directed FULL stimuli completed and fully drained.", $time);
  endtask

  //--------------------------------------------------------------------------
  // Main test sequence
  //--------------------------------------------------------------------------
  initial begin
	\checker  chk;
	packet_vc vc0, vc1, vc2, vc3;

	$display("---------------------------------------");
	$display("    SWITCH FABRIC SYSTEM TEST START    ");
	$display("---------------------------------------");

	packet::pkt_count = 0;

	// Gate-level safe reset
	apply_reset();

	// Phase 1 (optional): coverage-only stress
	force_all_fifos_full_coverage();

	// Phase 2: functional verification
	chk = new("global_checker", null);

	vc0 = new("vc0", null);
	vc1 = new("vc1", null);
	vc2 = new("vc2", null);
	vc3 = new("vc3", null);

	vc0.configure(port0, 0, chk);
	vc1.configure(port1, 1, chk);
	vc2.configure(port2, 2, chk);
	vc3.configure(port3, 3, chk);

	fork
	  vc0.run(100);
	  vc1.run(100);
	  vc2.run(100);
	  vc3.run(100);
	join_none

	fork : watchdog_block

	  // Normal completion path
	  begin : done_thread
		wait (chk.session_started == 1);

		forever begin
		  @(posedge clk);
		  if (chk.is_done()) begin
			idle_cycles = 0;
			while (idle_cycles < 20) begin
			  @(posedge clk);
			  if (port0.valid_out || port1.valid_out ||
				  port2.valid_out || port3.valid_out)
				idle_cycles = 0;
			  else
				idle_cycles++;
			end
			break;
		  end
		end

		$display("[%0t] Done-condition reached and drain completed.", $time);
		repeat (10) @(posedge clk);
	  end

	  // Timeout safety net (cycle-based)
	  begin : timeout_thread
		repeat (TIMEOUT_CYCLES) @(posedge clk);
		pending = chk.pending_expected();
		$error("[%0t] WATCHDOG TIMEOUT: Pending expected packets=%0d (p0=%0d p1=%0d p2=%0d p3=%0d)",
			   $time, pending,
			   chk.expected_pkts[0].size(),
			   chk.expected_pkts[1].size(),
			   chk.expected_pkts[2].size(),
			   chk.expected_pkts[3].size());
	  end

	join_any
	disable watchdog_block;

	chk.report();
	$display("[%0t] Simulation finished.", $time);
	$finish;
  end

endmodule
