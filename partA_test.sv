// File Name: partA_test.sv
// Description: Comprehensive Stage A QA Testbench.
//              Covers Unicast, Multicast, Broadcast, Round-Robin Fairness, 
//              FIFO Backpressure, Error Recovery, Reset Recovery, and Full-Duplex.

/* module stageA_QA;

  reg clk;
  reg rst_n; 

  // Instantiate interfaces for 4 ports
  port_if port0(clk, rst_n);
  port_if port1(clk, rst_n);
  port_if port2(clk, rst_n);
  port_if port3(clk, rst_n);

  // DUT Connection
  switch_4port DUT (
	.clk(clk),
	.rst_n(rst_n),
	.port0(port0),
	.port1(port1),
	.port2(port2),
	.port3(port3)
  );

  // Clock Generation
  initial begin
	clk = 0;
	forever #5 clk = ~clk; // 10ns Period
  end

  // Monitor Process
  always @(posedge clk) begin
	if (port0.valid_out) 
	  $display("[TIME %0t] [MONITOR] Port 0 RECEIVED packet! Data=0x%h Source=0x%h", $time, port0.data_out, port0.source_out);
	  
	if (port1.valid_out) 
	  $display("[TIME %0t] [MONITOR] Port 1 RECEIVED packet! Data=0x%h Source=0x%h", $time, port1.data_out, port1.source_out);
	  
	if (port2.valid_out) 
	  $display("[TIME %0t] [MONITOR] Port 2 RECEIVED packet! Data=0x%h Source=0x%h", $time, port2.data_out, port2.source_out);
	  
	if (port3.valid_out) 
	  $display("[TIME %0t] [MONITOR] Port 3 RECEIVED packet! Data=0x%h Source=0x%h", $time, port3.data_out, port3.source_out);
  end
 

  // Main Test Sequence
  initial begin
	packet p; // Helper handle

	// Reset Phase
	$display("[TIME %0t] STARTING STAGE A QA TESTS", $time);
	
	rst_n = 0;
	#20 rst_n = 1;
	#20;

	// TEST 1: Unicast (Standard)
	// Scenario: Port 0 sends to Port 1.
	$display("\n[TEST 1] Unicast: Port 0 sends to Port 1");
	p = new("unicast", 0); 
	p.target = 4'b0010; // Port 1
	p.data   = 8'h11;
	port0.drive_packet(p);
	#40;

	// TEST 2: Multicast (Standard)
	// Scenario: Port 1 sends to Ports 0 & 3.
	$display("\n[TEST 2] Multicast: Port 1 sends to Ports 0 & 3");
	p = new("multicast", 1); 
	p.target = 4'b1001; // Ports 3 and 0
	p.data   = 8'h22;
	port1.drive_packet(p);
	#40;

	// TEST 3: Broadcast (Special Case)
	// Scenario: Port 2 sends to ALL. Self-loop is ALLOWED here.
	$display("\n[TEST 3] Broadcast: Port 2 sends to ALL (Target 1111)");
	p = new("broadcast", 2); 
	p.target = 4'b1111; // All ports
	p.data   = 8'hBB;   // 'BB' for Broadcast
	port2.drive_packet(p);
	#40;

	// TEST 4: Illegal Unicast Self-Loop
	// Scenario: Port 3 tries to send to Port 3. Should be dropped.
	$display("\n[TEST 4] Illegal Unicast Self-Loop: Port 3 -> Port 3");
	p = new("bad_uni", 3); 
	p.target = 4'b1000; // Self
	p.data   = 8'hDE;   // 'DE' for Dead/Dropped
	port3.drive_packet(p);
	#40;

	// TEST 5: Illegal Multicast Self-Loop (Partial Drop)
	// Scenario: Port 0 sends to Port 1 (Valid) & Port 0 (Illegal).
	//           Port 1 receives data. Port 0 drops data.
	$display("\n[TEST 5] Illegal Multicast Self-Loop: Port 0 -> 0 & 1");
	p = new("mixed_self", 0);
	p.target = 4'b0011; // 1 and 0 
	p.data   = 8'h55;   
	port0.drive_packet(p);
	#40;

	
	// TEST 6: Illegal Zero Target (Deadlock Check)
	// Scenario: Send 0000 packet. Ensure FSM flushes it and recovers.
	$display("\n[TEST 6] Illegal Packet: Target 0000 (Deadlock Check)");
	
	// Step 1: Send BAD Packet
	$display("[Time %0t] Sending Bad Packet (Target=0000)...", $time);
	begin
		packet pBad;
		pBad = new("BadPkt", 1); 
		pBad.target = 4'b0000;   // ILLEGAL
		pBad.data   = 8'hDD;     
		port1.drive_packet(pBad);
	end
	
	#40; 

	// Step 2: Send GOOD Packet (Recovery Check)
	$display("[Time %0t] Sending Valid Packet to check recovery...", $time);
	begin
		packet pGood;
		pGood = new("GoodPkt", 1); 
		pGood.target = 4'b0100;    // Target: Port 2
		pGood.data   = 8'hBA;      
		port1.drive_packet(pGood);
	end
	
	#40;
	
	// TEST 7: Contention (Arbitration Fairness)
	// Scenario: Verify Round-Robin Pointer movement.
	// Step 1: Port 1 transmits alone -> RR Pointer moves to 2.
	// Step 2: Port 1 & 2 transmit together -> Since Pointer is 2, Port 2 MUST win.
	$display("\n[TEST 7] Contention Test: Fairness Check");

	// --- STEP 1: Move the Pointer ---
	$display("[Time %0t] Step 1: Port 1 transmits alone (moves RR ptr to 2)...", $time);
	begin
		packet pSolo;
		pSolo = new("Solo_P1", 1);
		pSolo.target = 4'b0001; // Target 0
		pSolo.data   = 8'h11;
		port1.drive_packet(pSolo);
	end
	#40; // Wait for finish

	// --- STEP 2: The Race ---
	$display("[Time %0t] Step 2: Port 1 & 2 collide. Expecting Port 2 to WIN first...", $time);
	fork 
		begin
			packet pA;
			pA = new("Race_P1", 1); 
			pA.target = 4'b0001; // Target 0
			pA.data   = 8'hAA;   // ID: AA
			port1.drive_packet(pA);
		end
		begin
			packet pB;
			pB = new("Race_P2", 2); 
			pB.target = 4'b0001; // Target 0
			pB.data   = 8'hBB;   // ID: BB
			port2.drive_packet(pB);
		end
	join

	// Expectation: 0xBB appears first, then 0xAA (buffered in FIFO)
	#80; 

	// TEST 8: FIFO Stress (3-Way Collision)
	// Scenario: Ports 0, 1, 2 ALL send to Port 3 simultaneously.
	//           Verify no packets are dropped (FIFO usage).
	$display("\n[TEST 8] FIFO Stress: 3-Way Collision (No Drop Check)");
	
	$display("[Time %0t] Driving 3 packets to Port 3...", $time);
	fork 
		begin
			packet pFIFO_A;
			pFIFO_A = new("P0_to_P3", 0); 
			pFIFO_A.target = 4'b1000; 
			pFIFO_A.data   = 8'hA0;   
			port0.drive_packet(pFIFO_A);
		end
		begin
			packet pFIFO_B;
			pFIFO_B = new("P1_to_P3", 1); 
			pFIFO_B.target = 4'b1000; 
			pFIFO_B.data   = 8'hB1;   
			port1.drive_packet(pFIFO_B);
		end
		begin
			packet pFIFO_C;
			pFIFO_C = new("P2_to_P3", 2); 
			pFIFO_C.target = 4'b1000; 
			pFIFO_C.data   = 8'hC2;   
			port2.drive_packet(pFIFO_C);
		end 
	join
	
	// Wait for 3 sequential transactions + margin
	#120;

	// TEST 9: Reset Recovery (Mid-Flight Reset)
	// Scenario: Start sending a packet, then FORCE Reset in the middle.
	//           Verify that the system stops and can recover afterwards.
	$display("\n[TEST 9] Reset Recovery Test: Reset during active transmission");

	// Step A: Start a transmission and interrupt it
	$display("[Time %0t] Driving packet, will reset halfway...", $time);
	fork
		begin
			packet pReset;
			pReset = new("Reset_Victim", 0); 
			pReset.target = 4'b0010; // To Port 1
			pReset.data   = 8'hFF;
			port0.drive_packet(pReset);
		end
		begin
			// Wait a bit (middle of process) then hit Reset
			#30; 
			$display("[Time %0t] !!! ASSERTING RESET !!!", $time);
			rst_n = 0;
			#20; // Hold reset for 2 clock cycles
			rst_n = 1;
			$display("[Time %0t] Reset Released.", $time);
		end
	join

	#50; // Wait for system to stabilize

	// Step B: Prove the system is alive
	$display("[Time %0t] Sending new packet to prove recovery...", $time);
	begin
		packet pAlive;
		pAlive = new("Survivor", 0);
		pAlive.target = 4'b0100; // To Port 2
		pAlive.data   = 8'h77;   // 0x77
		port0.drive_packet(pAlive);
	end
	#40;

	// TEST 10: Parallel Traffic (Non-Blocking Check)
	// Scenario: 0->1 AND 2->3 running simultaneously.
	//           (Proves Reset didn't break complex routing)
	$display("\n[TEST 10] Parallel Traffic: 0->1 AND 2->3 (Should run together)");
	
	fork 
		// Flow 1: 0 -> 1
		begin
			packet pPar1;
			pPar1 = new("Parallel_A", 0); 
			pPar1.target = 4'b0010; // To Port 1
			pPar1.data   = 8'hAA;   
			port0.drive_packet(pPar1);
		end
		
		// Flow 2: 2 -> 3
		begin
			packet pPar2;
			pPar2 = new("Parallel_B", 2); 
			pPar2.target = 4'b1000; // To Port 3
			pPar2.data   = 8'hBB;   
			port2.drive_packet(pPar2);
		end
	join
	
	#40;
	
	// TEST 11: Swap Traffic (0->1 AND 1->0)
	// Scenario: Full Duplex Check
	$display("\n[TEST 11] Swap Traffic: 0->1 AND 1->0 (Full Duplex Check)");
	
	fork 
		// Flow 1: Port 0 sending to Port 1
		begin
			packet pSwapA;
			pSwapA = new("Swap_0to1", 0); 
			pSwapA.target = 4'b0010; // To Port 1
			pSwapA.data   = 8'h01;   
			port0.drive_packet(pSwapA);
		end
		
		// Flow 2: Port 1 sending to Port 0
		begin
			packet pSwapB;
			pSwapB = new("Swap_1to0", 1); 
			pSwapB.target = 4'b0001; // To Port 0
			pSwapB.data   = 8'h10;   
			port1.drive_packet(pSwapB);
		end
	join
	
	#40;

	$display("\n[TIME %0t] ALL TESTS FINISHED", $time); 
	$finish;
  end

endmodule
*/