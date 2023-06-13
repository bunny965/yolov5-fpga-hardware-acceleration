`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 08:58:09
// Design Name: 
// Module Name: compare
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module compare(numA,numB,max);
parameter DATA_WIDTH = 16;
input [DATA_WIDTH-1:0] numA,numB;
output reg [DATA_WIDTH-1:0] max;
wire flag;
assign flag = numA[15] ^ numB[15];
always @ (numA or numB or flag) begin
    if(flag==1'b1) begin
        if(numA[15]==1'b0) max <= numA;
        else max <= numB;
    end else begin
        if(numA[15]==1'b0) begin
            max <= numA>numB?numA:numB;
        end else begin
            max <= numA<numB?numA:numB;
        end
    end
end
endmodule
