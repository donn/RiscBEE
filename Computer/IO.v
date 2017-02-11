// file: IO.v
// author: @karimio

`include "IO.v"

`timescale 1ns / 1ns

module DisplayNumber(num, segs);
	input 		[3:0]num;
	output reg	[6:0]segs;
	
	always @(*) begin
		case (num)
			default: segs <= 6'b0000001;
			0: segs <= 7'b1000000;
			1: segs <= 7'b1111001;
			2: segs <= 7'b0100100;
			3: segs <= 7'b0110000;
			4: segs <= 7'b0011001;
			5: segs <= 7'b0010010;
			6: segs <= 7'b0000010;
			7: segs <= 7'b1111000;
			8: segs <= 7'b0000000;
			9: segs <= 7'b0011000;
			10: segs <= 7'b0001000;
			11: segs <= 7'b0000011;
			12: segs <= 7'b1000110;
			13: segs <= 7'b0100001;
			14: segs <= 7'b0000110;
			15: segs <= 7'b0001110;
		endcase
	end
endmodule

module Output(clk, rst, num, segs, pos);
	input clk, rst;
	input [31:0]num;
	output[ 6:0]segs;
	output reg[ 3:0]pos;
	
	reg [3:0]pass;
	DisplayNumber d(.num(pass), .segs(segs));
	
	reg [31:0]clk_counter;
	
	always @(posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
			pos <= 4'b1110;
			pass <= 0;
			clk_counter <= 0;
		end
		else begin
			clk_counter <= clk_counter + 1;
			if (clk_counter == 256) begin
				pos <= 4'b1101;
				pass <= num[7:4];
			end
			else if (clk_counter == 512) begin
				pos <= 4'b1011;
				pass <= num[11:8];
			end
			else if (clk_counter == 768) begin
				pos <= 4'b0111;
				pass <= num[16:12];
			end
			else if (clk_counter >= 1024) begin
				pos <= 4'b1110;
				pass <= num[3:0];
				clk_counter <= 0;
			end
		end
	end
endmodule
