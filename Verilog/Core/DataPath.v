// file: DataPath.v
// author: @donn

`timescale 1ns/1ns

//Data then control signals then outputs
module DataPath(
    pc,
    clk,
    rst,
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
    memout,
    o,
    r,
    uj,
    u,
    u_control,
    i,
    s,
    sb,
    load_pc,
    memin,
    mem_read,
    mem_read_sext,
    iobytes,
    next_addr,
    Z,
    C,
    N,
    V
);
    input clk, rst;
    input [4:0] rs1, rs2, rd;
    input [3:0] alu_op;
    input [31:0] pc, imm_uj, imm_u, imm_i, imm_s, imm_sb, memout;
    input r, uj, u, u_control, i, s, sb, load_pc, mem_read, mem_read_sext, imm_sext;
    input [3:0] iobytes;
    output Z, C, N, V;
    output [31:0] o, memin, next_addr;
    
    wire [31:0] aData, bData, bAlu, memextb, memexth, memext, regwrite, ujext, iext, sext, sbext;
 
    assign bAlu = ({32{r | sb}} & bData) | ({32{i}} & imm_i) | ({32{s}} & imm_s);// | ({32{sb}} & imm_sb);
    
    ALU thing(.A(aData), .B(bAlu), .switch(alu_op[3]), .operation(alu_op[2:0]), .O(o), .Z(Z), .N(N), .C(C), .V(V));
    
    Extender #(8) memory(.isSigned(mem_read_sext), .in(memout), .out(memextb));
    Extender #(16) memory2(.isSigned(mem_read_sext), .in(memout), .out(memexth));
    
    Mux8 mux8(.A(memout), .B(memextb), .C(memout), .D(memexth), .E(memout), .F(memout), .G(memout), .H(memout), .sel(iobytes[2:0]), .O(memext));
    
    assign regwrite = mem_read? memext: ({32{u}} & (u_control? imm_u: imm_u + pc)) | ({32{uj}} & pc) | ({32{i}} & (load_pc? pc: o)) |  ({32{r}} & o);
    
    RegisterFile file(.clk(clk), .rst(rst), .Aaddress(rs1), .Baddress(rs2), .Daddress(rd), .Adata(aData), .Bdata(bData), .Ddata(regwrite), .write(~(sb | s)));
    
    assign next_addr = load_pc? (({32{u & (~u_control)}} & imm_u) | ({32{uj}} & imm_uj) | ({32{i}} & o) | ({32{sb}} & imm_sb)): 4;
    assign memin = bData;
    
endmodule