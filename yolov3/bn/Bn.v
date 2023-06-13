`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 10:44:18
// Design Name: 
// Module Name: Bn
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


module Bn(x,out,clk,reset);
localparam DATA_WIDTH = 16;
parameter size = 4;
parameter quarter = 16'b0011010000000000;
parameter channel = 1;
localparam size_div_channel = size/channel;

input clk,reset;
input wire [0:DATA_WIDTH*size_div_channel-1] x;
output wire [0:DATA_WIDTH*size_div_channel-1] out;
wire [DATA_WIDTH-1:0] squaresub,one_div_standardsub,AvgOut_temp;
wire [0:DATA_WIDTH*size_div_channel-1] x_sub_u;

x_sub_u #(.size(size),.DATA_WIDTH(DATA_WIDTH),.quarter(quarter),.channel(channel), .size_div_channel(size_div_channel)) fangcha (x,squaresub,AvgOut_temp,clk,reset);
Square_root s1 (squaresub,one_div_standardsub,clk,reset);
genvar i;
    generate 
        for(i=0;i<size_div_channel;i=i+1) begin
            floatAdd a1 (x[i*DATA_WIDTH+:DATA_WIDTH],AvgOut_temp,x_sub_u[i*DATA_WIDTH+:DATA_WIDTH]);
            floatMult m1 (x_sub_u[i*DATA_WIDTH+:DATA_WIDTH],one_div_standardsub,out[i*DATA_WIDTH+:DATA_WIDTH]);
        end
    endgenerate
endmodule
