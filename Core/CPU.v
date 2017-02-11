// file: Processor.v
// author: @karimio

`include "Core/Decoder.v"
`include "Core/DataPath.v"
`include "Core/ProgramCounter.v"

`timescale 1ns/1ns

module CPU(
    clk,
    rst,
    memout,
    memwrite,
    memin,
    memaddr,
    romout,
    romaddr,
    iobytes
);


input clk, rst;
input [31:0] memout;
input [31:0] romout;

output memwrite;
output [31:0] memin;
output [31:0] memaddr;
output [31:0] romaddr;
output [3:0] iobytes;

wire Z, C, N, V;
wire [4:0] rs1, rs2, rd;
wire [31:0] imm_uj, imm_u, imm_i, imm_s, imm_sb, next_addr, o;
wire [3:0] alu_op; //last bit is add to sub, etc
wire r, uj, u, u_control, i, s, sb;
wire load_pc, mem_read, mem_read_sext, imm_sext;

assign memwrite = s;
assign memaddr = o;

ProgramCounter pc(.clk(clk), .rst(rst), .addr(romaddr), .next_addr(next_addr));

DataPath dp(.pc(romaddr), .clk(clk), .memin(memin), .next_addr(next_addr),  .rst(rst), .rs1(rs1), .rs2(rs2), .rd(rd), .alu_op(alu_op), .imm_uj(imm_uj), .imm_u(imm_u), .imm_i(imm_i), .imm_s(imm_s), .imm_sb(imm_sb), .memout(memout), .o(o), .r(r), .uj(uj), .u(u), .u_control(u_control), .i(i), .s(s), .sb(sb), .load_pc(load_pc), .mem_read(mem_read), .mem_read_sext(mem_read_sext), .iobytes(iobytes), .Z(Z), .C(C), .N(N), .V(V), .imm_sext(imm_sext));

Decoder dc(.word(romout), .Z(Z), .C(C), .N(N), .V(V), .rs1(rs1), .rs2(rs2), .rd(rd), .alu_op(alu_op), .imm_uj(imm_uj), .imm_u(imm_u), .imm_i(imm_i), .imm_s(imm_s), .imm_sb(imm_sb), .r(r), .uj(uj), .u(u), .u_control(u_control), .i(i), .s(s), .sb(sb), .load_pc(load_pc), .mem_read(mem_read), .mem_read_sext(mem_read_sext), .iobytes(iobytes), .imm_sext(imm_sext));


endmodule