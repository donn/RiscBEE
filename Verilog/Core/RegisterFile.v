// file: RegisterFile.v
// author: @donn

`timescale 1ns/1ns

module RegisterFile(clk, rst, Aaddress, Baddress, Daddress, Adata, Bdata, Ddata, write);
    parameter memorySize = 2048;
    input clk, rst, write;
    input [4:0] Aaddress, Baddress, Daddress;
    output [31:0] Adata, Bdata;
    input [31:0] Ddata;
    reg [31:0] bank [31:0];
    
    assign Adata = bank[Aaddress];
    assign Bdata = bank[Baddress];

    always @(posedge clk) begin
        if (rst) begin
            bank[0] <= 32'b0;
            bank[1] <= 32'b0;
            bank[2] <= memorySize;
            bank[3] <= 32'b0;
            bank[4] <= 32'b0;
            bank[5] <= 32'b0;
            bank[6] <= 32'b0;
            bank[7] <= 32'b0;
            bank[8] <= 32'b0;
            bank[9] <= 32'b0;
            bank[10] <= 32'b0;
            bank[11] <= 32'b0;
            bank[12] <= 32'b0;
            bank[13] <= 32'b0;
            bank[14] <= 32'b0;
            bank[15] <= 32'b0;
            bank[16] <= 32'b0;
            bank[17] <= 32'b0;
            bank[18] <= 32'b0;
            bank[19] <= 32'b0;
            bank[20] <= 32'b0;
            bank[21] <= 32'b0;
            bank[22] <= 32'b0;
            bank[23] <= 32'b0;
            bank[24] <= 32'b0;
            bank[25] <= 32'b0;
            bank[26] <= 32'b0;
            bank[27] <= 32'b0;
            bank[28] <= 32'b0;
            bank[29] <= 32'b0;
            bank[30] <= 32'b0;
            bank[31] <= 32'b0;
        end
        else begin
            if (write) begin
                bank[Daddress] <= Ddata;
                bank[0] <= 32'b0;
            end
        end
    end
endmodule