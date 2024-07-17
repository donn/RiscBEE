# RiscBEE
A Barry good RISC-V RV32i Verilog implementation.

(You can blame [@KarimIO](https://github.com/karimio) for the name and the slogan.)

It's a single-cycle RISC-V CPU with completely unaligned byte-addressable memory I/O.

(Though the program ROM is only word addressable.)

The Core and Computer are platform-agnostic, but some submodules and thus the final product was implemented on a Xilinx Nexys 3 FPGA.

RiscBEE is a sister project of [Oak.js](https://github.com/donn/Oak.js).

# Usage
You can generate machine code with [Oak.js](https://oak.js.org/). To simulate, run CPU_tb.v. 

## Simulation
```sh
iverilog Core/*.v Verification/CPU_tb.v
./a.out
```

## FPGA Toolchains
### Xilinx ISE
Pool all files in **Core** and **Xilinx**.

You will want to create a `.ucf` file, as well. I think we lost ours.

### Other
You want to use **Core**,and ***modify*** Xilinx FPGA-specific code to code that interfaces with your FPGA's memory resources and I/O.

# License
Mozilla Public License 2.0. Check 'LICENSE'.
