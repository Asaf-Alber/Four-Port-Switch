Four-Port Packet Switch – RTL to Gate-Level Implementation
Project Summary

This project implements a complete 4-Port Packet Switch in SystemVerilog, covering the full ASIC development flow:

RTL Micro-Architecture Design

Constrained-Random Verification (CRV)

Assertion-Based Verification (SVA)

Functional & Code Coverage Closure

Logic Synthesis (Design Compiler)

Clock Gating Optimization

Gate-Level Simulation with SDF Back-Annotation

The switch routes packets between four ports using a 4-bit destination mask and supports Unicast, Multicast, and Broadcast traffic.

1. RTL Architecture
1.1 System Overview

The design follows an Input-Buffered Architecture:

4 independent input ports

Per-port synchronous FIFO (Depth=8, FWFT)

Centralized Round-Robin arbiter

Non-blocking crossbar routing

Hardware backpressure (No-Drop policy)

Each port operates independently while arbitration resolves output contention fairly.

1.2 Port Controller (switch_port.sv)

Each input port includes:

FIFO

Synchronous FWFT FIFO (16-bit width, depth=8)

Header available immediately for arbitration (zero-cycle inspection latency)

Flow Control

ready_in = !fifo_full

Implements strict valid/ready handshake

Prevents overflow structurally (no packet loss possible)

4-State FSM

IDLE

RECEIVE

ROUTE

TRANSMIT

Multicast support is implemented using a dynamic remaining_targets mask:

remaining_targets <= remaining_targets & ~grant_in;

This enables partial multicast completion without head-of-line blocking.

Reset Strategy

Fully synchronous reset

Deterministic initialization

1.3 Switch Core (switch_4port.sv)
Legality Checking

Combinational logic detects:

Self-loop packets (source & target ≠ 0)

Zero-target packets

Illegal packets are flushed using a synthetic grant to prevent deadlock.

Arbitration

One Round-Robin pointer per output port

Rotating priority after successful grant

Starvation-free under full contention

Fairness verified under maximum concurrency.

Crossbar Routing

Implemented using generate blocks for scalability and synthesis compatibility.

Supports:

Parallel independent transfers

Full-duplex operation

Non-blocking behavior for disjoint paths

2. Transaction Model

Defined in packet_data.sv.

Fields:

source (4-bit one-hot)

target (4-bit mask)

data (8-bit payload)

pkt_type (SINGLE, MULTICAST, BROADCAST)

Features:

Automatic one-hot encoding (1 << port_index)

Static packet tagging for traceability

Protocol constraints for CRV readiness

Deep-copy support for scoreboard integrity

3. Verification Environment (Stage B)

A modular, layered SystemVerilog environment was implemented.

3.1 Architecture

Sequencer (weighted constrained-random traffic)

Driver (backpressure-aware protocol engine)

Monitor (transaction reconstruction)

Centralized Scoreboard (Delivery-Based Matching)

Functional coverage

Embedded SVA assertions

The structure is UVM-ready (agent-based hierarchy).

3.2 Concurrency & Stress Testing

Driver uses a static semaphore:

static semaphore drive_sem = new(4);

This allows all four ports to inject traffic in the same cycle, generating maximum theoretical contention.

3.3 Scoreboard Strategy

Since multicast packets split into multiple output events:

Four independent expected queues (one per output)

Matching based on {Source, Data, Target_Bit}

Order-independent validation

This guarantees correctness regardless of arbitration reordering.

3.4 Dual-Phase Verification Strategy
Phase 1 – Directed FIFO Saturation

Forces all FIFOs to FULL state and validates:

Backpressure behavior

No-drop policy

Overflow protection

Phase 2 – Constrained-Random Regression

Traffic mix:

34% Unicast

33% Multicast

33% Broadcast

All ports active simultaneously.

3.5 Results

488 / 488 transactions matched

0 mismatches

100% Functional Coverage

100% RTL Line Coverage

All SVA protocol checks passed

Verified properties:

No packet loss

No corruption

No starvation

Fair arbitration under saturation

Correct recovery from mid-flight reset

4. Synthesis & Physical Analysis (Stage C)

Technology: SAED 90nm/32nm
Tool: Synopsys Design Compiler
Target Frequency: 100 MHz

Two configurations evaluated:

Baseline

Automatic Clock Gating

4.1 Timing Results
Configuration	Fmax	Worst Setup Slack	Worst Hold Slack
Baseline	363 MHz	+7.25 ns	+0.15 ns
Clock Gating	352 MHz	+7.16 ns	+0.05 ns

All constraints met with positive margins.

4.2 Area Optimization

Clock gating results:

13.6% area reduction

26% leaf cell reduction

41% combinational logic reduction

98% gating efficiency

Feedback muxes removed in favor of integrated clock gating cells.

4.3 Power Analysis
Metric	Improvement (Clock Gating)
Internal Power	-64%
Total Power	-41%
Leakage	-9%

Power reduction achieved with negligible timing penalty.

4.4 Gate-Level Verification

SDF back-annotation

Negative-edge stimulus driving for setup margin

Safe reset de-assertion strategy

Netlist wrapper for escaped hierarchy handling

Gate-Level regression passed with zero mismatches.

5. Technical Highlights

This project demonstrates:

RTL micro-architecture design

FSM design & formal protocol handling

Backpressure-based flow control

Arbitration algorithm design

Multicast routing logic

Assertion-based verification

Constrained-random verification methodology

Scoreboard architecture

Functional & code coverage closure

Clock gating optimization

Timing/Area/Power trade-off analysis

Gate-level simulation and SDF timing validation

6. How to Run

RTL Simulation:

make

Synthesis:

dc_shell -f run.tcl

Gate-Level Simulation:

vcs +define+GLS ...
