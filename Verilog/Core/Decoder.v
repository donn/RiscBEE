// file: Decoder.v
// author: @skyus

`timescale 1ns/1ns

module Decoder(
    word,
    Z,
    C,
    N,
    V,
    rs1, 
    rs2, 
    rd,
    alu_op,
    imm_uj, 
    imm_u, 
    imm_i, 
    imm_s, 
    imm_sb,
    imm_sext,
    r,
    uj,
    u,
    u_control,
    i,
    s,
    sb,
    load_pc,
    mem_read,
    mem_read_sext,
    iobytes
);
input [31:0] word;
input Z, C, N, V;
output [4:0] rs1, rs2, rd;
output [31:0] imm_uj, imm_u, imm_i, imm_s, imm_sb;
output [3:0] alu_op; //last bit is add to sub, etc
output r, uj, u, u_control, i, s, sb;
output load_pc, mem_read, mem_read_sext, imm_sext;
output [3:0] iobytes;

wire arith, load_store;
wire [2:0] funct3;
wire condition, signed_comp;

assign funct3 = word[14:12];
assign u_control = (word[5]);
assign arith = (word[4:2] === 3'b100);
assign load_store = (word[4:2] === 3'b000) & ~word[6];
assign u = (word[4:2] === 3'b101);
assign uj = (word[4:2] === 3'b011);
assign r = arith & word[5];
assign i = (arith | load_store) & (~word[5]);
assign s = load_store & word[5] & ~word[6];
assign sb = load_store & word[6];

assign rd = word[11:7];
assign rs1 = word[19:15];
assign rs2 = word[24:20];

assign imm_uj = {{11{word[31]}}, word[31], word[19:12], word[20], word[30:21], 1'b0};
assign imm_u = {word[31:12], 12'b0};
assign imm_i = {{20{word[31]}}, word[31:20]};
assign imm_s = {{20{word[31]}}, word[31:25], word[11:7]};
assign imm_sb = {{19{word[31]}}, word[31], word[7], word[30:25], word[11:8], 1'b0};

assign signed_comp = (V)? ~N: N;
assign imm_sext = (arith & (funct3 === 3'b011));

Mux8 #(1) mux8(.A(Z), .B(~Z), .C(1'b0), .D(1'b0), .E(signed_comp), .F(~signed_comp), .G(N), .H(~N), .sel(funct3), .O(condition));

assign load_pc = (word[6] & condition) | (word[6] & word[2]);
assign alu_op = arith? { ((r | (funct3 === 3'b101)) & word[30]), funct3}: {~load_store, 3'b000};

Mux4 #(4) mux4(.A(4'b0001), .B(4'b0011), .C(4'b1111), .D(4'b0000), .sel(funct3[1:0]), .O(iobytes));

assign mem_read = load_store & ~(s);
assign mem_read_sext = ~funct3[2];

endmodule