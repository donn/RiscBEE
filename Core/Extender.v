// file: Extender.v
// author: @karimio

`timescale 1ns/1ns

module Extender(isSigned, in, out);
    parameter inputLength = 12;
    
    input [31:0] in;
    output [31:0] out;
    input isSigned;
    
    assign out = isSigned? {{(32 - inputLength){in[inputLength - 1]}}, in[inputLength - 1: 0]}: in;
endmodule