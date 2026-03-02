interface port_if (input bit clk, input bit rst_n);

logic        valid_in;
logic [3:0]  source_in;
logic [3:0]  target_in;
logic [7:0]  data_in;

logic        ready_in;     // backpressure from DUT (1 = can accept)

logic        valid_out;
logic [3:0]  source_out;
logic [3:0]  target_out;
logic [7:0]  data_out;

//--------------------------------------------------------------------------
// Initialize TB-driven inputs to known values (important for gate-level)
//--------------------------------------------------------------------------
initial begin
  valid_in  = 1'b0;
  source_in = '0;
  target_in = '0;
  data_in   = '0;
end

//--------------------------------------------------------------------------
// Gate-level + SDF safe driver:
// - Wait for ready at posedge
// - Drive at negedge so setup is met for the next posedge
// - Hold stable across that posedge
// - Deassert at following negedge
//--------------------------------------------------------------------------
task drive_packet(input packet p);

  // Do not drive during reset
  wait (rst_n === 1'b1);

  // Wait until DUT is ready (sample ready on clock edge)
  do @(posedge clk); while (!ready_in);

  // Present inputs BEFORE the sampling edge
  @(negedge clk);
  valid_in  <= 1'b1;
  source_in <= p.source;
  target_in <= p.target;
  data_in   <= p.data;

  // Hold stable across the sampling edge
  @(posedge clk);

  // Deassert cleanly after sampling edge
  @(negedge clk);
  valid_in  <= 1'b0;

endtask

//--------------------------------------------------------------------------
// Monitor: sample output packet when valid_out is asserted at posedge
//--------------------------------------------------------------------------
task collect_packet(output packet p);
  wait (rst_n === 1'b1);
  @(posedge clk iff valid_out);
  p = new("monitored");
  p.source = source_out;
  p.target = target_out;
  p.data   = data_out;
endtask

endinterface
