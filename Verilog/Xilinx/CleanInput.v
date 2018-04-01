// file: CleanInput.v
// author: @karimio

`timescale 1ns / 1ns

module D_FF (clk, rst, D, Q);
    input clk, rst, D;
    output reg Q;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            //Reset logic goes here.
            Q <= 1'b0;
        end
        else begin
            //Sequential logic goes here.
            Q <= D;
        end
    end
endmodule

module Debouncer(clk, rst, sig, stb);
	input clk, rst, sig;
	output stb;

	wire q[1:0];

	D_FF f1(.clk(clk), .rst(rst), .D(sig),  .Q(q[0]));
	D_FF f2(.clk(clk), .rst(rst), .D(q[0]), .Q(stb));
	
endmodule

module Synchronizer(clk, rst, sig, stb);
	input clk, rst, sig;
	output stb;

	wire q[2:0];

	D_FF f1(.clk(clk), .rst(rst), .D(sig),  .Q(q[0]));
	D_FF f2(.clk(clk), .rst(rst), .D(q[0]), .Q(q[1]));

	assign stb = q[0] && q[1];
endmodule

module Cleaner(clk, rst, sig, stb);
	input clk, rst, sig;
	output stb;
	wire q;
	
	Debouncer		d(.clk(clk), .rst(rst), .sig(sig), .stb(q));
	Synchronizer	s(.clk(clk), .rst(rst), .sig(q),   .stb(stb));
	
endmodule
	