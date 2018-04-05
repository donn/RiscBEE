// file: CPU_tb.v
// author: @skyus
// Testbench for CPU

`timescale 1ns/1ns

module CPU_tb;

	//Inputs
	reg clk;
	reg rst;
	reg [31: 0] memout;
	wire [31: 0] romout;

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
    /*
        lw s0, -4(sp)
        addi sp, sp, -4
        slli t0, s0, 16
        sw t0, -4(sp)
        addi sp, sp, -4
        lui s1, 0xFFFF0
        and t0, s0, s1
        sw t0, -4(sp)
        addi sp, sp, -4
        here: jal x0, here
    */
        rom[0] = 32'hFFC12403;
        rom[1] = 32'hFFC10113;
        rom[2] = 32'h01041293;
        rom[3] = 32'hFE512E23;
        rom[4] = 32'hFFC10113;
        rom[5] = 32'hFFFF04B7;
        rom[6] = 32'h009472B3;
        rom[7] = 32'hFE512E23;
        rom[8] = 32'hFFC10113;
        rom[9] = 32'h0000006F;
    end
    
    assign romout = rom[romaddr[5:2]];

	initial begin
	//Inputs initialization
		clk = 0;
		rst = 1;
		memout = 32'hABCD4321;


	//Wait for the reset
		#101;
		rst = 0;
	end

endmodule