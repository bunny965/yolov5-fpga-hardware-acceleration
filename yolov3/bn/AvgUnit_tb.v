`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/27 00:23:28
// Design Name: 
// Module Name: AvgUnit_tb
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


module AvgUnit_tb();
parameter DATA_WIDTH = 16;
parameter quarter = 16'b0011010000000000;
parameter size = 4;

reg clk, reset;
reg [DATA_WIDTH*size-1:0] x;
wire [DATA_WIDTH-1:0] AvgOut,sum;
wire [DATA_WIDTH-1:0] add;

localparam PERIOD = 20;

always
	#(PERIOD/2) clk = ~clk;
	
initial begin
# 0 
clk <= 1'b1;
reset <= 1'b1;
x <= 64'h3C00400042004400;
#(PERIOD)
	reset <= 1'b0;
#400
reset <= 1'b1;
x <= 64'h4000420044004500;
#(PERIOD)
	reset <= 1'b0;
#400
$stop;
end
AvgUnit   a (x,AvgOut,clk,reset);
assign add = a.add;
assign sum = a.sum;

endmodule
