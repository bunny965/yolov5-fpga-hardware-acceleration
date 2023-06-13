`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 00:57:15
// Design Name: 
// Module Name: Silumulti
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


module Silumulti(x,reset,clk,product);
localparam DATA_WIDTH = 16;
parameter size = 4;
input signed [0:size*DATA_WIDTH-1] x;

input clk;
input reset;
output wire [0:size*DATA_WIDTH-1] product;

genvar i;
generate
    for(i=0;i<size;i=i+1) begin
        Silu s (x[i*DATA_WIDTH+:DATA_WIDTH],reset,clk,product[i*DATA_WIDTH+:DATA_WIDTH]);
    end
endgenerate

endmodule
