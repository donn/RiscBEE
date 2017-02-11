// file: Computer.v
// author: @karimio

`include "Computer/CleanInput.v"
`include "Computer/IO.v"

`timescale 1ns / 1ns

module Computer(clk, rst, segs, pos, switchIn);
	input clk, rst;
	input [7:0]switchIn;
	output [6:0]segs;
	output [3:0]pos;
	reg [1:0]clk_counter;

	wire [31:0]cleanSwitches;
	assign cleanSwitches[31:8] = 24'b0;
	Cleaner clean0(.clk(clk), .rst(rst), .sig(switchIn[0]), .stb(cleanSwitches[0]));
	Cleaner clean1(.clk(clk), .rst(rst), .sig(switchIn[1]), .stb(cleanSwitches[1]));
	Cleaner clean2(.clk(clk), .rst(rst), .sig(switchIn[2]), .stb(cleanSwitches[2]));
	Cleaner clean3(.clk(clk), .rst(rst), .sig(switchIn[3]), .stb(cleanSwitches[3]));
	Cleaner clean4(.clk(clk), .rst(rst), .sig(switchIn[4]), .stb(cleanSwitches[4]));
	Cleaner clean5(.clk(clk), .rst(rst), .sig(switchIn[5]), .stb(cleanSwitches[5]));	
	Cleaner clean6(.clk(clk), .rst(rst), .sig(switchIn[6]), .stb(cleanSwitches[6]));
	Cleaner clean7(.clk(clk), .rst(rst), .sig(switchIn[7]), .stb(cleanSwitches[7]));

	wire  [31:0]romaddr;
	wire	[31:0]romout;
	wire	[ 3:0]iobytes;
	wire	memwrite;
	wire	[ 3:0]writeEnables;
	
	wire	[31:0]memin, memout, memaddr;

	always @(posedge clk) begin
		if (rst)
			clk_counter <= 0;
		else
			clk_counter <= clk_counter + 1;	
	end
	
	CPU cpu(.clk(clk_counter[1]), .rst(rst),
    .memout(memout),
    .memwrite(memwrite),
    .memin(memin),
    .memaddr(memaddr),
    .romout(romout),
    .romaddr(romaddr),
    .iobytes(iobytes));
	 assign writeEnables = iobytes & {4{memwrite}};
	
	 wire [31:0]display;
	RAMmanager ram(.clk(clk_counter[1]), .levers(cleanSwitches), .display(display), .writeEnables(writeEnables), .memin(memin), .memaddr(memaddr), .memout(memout));
	ROMmanager rom(.clk(clk), .romaddr(romaddr), .romout(romout));
	Output	  out(.clk(clk_counter[1]), .rst(rst), .num(display), .segs(segs), .pos(pos));
endmodule
