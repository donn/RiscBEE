// file: ALU.v
// author: @skyus

`timescale 1ns/1ns

module ALU(A, B, switch, operation, O, Z, N, C, V); //Z: Zero flag. N: Negative flag. C: Carry. V: Overflow. 
    input [2:0] operation;
    input [31:0] A, B;
    input switch;
    output [31:0] O;
    output Z, N, C, V;
    
    wire [31:0] add, sll, shift, slt, sltu, lxor, srl, lor, land;
    wire c, v;
    
    assign {c, add} = switch? A - B: A + B;
    assign v = c ^ (add[31] ^ A[31] ^ B[31]);
    assign {C, V} = (operation == 3'b000)? ({c, v}): (2'b00);
    assign sll = A << B[4:0];
    assign slt = ($signed(A) < ($signed(B))? 32'b1: 32'b0);
    assign sltu = ({0, A} < {0, B})? 32'b1: 32'b0;
    assign lxor = A ^ B;
    assign srl = switch? ($signed(A) >>> B[4:0]): A >> B[4:0];
    assign lor = A | B;
    assign land = A & B;
    
    
    //BarrelShifter a(.A(A), .O(shift), .shamt(B[4:0]), .arith(switch), .right(~operation[2]));
    //assign sll = shift;
    //assign srl = shift;
    
    Mux8 mux8(.A(add), .B(sll), .C(slt), .D(sltu), .E(lxor), .F(srl), .G(lor), .H(land), .sel(operation), .O(O));
    
    assign Z = (O == 32'b0)? 1'b1: 1'b0;
    assign N = O[31];
endmodule
