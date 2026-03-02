# ============================================================
# Top-level testbench
# ============================================================
TOP = switch_test

# ============================================================
# Coverage Flags
# ============================================================
CM_FLAGS = -cm line+cond+fsm+tgl+branch+assert

# ============================================================
# Choose CUD (gate-level by default)
# ============================================================
CUD ?= build.cud

# ============================================================
# SDF locations (no fix step)
# ============================================================
SDF_FILE   ?= outputs_cg/switch_4port.sdf
SDF_INST   ?= $(TOP).dut
SDF_CORNER ?= typ

# ============================================================
# SAED32 Standard Cell Libraries (required for gate netlist)
# ============================================================
SAED_LIBS = \
  /data/synopsys/lib/SAED32_EDK/lib/stdcell_hvt/verilog/saed32nm_hvt.v \
  /data/synopsys/lib/SAED32_EDK/lib/stdcell_lvt/verilog/saed32nm_lvt.v \
  /data/synopsys/lib/SAED32_EDK/lib/stdcell_rvt/verilog/saed32nm.v

all: clean comp run report
test: comp run

clean:
	\rm -rf simv simv.daidir simv.vdb csrc *.log *.fsdb *.rc *.key \
	       verdi_config_file verdiLog *.conf coverage_rep urgReport

# ------------------------------------------------------------
# Compile (Gate-level + SDF back-annotation at build time)
# Note: your simv runtime does NOT accept -sdf, so do it here.
# ------------------------------------------------------------
comp:
	vcs $(SAED_LIBS) \
	    -f $(CUD) \
	    -sverilog -full64 -kdb +vcs+fsdbon \
	    -top $(TOP) \
	    +define+ASSERTIONS \
	    -assert svaext \
	    $(CM_FLAGS) -cm_dir simv.vdb \
	    +sdfverbose \
	    -sdf $(SDF_CORNER):$(SDF_INST):$(SDF_FILE)

# ------------------------------------------------------------
# Run (no -sdf here; ignored by simv in your setup)
# ------------------------------------------------------------
run:
	\rm -f novas.fsdb
	qrsh -V -cwd -b y -q normal ./simv -no_save \
	     $(CM_FLAGS) -cm_name test_run -cm_dir simv.vdb \
	     +vcs+asserton +fsdbfile+novas.fsdb 2>&1 | tee log

coverage:
	verdi -cov -covdir simv.vdb

report:
	urg -dir simv.vdb -format both -report coverage_rep
	@echo "Coverage report generated in directory: coverage_rep"

waveverdi:
	verdi -ssf novas.fsdb
