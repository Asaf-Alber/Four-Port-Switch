# switch_4port.sdc

create_clock -name clk -period 10.0 [get_ports clk]
set_clock_uncertainty -setup 0.15 [get_clocks clk]
set_clock_uncertainty -hold  0.05 [get_clocks clk]

set in_ports [all_inputs]
set in_ports [remove_from_collection $in_ports [get_ports -quiet {clk rst_n}]]

set out_ports [all_outputs]

if {[sizeof_collection $in_ports] > 0} {
  set_input_delay -max 0.5 -clock clk $in_ports
  set_input_delay -min 0.0 -clock clk $in_ports
  set_max_capacitance 300.0 $in_ports
}

if {[sizeof_collection $out_ports] > 0} {
  set_output_delay -max 0.2 -clock clk $out_ports
  set_output_delay -min 0.0 -clock clk $out_ports
  set_max_capacitance 300.0 $out_ports
}

set cap_in_if_tgt   [get_ports -quiet -regexp {^port[0-3]\.target_in\[.*\]$}]
set cap_in_if_src   [get_ports -quiet -regexp {^port[0-3]\.source_in\[.*\]$}]
set cap_in_if_data  [get_ports -quiet -regexp {^port[0-3]\.data_in\[.*\]$}]
set cap_in_if_valid [get_ports -quiet -regexp {^port[0-3]\.valid_in$}]

set cap_in_if $cap_in_if_tgt
set cap_in_if [add_to_collection $cap_in_if $cap_in_if_src]
set cap_in_if [add_to_collection $cap_in_if $cap_in_if_data]
set cap_in_if [add_to_collection $cap_in_if $cap_in_if_valid]

if {[sizeof_collection $cap_in_if] > 0} {
  set_max_capacitance 300.0 $cap_in_if
}

set cap_out_if_valid [get_ports -quiet -regexp {^port[0-3]\.valid_out$}]
set cap_out_if_data  [get_ports -quiet -regexp {^port[0-3]\.data_out\[.*\]$}]

set cap_out_if $cap_out_if_valid
set cap_out_if [add_to_collection $cap_out_if $cap_out_if_data]

if {[sizeof_collection $cap_out_if] > 0} {
  set_max_capacitance 300.0 $cap_out_if
}
