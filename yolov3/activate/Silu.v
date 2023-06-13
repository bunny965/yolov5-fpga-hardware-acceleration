`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/20 15:50:17
// Design Name: 
// Module Name: Silu
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


module Silu(x,reset,clk,product);
localparam DATA_WIDTH = 16;
//assign coeff = 63'b0011100000000000_0011010000000000_1010010101010101_0001100001000100;
input signed [DATA_WIDTH-1:0] x;

input clk;
input reset;
output wire [15:0] product;
wire [DATA_WIDTH-1:0] temp;

Sigmoid s (x,reset,clk,temp);
floatMult m (x,temp,product);
endmodule
