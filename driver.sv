//------------------------------------------------------------------------------
// File Name: driver.sv
// Description:
//   Driver BFM that requests packets from the sequencer and drives them into the DUT
//   through the port interface.
//------------------------------------------------------------------------------

typedef class sequencer;

class driver extends component_base;

  // Virtual interface connected to one physical port
  virtual port_if vif;

  // Handle to the sequencer that produces packets
  sequencer sqr;

  // Allow up to 4 concurrent injections across all drivers
  static semaphore drive_sem = new(4);

  function new(string n, component_base p=null);
	super.new(n,p);
  endfunction

  // Main driver loop
  virtual task run(int num_pkts);
	packet pkt;

	if (vif == null)
	  $fatal(1, "[%0t] %s: No virtual interface connected!", $time, pathname());

	if (sqr == null)
	  $fatal(1, "[%0t] %s: Sequencer handle is null!", $time, pathname());

	// Wait for reset release (synchronization with DUT)
	wait (vif.rst_n === 1);
	repeat (2) @(posedge vif.clk);

	// Drive exactly num_pkts packets
	repeat (num_pkts) begin
	  // Request a new randomized packet from the sequencer
	  sqr.get_next_packet(pkt);

	  if (pkt == null)
		$fatal(1, "[%0t] %s: Sequencer returned null packet!", $time, pathname());

	  // Send it into the DUT 
	 send_packet(pkt);	  
	end
  endtask

  // Send one packet through the interface
  task send_packet(packet p);
	if (vif == null)
	  $fatal(1, "[%0t] %s: Cannot send - vif is null!", $time, pathname());

	if (p == null)
	  $fatal(1, "[%0t] %s: Cannot send - packet handle is null!", $time, pathname());

	// Acquire one injection token 
	drive_sem.get(1);

	$display("[%0t] Driver %s: Sending Pkt [Tag: %0d] | Src: %b | Trgt: %b | Data: 0x%0h",
			 $time, pathname(), p.tag, p.source, p.target, p.data);

	// The interface task asserts valid_in for one cycle and drives fields.
	vif.drive_packet(p);

	// Release token
	drive_sem.put(1);
  endtask 
  		

endclass
