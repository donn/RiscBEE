// file: DataMemory.v
// author: @skyus

`timescale 1ns/1ns

module DataMemory(
    clk,
    rst,
    addr,
    bytes,
    write,
    datain,
    dataout
);

parameter memSize = 1024;

input clk, rst, write;
input [3:0] bytes;
input [31:0] addr, datain;
output [31:0] dataout;

reg [7:0] storage [memSize - 1:0];
wire [memSize - 1: 0] naddr;

assign naddr = addr & memSize;

assign dataout = { storage[naddr + 3], storage[naddr + 2], storage[naddr + 1], storage[naddr + 0] };

integer ai;

always @ (posedge clk or rst) begin
    if (rst) begin
        for (ai = 0; ai < memSize; ai = ai + 1)
            storage[ai] <= 0;
    end
    else begin
        if (bytes[3])
            storage[ai + 3] <= datain[31:24];
        if (bytes[2])
            storage[ai + 2] <= datain[23:16];
        if (bytes[1])
            storage[ai + 2] <= datain[15:8];
        if (bytes[0])
            storage[ai + 2] <= datain[7:0];
    end
end

endmodule