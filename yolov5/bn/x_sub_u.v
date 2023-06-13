`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/22 00:26:13
// Design Name: 
// Module Name: x_sub_u
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// get ·½²î
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module x_sub_u(x,u_Out,AvgOut_temp,clk,reset);
parameter DATA_WIDTH = 16;
parameter size = 4;
parameter quarter = 16'b0011010000000000;
parameter channel = 1;
parameter size_div_channel = size/channel;

input clk,reset;
input [DATA_WIDTH*size_div_channel-1:0] x;
output [DATA_WIDTH-1:0] u_Out;
wire [DATA_WIDTH-1:0] AvgOut;
output reg [DATA_WIDTH-1:0] AvgOut_temp;
wire [DATA_WIDTH*size_div_channel-1:0] u1_2,u1;

AvgUnit #(.DATA_WIDTH(DATA_WIDTH),.size(size),.quarter(quarter),.channel(channel), .size_div_channel(size_div_channel)) avg (x,AvgOut,clk,reset);
always @ (AvgOut)  begin
 AvgOut_temp[15] <= ~AvgOut[15];
 AvgOut_temp[14:0] <= AvgOut[14:0];
end
genvar i;
generate
for(i=0;i<size_div_channel;i=i+1) begin
floatAdd a1 (x[i*DATA_WIDTH+:DATA_WIDTH],AvgOut_temp,u1[i*DATA_WIDTH+:DATA_WIDTH]);
floatMult m1 (u1[i*DATA_WIDTH+:DATA_WIDTH],u1[i*DATA_WIDTH+:DATA_WIDTH],u1_2[i*DATA_WIDTH+:DATA_WIDTH]);
end
endgenerate
AvgUnit#(.DATA_WIDTH(DATA_WIDTH),.size(size),.quarter(quarter),.channel(channel), .size_div_channel(size_div_channel)) avg2 (u1_2,u_Out,clk,reset);

endmodule
