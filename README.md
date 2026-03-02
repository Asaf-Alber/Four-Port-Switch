\# Packet Switch (SystemVerilog)



\## Overview

A packet switch design + verification project in SystemVerilog.



\## Repository Structure

\- `switch\_port.sv` – port logic

\- `switch\_4port.sv` – top-level 4-port switch

\- `switch\_test.sv` – test program

\- `tb\_cov.sv` – coverage/testbench logic

\- `agent.sv`, `driver.sv`, `checker.sv` – verification components

\- `Makefile` – run commands

\- `synthesis.pdf` / `switch.sdc` – synthesis constraints/report (if relevant)



\## How to Run

```bash

make

