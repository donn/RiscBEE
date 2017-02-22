//DISCLAIMER: THIS BARREL SHIFTER IS BROKEN.
`timescale 1ns/1ns

module BarrelShifter(A, O, shamt, arith, right);
    input [31:0] A;
    input [4:0] shamt;
    input arith, right;
    output [31:0] O;
    
    wire lastbit;
    assign lastbit = arith ? (right? A[0]: A[31]) : 1'b0;
    
    genvar i, j;
    wire [31:0] C [5:0];

    //Needs fixing.
    
    
endmodule 