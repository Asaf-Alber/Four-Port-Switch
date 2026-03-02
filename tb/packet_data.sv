//------------------------------------------------------------------------------
// packet_data.sv
// Transaction object for the switch verification environment.
// - Constrained-random generation of type/source/target
// - Optional tag to data propagation
// - Deep-copy support for scoreboard usage
// - Configurable print formatting
//------------------------------------------------------------------------------
class packet;

  // Packet classification
  typedef enum { SINGLE, MULTICAST, BROADCAST } pkt_type_e;

  // Print format selector
  typedef enum { FMT_BIN, FMT_HEX, FMT_DEC } fmt_e;

  // Global tag counter
  static int pkt_count = 0;

  // Identification
  string name;
  int    tag;

  //  copy tag into data
  bit propagate_tag_to_data = 1'b1;

  // Randomized fields
  rand pkt_type_e pkt_type;
  rand bit [3:0]  source;   // one-hot
  rand bit [3:0]  target;   // destination mask
  rand bit [7:0]  data;     // payload

  //--------------------------------------------------------------------------
  // Base constraints
  //--------------------------------------------------------------------------

  // Type must match number of destination bits
  constraint c_type_consistency {
	(pkt_type == SINGLE)    -> ($countones(target) == 1);
	(pkt_type == MULTICAST) -> ($countones(target) inside {2,3});
	(pkt_type == BROADCAST) -> (target == 4'b1111);
  }

  // Target must not be empty
  constraint c_not_empty { target != 4'b0000; }

  // No self-routing except for broadcast
  constraint c_target_logic {
	(pkt_type == BROADCAST) || ((target & source) == 0);
  }

  //--------------------------------------------------------------------------
  // Constructor
  //--------------------------------------------------------------------------
  function new(string name = "pkt", int port_index = 0, bit do_count = 1, bit prop_tag = 1);

	this.name = name;
	this.propagate_tag_to_data = prop_tag;

	// Fix source when a valid port index is provided
	if (port_index >= 0 && port_index <= 3) begin
	  this.source = 1 << port_index;
	  this.source.rand_mode(0);
	end

	// Assign unique tag if requested
	if (do_count) begin
	  pkt_count++;
	  this.tag = pkt_count;
	end
  endfunction

  //--------------------------------------------------------------------------
  // post_randomize()
  // - Optional tag propagation into data
  //--------------------------------------------------------------------------
  function void post_randomize();
	if (propagate_tag_to_data) begin
	  this.data = this.tag[7:0];
	end
  endfunction

  //--------------------------------------------------------------------------
  // Accessors
  //--------------------------------------------------------------------------
  function pkt_type_e get_type();
	return pkt_type;
  endfunction

  function string get_name();
	return name;
  endfunction

  //--------------------------------------------------------------------------
  // copy()
  // Deep copy for scoreboard storage (does not increment pkt_count)
  //--------------------------------------------------------------------------
  virtual function packet copy();
	packet cp = new(this.name, -1, 0, this.propagate_tag_to_data);
	cp.tag      = this.tag;
	cp.source   = this.source;
	cp.target   = this.target;
	cp.data     = this.data;
	cp.pkt_type = this.pkt_type;
	return cp;
  endfunction

  //--------------------------------------------------------------------------
  // print()
  // Configurable field formatting
  //--------------------------------------------------------------------------
  function void print(fmt_e fmt = FMT_HEX);
	$display("Packet Name: %s | Tag: %0d", name, tag);
	$display("Type:   %s", pkt_type.name());

	case (fmt)
	  FMT_BIN: begin
		$display("Source: 4'b%04b (One-Hot)", source);
		$display("Target: 4'b%04b",          target);
		$display("Data:   8'b%08b",          data);
	  end
	  FMT_DEC: begin
		$display("Source: %0d (One-Hot encoded)", source);
		$display("Target: %0d",                  target);
		$display("Data:   %0d",                  data);
	  end
	  default: begin // FMT_HEX
		$display("Source: 4'h%h (One-Hot)", source);
		$display("Target: 4'h%h",           target);
		$display("Data:   8'h%h",           data);
	  end
	endcase
  endfunction

endclass


//------------------------------------------------------------------------------
// Derived Classes
//------------------------------------------------------------------------------

// SINGLE: exactly one target, no self-routing
class single_pkt extends packet;
  constraint c_target_logic {
	pkt_type == SINGLE;
	$countones(target) == 1;
	(target & source) == 0;
  }
  function new(string name = "single_pkt", int port_index = -1, bit prop_tag = 1);
	super.new(name, port_index, 1, prop_tag);
  endfunction
endclass

// MULTICAST: 2?3 targets, no self-routing
class multicast_pkt extends packet;
  constraint c_target_logic {
	pkt_type == MULTICAST;
	$countones(target) inside {2,3};
	(target & source) == 0;
  }
  function new(string name = "multi_pkt", int port_index = -1, bit prop_tag = 1);
	super.new(name, port_index, 1, prop_tag);
  endfunction
endclass

// BROADCAST: all ports
class broadcast_pkt extends packet;
  constraint c_target_logic {
	pkt_type == BROADCAST;
	target == 4'b1111;
  }
  function new(string name = "bcast_pkt", int port_index = -1, bit prop_tag = 1);
	super.new(name, port_index, 1, prop_tag);
  endfunction
endclass
