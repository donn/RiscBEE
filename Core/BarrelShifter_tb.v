 // file: BarrelShifter_tb.v
// author: @karimio
// Testbench for BarrelShifter

`include "BarrelShifter.v"

`timescale 1ns/1ns

module BarrelShifter_tb;

	//Inputs
	reg [31: 0] A;
	reg [4: 0] shamt;
	reg arith;
	reg right;


	//Outputs
	wire [31: 0] O;


	//Instantiation of Unit Under Test
	BarrelShifter uut (
		.A(A),
		.shamt(shamt),
		.arith(arith),
		.right(right),
		.O(O)
	);


	initial begin
	//Inputs initialization
		A = 32'b0100010110;
		shamt = 3;
		arith = 0;
		right = 1;


	//Wait for the reset
		#100;

	end

endmodule