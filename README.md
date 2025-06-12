# RISC-V Systems Programming Lab

This project is a collection of lab assignments aimed at building a foundational understanding of system-level programming on the RISC-V architecture. It includes low-level implementations of core operating system functionalities such as privilege mode management, timer-based multitasking, virtual memory, and page fault handling—all developed using RISC-V assembly.

## Table of Contents

- [Overview](#overview)
- [Lab Modules](#lab-modules)
- [Technologies Used](#technologies-used)
- [Setup & Usage](#setup--usage)

---

## Overview

Each lab explores a different aspect of computer architecture and systems programming by directly working with RISC-V assembly, Control and Status Registers (CSRs), memory-mapped I/O, and the privilege specification.

Key concepts covered:
- Mode transitions between Machine, Supervisor, and User modes
- Timer interrupts and cooperative context switching
- Virtual memory using Sv39 page tables
- Page fault detection and resolution
- C and assembly interoperability

---

## Lab Modules

### Lab 4: C and Assembly Interfacing
- Bidirectional function calls between C and assembly
- Handling string manipulations and memory access between languages

### Lab 5: Privilege Switching in RISC-V
- Implemented controlled switching between Machine, Supervisor, and User modes
- Handled exceptions using CSR-based trap handlers

### Lab 6: Timer Interrupts and Context Switching
- Simulated a multitasking environment using timer interrupts
- Saved/restored register state across tasks using a context switch routine

### Lab 7: Virtual Memory Management
- Set up hierarchical Sv39 page tables
- Switched execution from Machine → Supervisor → User mode using virtual addresses

### Lab 8: Handling Page Faults
- Caught and resolved instruction and data page faults dynamically
- Swapped in pages and updated the page table entries on-demand

---

## Technologies Used

- **RISC-V ISA** (RV64)
- **Assembly (RISC-V)** and **C**
- **Spike** (RISC-V ISA Simulator)
- **GNU Toolchain**: `riscv64-unknown-elf-gcc`, `objdump`
- **Bare-metal development** (no OS or runtime support)

---

## Setup & Usage

### Requirements

- RISC-V GCC Toolchain: [`riscv64-unknown-elf-gcc`](https://github.com/riscv-collab/riscv-gnu-toolchain)
- Spike simulator: [`spike`](https://github.com/riscv/riscv-isa-sim)

### Compilation & Execution

```bash
# Compile
riscv64-unknown-elf-gcc -nostartfiles -T linker.ld labX.S -o labX.out

# Run in Spike simulator
spike -d labX.out

