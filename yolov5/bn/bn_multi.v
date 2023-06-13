`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/29 15:29:32
// Design Name: 
// Module Name: bn_multi
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


module bn_multi(x,out,clk,reset);
localparam DATA_WIDTH = 16;
parameter size = 8;
parameter beta =16'b0000000000000000;//0
parameter gama = 16'b0011110000000000;//1
parameter quarter = 16'b0011010000000000;
parameter channel = 2;
localparam size_div_channel = size/channel;

input clk,reset;
input [0:DATA_WIDTH*size-1] x;
output wire [0:DATA_WIDTH*size-1] out;

genvar i;
generate

    for(i=0;i<channel;i=i+1) begin
        Bn_complete#(
            .size(size),
            .beta(beta),//0
            .gama(gama),//1
            .quarter(quarter),
            .channel(channel)) bn_c (x[i*size_div_channel*DATA_WIDTH+:size_div_channel*DATA_WIDTH],out[i*size_div_channel*DATA_WIDTH+:size_div_channel*DATA_WIDTH],clk,reset);
    end
endgenerate
endmodule
