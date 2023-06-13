`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/22 00:51:55
// Design Name: 
// Module Name: x_sub_u_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// dedao fangcha
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module x_sub_u_tb();
parameter DATA_WIDTH = 16;
parameter size = 4;
parameter quarter = 16'b0011010000000000;
parameter channel = 1;
parameter size_div_channel = 4;

reg clk, reset;
wire [DATA_WIDTH-1:0] AvgOut_temp,u1;
reg [DATA_WIDTH*size_div_channel-1:0] x;
wire [DATA_WIDTH-1:0] u_Out,a_out;
wire [DATA_WIDTH*size_div_channel-1:0] u1_2;
localparam PERIOD = 20;

always
	#(PERIOD/2) clk = ~clk;
initial begin
#0 
clk <= 1'b1;
reset <= 1'b1;
x<=64'h4000420044004500;
#(PERIOD)
	reset <= 1'b0;
#400
reset <= 1'b1;
 x<=64'hBC00C000C200C400;
 #(PERIOD)
     reset <= 1'b0;
#100 $stop;
end
x_sub_u b (x,u_Out,AvgOut_temp,clk,reset);
assign a_out=b.AvgOut;
assign u1_2=b.u1_2;
assign u1=b.u1;



endmodule
