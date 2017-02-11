// file: RippleCarryAdder.v
// author: @karimio

`timescale 1ns/1ns

module FullAdder(A, B, R, Cin, Cout);
    input A, B;
    input Cin;
    output R;
    output Cout;
    
    wire w0, w1, w2;
    xor xora(w0, A, B);
    xor xorb(R, w0, Cin);
    
    and anda(w1, A, B);
    and andb(w2, w0, Cin);
    or ora(Cout, w1, w2);
endmodule

module RippleCarryAdder(A, B, R, Cin, Cout, addSub);
    parameter N = 16;
    input [N-1:0] A, B;
    input Cin, addSub;
    output [N-1:0] R;
    output Cout;
    
    wire [N-1:0] W;
    assign W = addSub?~B:B;
    
    genvar i;
    wire [N-2:0] C;
    generate for (i = 0; i < N; i = i + 1) begin: bit
        if (i == 0)
            FullAdder fa(.A(A[0]), .B(W[0]), .R(R[0]), .Cin(Cin),    .Cout(C[0]));
        else if (i < N-1)
            FullAdder fa(.A(A[i]), .B(W[i]), .R(R[i]), .Cin(C[i-1]), .Cout(C[i]));
        else
            FullAdder fa(.A(A[i]), .B(W[i]), .R(R[i]), .Cin(C[i-1]), .Cout(Cout));
    end endgenerate
endmodule
