# Four-Port Packet Switch  
### RTL to Gate-Level Implementation (SystemVerilog)

---

## Project Overview

This project implements a complete **4-Port Packet Switch** in SystemVerilog, covering the full ASIC development flow:

- RTL Micro-Architecture Design  
- Constrained-Random Verification (CRV)  
- Assertion-Based Verification (SVA)  
- Functional and Code Coverage Closure  
- Logic Synthesis (Synopsys Design Compiler)  
- Clock Gating Optimization  
- Gate-Level Simulation with SDF Back-Annotation  

The switch routes packets between four ports using a 4-bit destination mask and supports:

- Unicast  
- Multicast  
- Broadcast  

---

# 1. RTL Architecture

## 1.1 System Architecture

The design follows an **Input-Buffered Switching Architecture**:

- Four independent input ports  
- Per-port synchronous FIFO (Depth = 8, FWFT)  
- Centralized Round-Robin arbitration  
- Non-blocking crossbar routing  
- Hardware backpressure enforcing a strict No-Drop policy  

Each port operates independently while arbitration resolves output contention fairly and deterministically.

---

## 1.2 Port Controller (`switch_port.sv`)

Each input port contains:

### FIFO
- Synchronous First-Word Fall-Through (FWFT) FIFO  
- 16-bit packet width  
- Depth of 8 entries  
- Immediate header visibility for arbitration (zero-cycle inspection latency)

### Flow Control

```systemverilog
ready_in = !fifo_full;

- Strict valid/ready handshake  
- Structurally prevents overflow  
- Guarantees zero packet loss  

### 4-State FSM

States:
- `IDLE`
- `RECEIVE`
- `ROUTE`
- `TRANSMIT`

```markdown
Multicast support is implemented using a dynamic target mask:

```systemverilog
remaining_targets <= remaining_targets & ~grant_in;

This enables partial multicast completion without head-of-line blocking.

### Reset Strategy
- Fully synchronous reset  
- Deterministic initialization  

---

## 1.3 Switch Core (`switch_4port.sv`)

### Legality Checking

Combinational logic detects:
- Self-loop packets (`source & target ≠ 0`)  
- Zero-target packets  

Illegal packets are flushed using a synthetic grant mechanism to prevent deadlock and buffer blocking.

---

### Arbitration

- One Round-Robin pointer per output port  
- Rotating priority after successful grant  
- Starvation-free under full contention  

Fairness verified under maximum concurrency conditions.

---

### Crossbar Routing

Implemented using `generate` blocks for scalability and synthesis compatibility.

Supports:
- Parallel independent transfers  
- Full-duplex operation  
- Non-blocking behavior for disjoint paths  

---

# 2. Transaction Model (`packet_data.sv`)

Packet structure:

- `source` – 4-bit one-hot encoded  
- `target` – 4-bit routing mask  
- `data` – 8-bit payload  
- `pkt_type` – SINGLE, MULTICAST, BROADCAST  

Features:

- Automatic one-hot encoding (`1 << port_index`)  
- Static packet tagging for traceability  
- Built-in protocol constraints  
- Deep-copy support for scoreboard integrity  
- Fully CRV-ready  

---

# 3. Verification Environment (Stage B)

A modular layered SystemVerilog verification architecture was implemented.

## 3.1 Environment Structure

- Sequencer (weighted constrained-random traffic generation)
- Driver (backpressure-aware protocol engine)
- Monitor (transaction reconstruction)
- Centralized Scoreboard (Delivery-Based Matching)
- Functional coverage
- Embedded SystemVerilog Assertions (SVA)

The structure follows a UVM-ready agent-based hierarchy.

---

## 3.2 Concurrency & Stress Testing

Driver uses a static semaphore:

```systemverilog
static semaphore drive_sem = new(4);
```

This enables all four ports to inject packets in the same clock cycle, generating maximum theoretical contention.

---

## 3.3 Scoreboard Strategy

Since multicast packets split into multiple output events:

- Four independent expected queues (one per output port)
- Matching based on `{Source, Data, Target_Bit}`
- Order-independent validation

This guarantees correctness regardless of arbitration reordering.

---

## 3.4 Dual-Phase Verification Strategy

### Phase 1 – Directed FIFO Saturation

- Forces FIFOs to FULL state  
- Validates backpressure logic  
- Confirms overflow protection  
- Proves structural No-Drop policy  

### Phase 2 – Constrained-Random Regression

Traffic distribution:
- 34% Unicast  
- 33% Multicast  
- 33% Broadcast  

All ports active simultaneously to maximize arbitration stress.

---

## 3.5 Verification Results

- 488 / 488 transactions matched  
- 0 mismatches  
- 100% Functional Coverage  
- 100% RTL Line Coverage  
- All SVA protocol checks passed  

Verified properties:

- No packet loss  
- No data corruption  
- No starvation  
- Fair arbitration under saturation  
- Correct recovery from mid-flight reset  

---

# 4. Synthesis & Physical Analysis (Stage C)

Technology: SAED 90nm / 32nm  
Tool: Synopsys Design Compiler  
Target Frequency: 100 MHz  

Two configurations evaluated:

- Baseline  
- Automatic Clock Gating  

---

## 4.1 Timing Results

| Configuration | Fmax | Worst Setup Slack | Worst Hold Slack |
|--------------|------|------------------|-----------------|
| Baseline | 363 MHz | +7.25 ns | +0.15 ns |
| Clock Gating | 352 MHz | +7.16 ns | +0.05 ns |

All constraints met with positive margins.

---

## 4.2 Area Optimization

Clock gating results:

- 13.6% area reduction  
- 26% leaf cell reduction  
- 41% combinational logic reduction  
- 98% gating efficiency  

Feedback multiplexers replaced with integrated clock gating cells.

---

## 4.3 Power Analysis

| Metric | Improvement (Clock Gating) |
|--------|---------------------------|
| Internal Power | -64% |
| Total Power | -41% |
| Leakage | -9% |

Power reduction achieved with negligible timing penalty.

---

## 4.4 Gate-Level Verification

- SDF back-annotation  
- Negative-edge stimulus driving for setup margin  
- Safe reset de-assertion strategy  
- Netlist wrapper for escaped hierarchy handling  

Full gate-level regression passed with zero mismatches.

---

# 5. Technical Skills Demonstrated

This project demonstrates proficiency in:

- RTL micro-architecture design  
- FSM design and protocol handling  
- Backpressure-based flow control  
- Arbitration algorithm implementation  
- Multicast routing logic  
- Assertion-based verification  
- Constrained-random verification methodology  
- Scoreboard architecture  
- Functional and code coverage closure  
- Clock gating optimization  
- Timing / Area / Power trade-off analysis  
- Gate-level simulation and SDF timing validation  

---

# 6. How to Run

## RTL Simulation

```bash
make
```

## Synthesis

```bash
dc_shell -f run.tcl
```

## Gate-Level Simulation

```bash
vcs +define+GLS ...
<<<<<<< HEAD
```
=======
```
>>>>>>> 8528adb (Final professional README)
