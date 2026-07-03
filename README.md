# RISC-V-Pipelined-Processor
## Overview

This project implements a pipelined RISC-V architecture with the following stages:

- **Instruction Fetch (IF)**
- **Instruction Decode (ID)**
- **Execute (EX)**
- **Memory Access (MEM)**
- **Write Back (WB)**

The processor is designed to execute basic arithmetic, immediate, load, and branch instructions while maintaining pipeline synchronization.

---
## Features

- 32-bit RISC-V processor implementation
- 5-stage pipelined architecture
- Separate instruction and data memory
- Register file with write-back support
- ALU for arithmetic and logical operations
- Immediate generation unit
- Branch target computation
- Pipeline registers between all stages
- Data hazard resolution using forwarding logic
- RTL verification using Xilinx Vivado

---
## Pipeline Architecture

```text
IF → ID → EX → MEM → WB
```

### Stage Description

### 1. Fetch Stage
- Program Counter (PC)
- Instruction Memory
- PC+4 generation
- Branch MUX

### 2. Decode Stage
- Control Unit
- Register File
- Immediate Generator

### 3. Execute Stage
- ALU
- Operand forwarding
- Branch calculation
- ALU source selection

### 4. Memory Stage
- Data memory read/write

### 5. Writeback Stage
- Result selection
- Register file write-back

---

## Hazard Handling

To resolve **Read After Write (RAW)** hazards, forwarding logic is implemented.

### Forwarding paths:
- **MEM → EX**
- **WB → EX**

### Forwarding control:

```text
00 → No forwarding
01 → Forward from Writeback stage
10 → Forward from Memory stage
```

---
## Simulation

Simulation was performed using:

- Xilinx Vivado
- Behavioral Simulation

Waveforms verified:
- Fetch stage operation
- Decode stage register reads
- Execute stage ALU computation
- Memory read/write
- Writeback result generation
- Hazard forwarding behavior

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- GitHub

---

