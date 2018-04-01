// file: ROMmanager.v
// author: @karimio
// Note: This file black boxes Xilinx-based ROM.

`timescale 1ns / 1ns

module ROMmanager(clk, romaddr, romout);
	input  clk;
	input  [31:0]romaddr;
	output [31:0]romout;
	ROM rom (
	  .clka(clk),
	  .addra(romaddr[8:2]),
	  .douta(romout)
	);

endmodule
