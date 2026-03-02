//------------------------------------------------------------------------------
// File Name   : sequencer.sv
// Description : Produces randomized packet transactions.
//               - Selects SINGLE/MULTICAST/BROADCAST based on weighted randcase.
//               - Randomizes the transaction under constraints.
//               - Registers expected packets with the checker (scoreboard) BEFORE
//                 the driver injects them into the DUT.
//------------------------------------------------------------------------------

// Forward declaration (avoids compile-order issues)
typedef class checker;  

class sequencer extends component_base;

  // The source port index for this sequencer instance (0..3).
  int port_index;

  // Shared checker handle (used to register expected hits).
  \checker chk_h;

  function new(string n, component_base p=null);
	super.new(n,p);
  endfunction

  //--------------------------------------------------------------------------
  // get_next_packet()
  // - Creates a derived packet type based on a weighted distribution.
  // - Randomizes it (constraints enforced in base + derived class).
  // - Notifies checker about expected output hits prior to driving.
  //--------------------------------------------------------------------------
  virtual task get_next_packet(output packet pkt);

	// Choose packet class
	randcase
	  34 : pkt = single_pkt::new    ("sqr_single_pkt", port_index);
	  33 : pkt = multicast_pkt::new ("sqr_multi_pkt",  port_index);
	  33 : pkt = broadcast_pkt::new ("sqr_bcast_pkt",  port_index);
	endcase

	// Randomize fields
	if (!pkt.randomize()) begin
	  $error("[%0t] %s: Randomization failed!", $time, pathname());
	end

	// Register expectations with checker before driving
	if (chk_h != null) begin
	  chk_h.add_expected(pkt);
	end
	else begin
		$warning("[%0t] %s: chk_h is null ? expected packet not registered",
				 $time, pathname());
	  end

	// Debug print
	$display("[%0t] Sequencer %s generated %s (Tag: %0d):",
			 $time, pathname(), pkt.get_name(), pkt.tag);
	pkt.print(packet::FMT_BIN);

  endtask

endclass
