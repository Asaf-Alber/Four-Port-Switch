################################################################################
#
# Design name:  switch_4port
#
# Created by fc write_sdc on Tue Jan 20 20:50:43 2026
#
################################################################################

set sdc_version 2.1
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA

################################################################################
#
# Units
# time_unit               : 1e-09
# resistance_unit         : 1000000
# capacitive_load_unit    : 1e-15
# voltage_unit            : 1
# current_unit            : 1e-06
# power_unit              : 1e-12
################################################################################


# Mode: FUNC
# Corner: Slow
# Scenario: FUNC_Slow

# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 3
create_clock -name clk -period 10 -waveform {0 5} [get_ports {clk}]
# Warning: Libcell power domain derates are skipped!

set_clock_uncertainty -setup 0.15 [get_clocks {clk}]
set_clock_uncertainty -hold 0.05 [get_clocks {clk}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_clk}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port0_clk}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_rst_n}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port0_rst_n}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_valid_in}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port0_valid_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_valid_in}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports {port0_valid_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_source_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_source_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_source_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_source_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_source_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_source_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_source_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_source_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_target_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_target_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_target_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_target_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_target_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_target_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_target_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_target_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[7]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_in[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[7]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_in[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[6]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_in[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[6]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_in[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[5]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_in[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[5]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_in[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[4]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_in[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[4]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_in[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_ready_in}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port0_ready_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_ready_in}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports {port0_ready_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_valid_out}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port0_valid_out}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_valid_out}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_valid_out}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_source_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_source_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_source_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_source_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_source_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_source_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_source_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_source_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_source_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_target_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_target_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_target_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_target_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_target_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_target_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_target_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_target_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_target_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_out[7]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_out[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_data_out[7]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_out[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_out[6]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_out[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_data_out[6]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_out[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_out[5]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_out[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_data_out[5]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_out[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_out[4]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_out[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_data_out[4]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_out[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_data_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_data_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_data_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port0_data_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port0_data_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port0_data_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port0_data_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_clk}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port1_clk}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_rst_n}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port1_rst_n}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_valid_in}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port1_valid_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_valid_in}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports {port1_valid_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_source_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_source_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_source_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_source_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_source_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_source_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_source_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_source_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_target_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_target_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_target_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_target_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_target_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_target_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_target_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_target_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[7]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_in[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[7]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_in[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[6]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_in[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[6]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_in[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[5]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_in[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[5]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_in[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[4]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_in[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[4]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_in[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_ready_in}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port1_ready_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_ready_in}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports {port1_ready_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_valid_out}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port1_valid_out}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_valid_out}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_valid_out}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_source_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_source_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_source_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_source_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_source_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_source_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_source_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_source_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_source_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_target_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_target_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_target_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_target_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_target_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_target_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_target_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_target_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_target_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_out[7]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_out[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_data_out[7]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_out[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_out[6]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_out[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_data_out[6]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_out[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_out[5]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_out[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_data_out[5]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_out[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_out[4]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_out[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_data_out[4]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_out[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_data_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_data_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_data_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port1_data_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port1_data_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port1_data_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port1_data_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_clk}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port2_clk}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_rst_n}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port2_rst_n}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_valid_in}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port2_valid_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_valid_in}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports {port2_valid_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_source_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_source_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_source_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_source_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_source_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_source_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_source_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_source_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_target_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_target_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_target_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_target_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_target_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_target_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_target_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_target_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[7]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_in[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[7]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_in[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[6]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_in[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[6]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_in[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[5]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_in[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[5]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_in[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[4]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_in[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[4]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_in[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_ready_in}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port2_ready_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_ready_in}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports {port2_ready_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_valid_out}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port2_valid_out}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_valid_out}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_valid_out}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_source_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_source_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_source_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_source_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_source_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_source_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_source_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_source_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_source_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_target_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_target_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_target_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_target_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_target_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_target_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_target_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_target_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_target_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_out[7]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_out[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_data_out[7]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_out[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_out[6]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_out[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_data_out[6]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_out[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_out[5]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_out[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_data_out[5]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_out[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_out[4]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_out[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_data_out[4]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_out[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_data_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_data_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_data_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port2_data_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port2_data_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port2_data_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port2_data_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_clk}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port3_clk}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_rst_n}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port3_rst_n}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_valid_in}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port3_valid_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_valid_in}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports {port3_valid_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_source_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_source_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_source_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_source_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_source_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_source_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_source_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_source_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_target_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_target_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_target_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_target_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_target_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_target_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_target_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_target_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[7]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_in[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[7]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_in[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[6]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_in[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[6]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_in[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[5]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_in[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[5]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_in[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[4]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_in[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[4]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_in[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_in[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_in[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_in[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_in[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_in[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_ready_in}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port3_ready_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_ready_in}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports {port3_ready_in}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_valid_out}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {port3_valid_out}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_valid_out}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_valid_out}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_source_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_source_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_source_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_source_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_source_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_source_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_source_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_source_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_source_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_target_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_target_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_target_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_target_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_target_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_target_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_target_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_target_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_target_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_out[7]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_out[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_data_out[7]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_out[7]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_out[6]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_out[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_data_out[6]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_out[6]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_out[5]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_out[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_data_out[5]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_out[5]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_out[4]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_out[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_data_out[4]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_out[4]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_out[3]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_data_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_out[3]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_out[2]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_data_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_out[2]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_out[1]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_data_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_out[1]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 16
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {port3_data_out[0]}]
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports \
    {port3_data_out[0]}]
# /project/verif/users/asafalber/ws/ex_vlsi_final_project/switch.sdc, line 22
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports \
    {port3_data_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 0.2 [get_ports \
    {port3_data_out[0]}]
set_max_capacitance 300 [get_ports {port0_clk}]
set_max_capacitance 300 [get_ports {port0_rst_n}]
set_max_capacitance 300 [get_ports {port0_valid_in}]
set_max_capacitance 300 [get_ports {port0_source_in[3]}]
set_max_capacitance 300 [get_ports {port0_source_in[2]}]
set_max_capacitance 300 [get_ports {port0_source_in[1]}]
set_max_capacitance 300 [get_ports {port0_source_in[0]}]
set_max_capacitance 300 [get_ports {port0_target_in[3]}]
set_max_capacitance 300 [get_ports {port0_target_in[2]}]
set_max_capacitance 300 [get_ports {port0_target_in[1]}]
set_max_capacitance 300 [get_ports {port0_target_in[0]}]
set_max_capacitance 300 [get_ports {port0_data_in[7]}]
set_max_capacitance 300 [get_ports {port0_data_in[6]}]
set_max_capacitance 300 [get_ports {port0_data_in[5]}]
set_max_capacitance 300 [get_ports {port0_data_in[4]}]
set_max_capacitance 300 [get_ports {port0_data_in[3]}]
set_max_capacitance 300 [get_ports {port0_data_in[2]}]
set_max_capacitance 300 [get_ports {port0_data_in[1]}]
set_max_capacitance 300 [get_ports {port0_data_in[0]}]
set_max_capacitance 300 [get_ports {port0_ready_in}]
set_max_capacitance 300 [get_ports {port0_valid_out}]
set_max_capacitance 300 [get_ports {port0_source_out[3]}]
set_max_capacitance 300 [get_ports {port0_source_out[2]}]
set_max_capacitance 300 [get_ports {port0_source_out[1]}]
set_max_capacitance 300 [get_ports {port0_source_out[0]}]
set_max_capacitance 300 [get_ports {port0_target_out[3]}]
set_max_capacitance 300 [get_ports {port0_target_out[2]}]
set_max_capacitance 300 [get_ports {port0_target_out[1]}]
set_max_capacitance 300 [get_ports {port0_target_out[0]}]
set_max_capacitance 300 [get_ports {port0_data_out[7]}]
set_max_capacitance 300 [get_ports {port0_data_out[6]}]
set_max_capacitance 300 [get_ports {port0_data_out[5]}]
set_max_capacitance 300 [get_ports {port0_data_out[4]}]
set_max_capacitance 300 [get_ports {port0_data_out[3]}]
set_max_capacitance 300 [get_ports {port0_data_out[2]}]
set_max_capacitance 300 [get_ports {port0_data_out[1]}]
set_max_capacitance 300 [get_ports {port0_data_out[0]}]
set_max_capacitance 300 [get_ports {port1_clk}]
set_max_capacitance 300 [get_ports {port1_rst_n}]
set_max_capacitance 300 [get_ports {port1_valid_in}]
set_max_capacitance 300 [get_ports {port1_source_in[3]}]
set_max_capacitance 300 [get_ports {port1_source_in[2]}]
set_max_capacitance 300 [get_ports {port1_source_in[1]}]
set_max_capacitance 300 [get_ports {port1_source_in[0]}]
set_max_capacitance 300 [get_ports {port1_target_in[3]}]
set_max_capacitance 300 [get_ports {port1_target_in[2]}]
set_max_capacitance 300 [get_ports {port1_target_in[1]}]
set_max_capacitance 300 [get_ports {port1_target_in[0]}]
set_max_capacitance 300 [get_ports {port1_data_in[7]}]
set_max_capacitance 300 [get_ports {port1_data_in[6]}]
set_max_capacitance 300 [get_ports {port1_data_in[5]}]
set_max_capacitance 300 [get_ports {port1_data_in[4]}]
set_max_capacitance 300 [get_ports {port1_data_in[3]}]
set_max_capacitance 300 [get_ports {port1_data_in[2]}]
set_max_capacitance 300 [get_ports {port1_data_in[1]}]
set_max_capacitance 300 [get_ports {port1_data_in[0]}]
set_max_capacitance 300 [get_ports {port1_ready_in}]
set_max_capacitance 300 [get_ports {port1_valid_out}]
set_max_capacitance 300 [get_ports {port1_source_out[3]}]
set_max_capacitance 300 [get_ports {port1_source_out[2]}]
set_max_capacitance 300 [get_ports {port1_source_out[1]}]
set_max_capacitance 300 [get_ports {port1_source_out[0]}]
set_max_capacitance 300 [get_ports {port1_target_out[3]}]
set_max_capacitance 300 [get_ports {port1_target_out[2]}]
set_max_capacitance 300 [get_ports {port1_target_out[1]}]
set_max_capacitance 300 [get_ports {port1_target_out[0]}]
set_max_capacitance 300 [get_ports {port1_data_out[7]}]
set_max_capacitance 300 [get_ports {port1_data_out[6]}]
set_max_capacitance 300 [get_ports {port1_data_out[5]}]
set_max_capacitance 300 [get_ports {port1_data_out[4]}]
set_max_capacitance 300 [get_ports {port1_data_out[3]}]
set_max_capacitance 300 [get_ports {port1_data_out[2]}]
set_max_capacitance 300 [get_ports {port1_data_out[1]}]
set_max_capacitance 300 [get_ports {port1_data_out[0]}]
set_max_capacitance 300 [get_ports {port2_clk}]
set_max_capacitance 300 [get_ports {port2_rst_n}]
set_max_capacitance 300 [get_ports {port2_valid_in}]
set_max_capacitance 300 [get_ports {port2_source_in[3]}]
set_max_capacitance 300 [get_ports {port2_source_in[2]}]
set_max_capacitance 300 [get_ports {port2_source_in[1]}]
set_max_capacitance 300 [get_ports {port2_source_in[0]}]
set_max_capacitance 300 [get_ports {port2_target_in[3]}]
set_max_capacitance 300 [get_ports {port2_target_in[2]}]
set_max_capacitance 300 [get_ports {port2_target_in[1]}]
set_max_capacitance 300 [get_ports {port2_target_in[0]}]
set_max_capacitance 300 [get_ports {port2_data_in[7]}]
set_max_capacitance 300 [get_ports {port2_data_in[6]}]
set_max_capacitance 300 [get_ports {port2_data_in[5]}]
set_max_capacitance 300 [get_ports {port2_data_in[4]}]
set_max_capacitance 300 [get_ports {port2_data_in[3]}]
set_max_capacitance 300 [get_ports {port2_data_in[2]}]
set_max_capacitance 300 [get_ports {port2_data_in[1]}]
set_max_capacitance 300 [get_ports {port2_data_in[0]}]
set_max_capacitance 300 [get_ports {port2_ready_in}]
set_max_capacitance 300 [get_ports {port2_valid_out}]
set_max_capacitance 300 [get_ports {port2_source_out[3]}]
set_max_capacitance 300 [get_ports {port2_source_out[2]}]
set_max_capacitance 300 [get_ports {port2_source_out[1]}]
set_max_capacitance 300 [get_ports {port2_source_out[0]}]
set_max_capacitance 300 [get_ports {port2_target_out[3]}]
set_max_capacitance 300 [get_ports {port2_target_out[2]}]
set_max_capacitance 300 [get_ports {port2_target_out[1]}]
set_max_capacitance 300 [get_ports {port2_target_out[0]}]
set_max_capacitance 300 [get_ports {port2_data_out[7]}]
set_max_capacitance 300 [get_ports {port2_data_out[6]}]
set_max_capacitance 300 [get_ports {port2_data_out[5]}]
set_max_capacitance 300 [get_ports {port2_data_out[4]}]
set_max_capacitance 300 [get_ports {port2_data_out[3]}]
set_max_capacitance 300 [get_ports {port2_data_out[2]}]
set_max_capacitance 300 [get_ports {port2_data_out[1]}]
set_max_capacitance 300 [get_ports {port2_data_out[0]}]
set_max_capacitance 300 [get_ports {port3_clk}]
set_max_capacitance 300 [get_ports {port3_rst_n}]
set_max_capacitance 300 [get_ports {port3_valid_in}]
set_max_capacitance 300 [get_ports {port3_source_in[3]}]
set_max_capacitance 300 [get_ports {port3_source_in[2]}]
set_max_capacitance 300 [get_ports {port3_source_in[1]}]
set_max_capacitance 300 [get_ports {port3_source_in[0]}]
set_max_capacitance 300 [get_ports {port3_target_in[3]}]
set_max_capacitance 300 [get_ports {port3_target_in[2]}]
set_max_capacitance 300 [get_ports {port3_target_in[1]}]
set_max_capacitance 300 [get_ports {port3_target_in[0]}]
set_max_capacitance 300 [get_ports {port3_data_in[7]}]
set_max_capacitance 300 [get_ports {port3_data_in[6]}]
set_max_capacitance 300 [get_ports {port3_data_in[5]}]
set_max_capacitance 300 [get_ports {port3_data_in[4]}]
set_max_capacitance 300 [get_ports {port3_data_in[3]}]
set_max_capacitance 300 [get_ports {port3_data_in[2]}]
set_max_capacitance 300 [get_ports {port3_data_in[1]}]
set_max_capacitance 300 [get_ports {port3_data_in[0]}]
set_max_capacitance 300 [get_ports {port3_ready_in}]
set_max_capacitance 300 [get_ports {port3_valid_out}]
set_max_capacitance 300 [get_ports {port3_source_out[3]}]
set_max_capacitance 300 [get_ports {port3_source_out[2]}]
set_max_capacitance 300 [get_ports {port3_source_out[1]}]
set_max_capacitance 300 [get_ports {port3_source_out[0]}]
set_max_capacitance 300 [get_ports {port3_target_out[3]}]
set_max_capacitance 300 [get_ports {port3_target_out[2]}]
set_max_capacitance 300 [get_ports {port3_target_out[1]}]
set_max_capacitance 300 [get_ports {port3_target_out[0]}]
set_max_capacitance 300 [get_ports {port3_data_out[7]}]
set_max_capacitance 300 [get_ports {port3_data_out[6]}]
set_max_capacitance 300 [get_ports {port3_data_out[5]}]
set_max_capacitance 300 [get_ports {port3_data_out[4]}]
set_max_capacitance 300 [get_ports {port3_data_out[3]}]
set_max_capacitance 300 [get_ports {port3_data_out[2]}]
set_max_capacitance 300 [get_ports {port3_data_out[1]}]
set_max_capacitance 300 [get_ports {port3_data_out[0]}]
