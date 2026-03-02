# ============================================================
# run.tcl - switch_4port - Fusion Compiler (Stage C)
# Two runs:
#   1) nocg : force NO ICG usage (dont_use + disable knobs)
#   2) cg   : enable clock gating (-gate_clock)
#
# Outputs:
#   reports_<tag>/
#   outputs_<tag>/
#   switch_<tag>.dlib
# ============================================================

puts "### RUN.TCL: switch_4port (nocg + cg) ###"
set_host_options -max_cores 4

# -----------------------------
# User settings (edit if needed)
# -----------------------------
set TOP       switch_4port
set THIS_DIR  [file normalize [file dirname [info script]]]
cd $THIS_DIR

set SDC_FILE  "$THIS_DIR/switch.sdc"

# RTL list (order is fine; SV compiler resolves dependencies, but keep consistent)
set RTL_LIST [list \
  "$THIS_DIR/port_if_synth.sv" \
  "$THIS_DIR/fifo.sv" \
  "$THIS_DIR/switch_port.sv" \
  "$THIS_DIR/switch_4port.sv" \
]

# Tech + libs
set TECH_FILE "/data/synopsys/lib/saed32nm/ref/tech/saed32nm_1p9m.tf"
set REF_LIBS  [list \
  /data/synopsys/lib/saed32nm/ref/CLIBs/saed32_rvt.ndm \
]

# TLU+
set TLU_CMAX  "/data/synopsys/lib/saed32nm/ref/tech/saed32nm_1p9m_Cmax.lv.tluplus"
set TLU_CMIN  "/data/synopsys/lib/saed32nm/ref/tech/saed32nm_1p9m_Cmin.lv.tluplus"
set LAYER_MAP "/data/synopsys/lib/saed32nm/ref/tech/saed32nm_tf_itf_tluplus.map"

# Floorplan
set CORE_UTIL  0.7
set SIDE_RATIO {1 1}
set CORE_OFF   2

# -----------------------------
# Sanity checks
# -----------------------------
foreach f $RTL_LIST {
  if {![file exists $f]} { puts "ERROR: Missing RTL: $f"; exit 1 }
}
if {![file exists $SDC_FILE]} { puts "ERROR: Missing SDC: $SDC_FILE"; exit 1 }

# -----------------------------
# Helpers
# -----------------------------
proc icg_count {} {
  set icgs [get_cells -hier -quiet -filter "is_integrated_clock_gating_cell==true"]
  return [sizeof_collection $icgs]
}

proc count_violated {fname} {
  if {![file exists $fname]} { return 0 }
  set fh [open $fname r]
  set txt [read $fh]
  close $fh
  return [llength [regexp -all -inline {VIOLATED} $txt]]
}

# Find a buffer libcell robustly (used for net-splitting)
proc pick_buf_cell {} {
  set pats [list "*BUF*X16*" "*BUF*X12*" "*BUF*X8*" "*BUF*X6*" "*BUF*X4*" "*BUF*X2*" "*BUF*X1*"]
  foreach p $pats {
    set lc [get_lib_cells -quiet $p]
    if {[sizeof_collection $lc] > 0} {
      set name [get_object_name [index_collection $lc 0]]
      puts "INFO: Using buffer libcell: $name"
      return $name
    }
  }
  puts "WARN: Could not find BUF* libcell in ref libs"
  return ""
}

# Try upsizing by X factor doubling (best-effort; no failure if not possible)
proc upsize_by_x {inst_name} {
  set c [get_cells -quiet $inst_name]
  if {[sizeof_collection $c] == 0} { return 0 }

  set ref [get_attribute $c ref_name]
  if {![regexp {^(.*)X([0-9]+)([^0-9]*)$} $ref -> base x suf]} {
    puts "WARN: $inst_name ref_name '$ref' not in *X<number>* form, skipping"
    return 0
  }

  set newx   [expr {$x * 2}]
  set newref "${base}X${newx}${suf}"

  set lc [get_lib_cells -quiet "*$newref"]
  if {[sizeof_collection $lc] == 0} {
    puts "WARN: No libcell found for $newref (from $ref), skipping"
    return 0
  }

  puts "INFO: Upsizing $inst_name : $ref -> $newref"
  catch { size_cell $inst_name $newref }
  return 1
}

# Force "NO CG" by preventing ICG libcell mapping
proc force_no_icg_libcells {} {
  # Prefer attribute-based identification
  set icg_lc [get_lib_cells -quiet -filter "is_integrated_clock_gating_cell==true"]
  puts "INFO: nocg: ICG libcells (attr) matched = [sizeof_collection $icg_lc]"

  if {[sizeof_collection $icg_lc] == 0} {
    # Fallback patterns (tool/lib naming varies)
    set icg_lc [get_lib_cells -quiet "*ICG*" "*CLKGAT*" "*CLKGATE*" "*GATECLK*" "*CLOCKGATE*"]
    puts "INFO: nocg: ICG libcells (name fallback) matched = [sizeof_collection $icg_lc]"
  }

  if {[sizeof_collection $icg_lc] > 0} {
    catch { set_dont_use $icg_lc }
    catch { set_attribute $icg_lc dont_use true }
  } else {
    puts "WARN: nocg: No ICG libcells found to dont_use. If ICG count is nonzero, report which cell was used."
  }

  # Disable insertion knobs (intent + safety)
  catch { set_app_options -name compile.clock_gating.enable            -value false }
  catch { set_app_options -name compile.sequential.clock_gating.enable -value false }
}

# Apply clock gating enable knobs (for cg run)
proc enable_clock_gating {} {
  catch { set_app_options -name compile.clock_gating.enable            -value true }
  catch { set_app_options -name compile.sequential.clock_gating.enable -value true }
}

# -----------------------------
# Main run procedure
# -----------------------------
proc do_run {tag enable_cg} {
  upvar 1 THIS_DIR    THIS_DIR
  upvar 1 TOP         TOP
  upvar 1 TECH_FILE   TECH_FILE
  upvar 1 REF_LIBS    REF_LIBS
  upvar 1 TLU_CMAX    TLU_CMAX
  upvar 1 TLU_CMIN    TLU_CMIN
  upvar 1 LAYER_MAP   LAYER_MAP
  upvar 1 RTL_LIST    RTL_LIST
  upvar 1 SDC_FILE    SDC_FILE
  upvar 1 CORE_UTIL   CORE_UTIL
  upvar 1 SIDE_RATIO  SIDE_RATIO
  upvar 1 CORE_OFF    CORE_OFF

  puts "============================================================"
  puts "START RUN: $tag   (clock gating = $enable_cg)"
  puts "============================================================"

  set DESIGNLIB "$THIS_DIR/switch_${tag}.dlib"
  set RPT_DIR   "$THIS_DIR/reports_${tag}"
  set OUT_DIR   "$THIS_DIR/outputs_${tag}"

  file delete -force $RPT_DIR
  file delete -force $OUT_DIR
  file delete -force $DESIGNLIB
  file mkdir $RPT_DIR
  file mkdir $OUT_DIR

  # Clean session state (safe with catch)
  catch { remove_blocks  -all }
  catch { remove_designs -all }

  # Library
  create_lib -technology $TECH_FILE -ref_libs $REF_LIBS $DESIGNLIB
  open_lib $DESIGNLIB
  report_ref_libs > "$RPT_DIR/ref_libs.rpt"

  # TLU+ import (correct form)
  read_parasitic_tech -tlup $TLU_CMAX -layermap $LAYER_MAP -name Cmax
  read_parasitic_tech -tlup $TLU_CMIN -layermap $LAYER_MAP -name Cmin

  # RTL
  analyze   -format sverilog $RTL_LIST
  elaborate $TOP
  set_top_module $TOP

  # Keep hierarchy stable unless you explicitly want auto-ungrouping
  set_app_options -name compile.flow.autoungroup -value false

  # MCMM reset + create
  catch { remove_corners   -all }
  catch { remove_modes     -all }
  catch { remove_scenarios -all }

  create_corner Fast
  create_corner Slow
  create_mode FUNC
  current_mode FUNC
  create_scenario -mode FUNC -corner Fast -name FUNC_Fast
  create_scenario -mode FUNC -corner Slow -name FUNC_Slow

  # Parasitics per-corner
  set_parasitic_parameters -early_spec Cmin -late_spec Cmin -corners {Fast}
  set_parasitic_parameters -early_spec Cmax -late_spec Cmax -corners {Slow}

  # Constraints per-scenario
  foreach sc {FUNC_Fast FUNC_Slow} {
    current_scenario $sc
    catch { remove_sdc -design }
    source -echo -verbose $SDC_FILE
  }

  # Floorplan
  set_auto_floorplan_constraints \
    -core_utilization $CORE_UTIL \
    -side_ratio       $SIDE_RATIO \
    -core_offset      $CORE_OFF

  # QoR knobs (safe)
  catch { set_app_options -name opt.buffering.enable -value true }
  catch { set_app_options -name opt.common.max_capacitance_effort -value high }
  catch { set_app_options -name opt.common.max_transition_effort  -value high }

  # Clock gating mode
  if {$enable_cg} {
    enable_clock_gating
  } else {
    force_no_icg_libcells
  }

  # Compile
  if {$enable_cg} {
    puts "INFO: compile_fusion WITH -gate_clock"
    compile_fusion -gate_clock -to logic_opto
    compile_fusion -to final_opto
  } else {
    puts "INFO: compile_fusion WITHOUT clock gating"
    compile_fusion -to logic_opto
    compile_fusion -to final_opto
  }

  # Optional CG-only fix: split a few heavy output nets (best-effort)
  if {$enable_cg} {
    set bufcell [pick_buf_cell]
    if {$bufcell ne ""} {
      set fix_nets [list \
        "port0.data_out[0]" \
        "port0.valid_out" \
        "port3.valid_out" \
      ]
      foreach n $fix_nets {
        set nn [get_nets -hier -quiet $n]
        if {[sizeof_collection $nn] == 0} {
          puts "WARN: Net not found: $n (skipping)"
          continue
        }
        puts "INFO: add_buffer on net $n"
        catch { add_buffer -net $nn -lib_cell $bufcell }
      }
    }
  }

  # Optional targeted upsizing (best-effort)
  set cap_fix_insts [list \
    HFSBUF_298_15011 \
    HFSBUF_979_14654 \
    HFSBUF_227_16094 \
    HFSBUF_57_16550 \
    HFSBUF_858_14677 \
    HFSBUF_263_13864 \
    HFSINV_613_15229 \
    HFSBUF_1243_22360 \
    HFSBUF_280_15706 \
  ]

  set fixed 0
  foreach inst $cap_fix_insts {
    if {[upsize_by_x $inst]} { incr fixed }
  }
  puts "INFO: $tag cap-fix upsized instances = $fixed"

  # Update timing for both scenarios
  foreach sc {FUNC_Fast FUNC_Slow} {
    current_scenario $sc
    catch { reset_timing }
    update_timing
  }

  # Constraint violators (Slow scenario is typically the one to attach)
  current_scenario FUNC_Slow
  redirect -file "$RPT_DIR/constraints_maxtran_FUNC_Slow.rpt" { report_constraints -all_violators -max_transition }
  redirect -file "$RPT_DIR/constraints_maxcap_FUNC_Slow.rpt"  { report_constraints -all_violators -max_capacitance }

  # Standard reports
  foreach sc {FUNC_Fast FUNC_Slow} {
    current_scenario $sc
    report_units                               > "$RPT_DIR/units_${sc}.rpt"
    report_clocks [get_clocks]                 > "$RPT_DIR/clocks_${sc}.rpt"
    report_qor                                 > "$RPT_DIR/qor_${sc}.rpt"
    report_timing -delay_type max -max_paths 20 -nosplit -path_type full > "$RPT_DIR/timing_max_${sc}.rpt"
    report_timing -delay_type min -max_paths 20 -nosplit -path_type full > "$RPT_DIR/timing_min_${sc}.rpt"
    report_area  -hierarchy                    > "$RPT_DIR/area_${sc}.rpt"
    report_power -hierarchy                    > "$RPT_DIR/power_${sc}.rpt"
  }

  if {$enable_cg} {
    report_clock_gating > "$RPT_DIR/clock_gating.rpt"
  }

  # Clean names before writing outputs (keeps verilog/sdf less painful)
  set_app_var bus_naming_style {%s_%d}
  define_name_rules CleanNames -allowed "A-Z a-z 0-9_" -replacement_char "_"
  change_names -rules CleanNames -hierarchy

  # Outputs
  write_verilog -hierarchy all "$OUT_DIR/${TOP}_gate.v"
  write_sdc    -output       "$OUT_DIR/${TOP}_out.sdc"
  write_sdf                 "$OUT_DIR/${TOP}.sdf"

  # End-of-run quick summary
  puts "INFO: $tag ICG count = [icg_count]"
  set n_tran [count_violated "$RPT_DIR/constraints_maxtran_FUNC_Slow.rpt"]
  set n_cap  [count_violated "$RPT_DIR/constraints_maxcap_FUNC_Slow.rpt"]
  puts "INFO: $tag max_transition VIOLATED count (Slow) = $n_tran"
  puts "INFO: $tag max_cap       VIOLATED count (Slow) = $n_cap"
  puts "DONE: $RPT_DIR  +  $OUT_DIR"
}

# -----------------------------
# Run both configurations
# -----------------------------
do_run nocg 0
do_run cg   1

puts "ALL DONE: reports_nocg/ and reports_cg/"
