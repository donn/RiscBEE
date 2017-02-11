# RiscBEE
A Barry good RISC-V RV32i Verilog implementation.

(You can blame [@KarimIO](https://github.com/karimio) for the name and the slogan.)

It's a single-cycle RISC-V CPU with completely unaligned byte-addressable memory I/O.

(Though the program ROM is only word addressable and so is memory-mapped I/O).

The Core and parts of the Computer are platform-agnostic, but the final product was implemented on a Xilinx Nexys 3 FPGA.

RiscBEE is a sister project of [Oak.js](https://github.com/skyus/Oak.js).

# Usage
You can generate machine code with [Oak.js](https://skyus.github.io/Oak.js). 

## Simulators
For all simulators, you just wanna use the files in **Core**. Simulate CPU_tb.v.

### CloudV
[CloudV](https://cloudv.io/) is a cloud-based simulator and (WIP synthesizer) our CSCE department is working on. To use it, upload all files in Core and comment out all `include statements, then simulate CPU_tb.v.

## FPGA Toolchains
Comment out all `include statements.

### Xilinx ISE
Comment out all `include statements, pool all files in **Computer**, **Core** and **Xilinx FPGA-specific**.

You will want to create a ucf file, as well.

To create a coe file easily, you can use the file Scripts/xilinxcoe.js.

### Other
Not sure what you should do about the `include statements, but you want to use **Computer**, **Core** and ***modify*** Xilinx FPGA-specific code to code that interfaces with your FPGA's memory resources and I/O.

# License
Mozilla Public License 2.0. Check 'LICENSE'.