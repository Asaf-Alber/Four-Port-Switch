interface port_if_synth;
	logic        valid_in;
	logic [3:0]  source_in;
	logic [3:0]  target_in;
	logic [7:0]  data_in;
	
	logic        ready_in;     // NEW: backpressure from DUT (1 = can accept)
	
	logic        valid_out;
	logic [3:0]  source_out;
	logic [3:0]  target_out;
	logic [7:0]  data_out;
endinterface
