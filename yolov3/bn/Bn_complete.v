`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 11:22:12
// Design Name: 
// Module Name: Bn_complete
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


module Bn_complete(x,out,clk,reset);
localparam DATA_WIDTH = 16;
parameter size = 4;
parameter beta =16'b0000000000000000;//0
parameter gama = 16'b0011110000000000;//1
parameter quarter = 16'b0011010000000000;
parameter channel = 1;
localparam size_div_channel = size/channel;

input clk,reset;
input wire [0:DATA_WIDTH*size_div_channel-1] x;
output wire [0:DATA_WIDTH*size_div_channel-1] out;
wire [0:DATA_WIDTH*size_div_channel-1] temp;
wire [0:DATA_WIDTH*size_div_channel-1] out_temp;

Bn  #(.size(size),.quarter(quarter), .channel(channel)) b1 (x,out_temp,clk,reset);
genvar i;
generate 
    for(i=0;i<(size_div_channel);i=i+1) begin
        floatMult m1 (gama,out_temp[i*DATA_WIDTH+:DATA_WIDTH],temp[i*DATA_WIDTH+:DATA_WIDTH]);
        floatAdd a1 (temp[i*DATA_WIDTH+:DATA_WIDTH],beta,out[i*DATA_WIDTH+:DATA_WIDTH]);
    end
endgenerate
endmodule
