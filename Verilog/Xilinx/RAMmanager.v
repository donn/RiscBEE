// file: ROMmanager.v
// author: @karimio
// Note: This file black boxes Xilinx-based RAM.

`timescale 1ns / 1ns

module RAMmanager(clk, levers, display, writeEnables, memin, memaddr, memout);
	input clk;
	input [31:0]memaddr;
	input [31:0]memin;
	input [ 3:0]writeEnables;
	output[31:0]memout;
	
	input [31:0]levers;
	output reg [31:0]display;
	
	wire [ 3:0]finalWrite;
	wire [ 10:0]midAddr  [3:0];
	wire [ 8:0]finalAddr[3:0];
	wire [31:0]finalIn;
	wire [31:0]finalOut;
	wire [31:0]ramOut;
	
	Mux4 #(1) mw1(writeEnables[0], writeEnables[1], writeEnables[2], writeEnables[3], memaddr[1:0], finalWrite[0]);
	Mux4 #(1) mw2(writeEnables[1], writeEnables[2], writeEnables[3], writeEnables[0], memaddr[1:0], finalWrite[1]);
	Mux4 #(1) mw3(writeEnables[2], writeEnables[3], writeEnables[0], writeEnables[1], memaddr[1:0], finalWrite[2]);
	Mux4 #(1) mw4(writeEnables[3], writeEnables[0], writeEnables[1], writeEnables[2], memaddr[1:0], finalWrite[3]);
	
	wire enableLevers;
	wire enableDisplay;
	wire disableRam;
	assign enableLevers  = (memaddr==1028);
	assign enableDisplay = (memaddr==1024);
	assign disableRam		= enableLevers | enableDisplay;
	
	
	assign midAddr[0] = memaddr;
	assign midAddr[1] = memaddr + 1;
	assign midAddr[2] = memaddr + 2;
	assign midAddr[3] = memaddr + 3;
	
	assign finalAddr[0] = disableRam?(9'b0):midAddr[0][10:2];
	assign finalAddr[1] = disableRam?(9'b0):midAddr[1][10:2];
	assign finalAddr[2] = disableRam?(9'b0):midAddr[2][10:2];
	assign finalAddr[3] = disableRam?(9'b0):midAddr[3][10:2];
	
	Mux4 #(8) mi1(memin[7:0], memin[15:8], memin[23:16], memin[31:24], memaddr[1:0], finalIn[ 7: 0]);
	Mux4 #(8) mi2(memin[15:8], memin[23:16], memin[31:24], memin[7:0], memaddr[1:0], finalIn[15: 8]);
	Mux4 #(8) mi3(memin[23:16], memin[31:24], memin[7:0], memin[15:8], memaddr[1:0], finalIn[23:16]);
	Mux4 #(8) mi4(memin[31:24], memin[7:0], memin[15:8], memin[23:16], memaddr[1:0], finalIn[31:24]);

	fourBankRam ramA (
	  .clka(clk),
	  .wea(finalWrite[0]),
	  .addra(finalAddr[0]),
	  .dina(finalIn[7:0]),
	  .douta(ramOut[7:0])
	);
	
	fourBankRam ramB (
	  .clka(clk),
	  .wea(finalWrite[1]),
	  .addra(finalAddr[1]),
	  .dina(finalIn[15:8]),
	  .douta(ramOut[15:8])
	);
	
	fourBankRam ramC (
	  .clka(clk),
	  .wea(finalWrite[2]),
	  .addra(finalAddr[2]),
	  .dina(finalIn[23:16]),
	  .douta(ramOut[23:16])
	);
	
	fourBankRam ramD (
	  .clka(clk),
	  .wea(finalWrite[3]),
	  .addra(finalAddr[3]),
	  .dina(finalIn[31:24]),
	  .douta(ramOut[31:24])
	);
	
	Mux4 #(8) mo1(ramOut[7:0], ramOut[31:24], ramOut[23:16], ramOut[15:8], memaddr[1:0], finalOut[ 7: 0]);
	Mux4 #(8) mo2(ramOut[15:8], ramOut[7:0], ramOut[31:24], ramOut[23:16], memaddr[1:0], finalOut[15: 8]);
	Mux4 #(8) mo3(ramOut[23:16], ramOut[15:8], ramOut[7:0], ramOut[31:24], memaddr[1:0], finalOut[23:16]);
	Mux4 #(8) mo4(ramOut[31:24], ramOut[23:16], ramOut[15:8], ramOut[7:0], memaddr[1:0], finalOut[31:24]);
	
	Mux2 #(32) mfo(finalOut, levers, enableLevers, memout);
	
	always @(posedge clk) begin
		if (enableDisplay)
			display <= memin; 	
	end

endmodule
