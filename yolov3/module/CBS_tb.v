`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 14:24:59
// Design Name: 
// Module Name: CBS_tb
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


module CBS_tb();
parameter DATA_WIDTH = 16;
parameter D = 1; //Depth of image and filter
parameter H = 4; //Height of image
parameter W = 4; //Width of image
parameter F = 3; //Size of filter
parameter K = 2; //Number of filters applied
parameter size = K*(H-F+1)*(W-F+1);
parameter beta =16'b0000000000000000;//0
parameter gama = 16'b0011110000000000;//1
parameter quarter = 16'b0010110000000000;
parameter channel = K;
parameter size_div_channel = 1;

integer i;
reg clk, reset;
reg [D*H*W*DATA_WIDTH-1:0] x;
reg [K*D*F*F*DATA_WIDTH-1:0] filters;
wire [DATA_WIDTH*size-1:0] out;
parameter PERIOD = 100;
always #(PERIOD/2) clk = ~clk;
wire [size*DATA_WIDTH-1:0] outputConv;
wire [DATA_WIDTH*size-1:0] out_bn;
wire [DATA_WIDTH*size-1:0] input_bn;

initial begin
# 0 
reset <=1'b1;
clk<=1'b0;
//x<=64'b0110001001011011001010100110011010000100001011010110110110000011;
//filters<=128'b01111110110110101110101000000110011011100001111001011011110111000011011110100111001011010100110011111100001100010001010101101000;//
x<=256'b0011110000000000_0011110000000000_0011110000000000_0011110000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0011110000000000_0000000000000000_0011110000000000_0000000000000000_0000000000000000_0011110000000000_0000000000000000_0011110000000000;
//x<=256'b0000100011000110010111100001011010100101101111001111101100000011110011010100111001011100011011010101011011010111011010000001100110011101111110100111000100100101110101011110001010001101010001001001110110111010111011010111011010001000101100100110011010100111;
filters<=288'b001111000000000000111100000000000011110000000000001111000000000000111100000000000011110000000000001111000000000000111100000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
# (PERIOD/2) reset<=1'b0;
# (10000*PERIOD) 
    for(i=0;i<size;i=i+1) $display("%b ",input_bn[i*DATA_WIDTH +: DATA_WIDTH]);
# (100*PERIOD) 
    $display("two!");
    for(i=0;i<size;i=i+1) $display("%b ",out_bn[i*DATA_WIDTH +: DATA_WIDTH]);
# (100*PERIOD) 
        $display("three!");
        for(i=0;i<size;i=i+1) $display("%b ",out[i*DATA_WIDTH +: DATA_WIDTH]);
	$stop;
end

CBS #(
.D(D),
.H(H),
.W(W),
.F(F),
.K(K),
.beta(beta),
.gama(gama),
.quarter(quarter)
)
c (clk,reset,x,filters,out);
assign outputConv = c.outputConv;
assign out_bn = c.out_bn;
assign input_bn= c.bn_input;


endmodule



