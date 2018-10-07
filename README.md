# RiscBEE
A Barry good RISC-V RV32i Verilog implementation.

(You can blame [@KarimIO](https://github.com/karimio) for the name and the slogan.)

It's a single-cycle RISC-V CPU with completely unaligned byte-addressable memory I/O.

(Though the program ROM is only word addressable.)

The Core and Computer are platform-agnostic, but some submodules and thus the final product was implemented on a Xilinx Nexys 3 FPGA.

RiscBEE is a sister project of [Oak.js](https://github.com/skyus/Oak.js).

**Note: The Chisel implementation is unfinished. The Phi implementation is syntactically valid but not semantically verified.**

# Usage
You can generate machine code with [Oak.js](https://skyus.github.io/Oak.js). To simulate, run CPU_tb.v. 

## Simulation
### Cloud V
[Cloud V](https://cloudv.io/) is a cloud-based digital design platform by our computer science and engineering department. To use it, create an account and clone https://cloudv.io/skyus/RiscBEE.

### IcarusVerilog and other simulators
You might need to manage includes and add dump statements to CPU_tb.v.

## FPGA Toolchains
### Xilinx ISE
Pool all files in **Computer**, **Core** and **Xilinx FPGA-specific**.

You will want to create a ucf file, as well.

### Other
You want to use **Computer**, **Core** and ***modify*** Xilinx FPGA-specific code to code that interfaces with your FPGA's memory resources and I/O.

# License
Mozilla Public License 2.0. Check 'LICENSE'.

## Licensing exception
[Until clarification by the UCB Berkeley Architecture Research team](https://github.com/ucb-bar/chisel-template/issues/27), the Chisel template is used under the GitHub license and is thus not A. free or open source and B. used outside of GitHub, and obviously does not fall under the Mozilla Public License version 2.0. 