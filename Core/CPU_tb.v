// file: CPU_tb.v
// author: @skyus
// Testbench for CPU

`include "Core/CPU.v"
`timescale 1ns/1ns

module CPU_tb;

	//Inputs
	reg clk;
	reg rst;
	reg [31: 0] memout;
	reg [31: 0] romout;


	//Outputs
	wire [31: 0] memin;
	wire [31: 0] memaddr;
	wire [31: 0] romaddr;
	wire [3: 0] iobytes;

    wire memwrite;

	//Instantiation of Unit Under Test
	CPU uut (
		.clk(clk),
		.rst(rst),
		.memout(memout),
		.romout(romout),
		.memin(memin),
		.memwrite(memwrite),
		.memaddr(memaddr),
		.romaddr(romaddr),
		.iobytes(iobytes)
	);

    always #5 clk = ~clk;
    
    reg [31:0] rom [15:0];
    
    initial begin
    //13 05 F0 40 23 20 A0 80 6F 00 00 00 
        rom[0] = 32'hfee69ee3;
    end
    
    always #1
    romout = rom[romaddr[5:2]];

	initial begin
	//Inputs initialization
		clk = 0;
		rst = 1;
		memout = 0;
		romout = 0;


	//Wait for the reset
		#101;
		rst = 0;
	end

endmodule