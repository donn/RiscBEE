// file: ProgramCounter.v
// author: @karimio

`timescale 1ns/1ns

module ProgramCounter(clk, rst, next_addr, addr);
    parameter memorySize = 16;
	input clk, rst;
	input [31:0] next_addr;
	output reg [31:0] addr;
	
	always @ (posedge clk) begin
		if (rst)
			addr <= 32'b0;
		else
			addr <= addr + next_addr;
	end
endmodule
