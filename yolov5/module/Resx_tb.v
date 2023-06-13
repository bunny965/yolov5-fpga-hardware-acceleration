`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 11:31:25
// Design Name: 
// Module Name: Resx_tb
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


module Resx_tb();
parameter DATA_WIDTH = 16;
parameter D = 2; //Depth of image and filter
parameter H = 3; //Height of image
parameter W = 3; //Width of image
localparam F1 = 1; //Size of filter
localparam F2 = 3; //Size of filter
parameter K1 = 1; //Number of filters applied
localparam K2 = D; //Number of filters applied
parameter size1 = K1*(H-F1+1)*(W-F1+1);
parameter size2 = D*((H-F1+3)-F2+1)*((W-F1+3)-F2+1);//padding1
parameter beta =16'b0000000000000000;//0
parameter gama = 16'b0011110000000000;//1
parameter quarter = 16'b0011010000000000;//1/size
localparam channel1 = 1;
localparam channel2 = D;
localparam size_div_channel1 = size1/channel1;
localparam size_div_channel2 = size2/channel2;


reg clk, reset;
reg [D*H*W*DATA_WIDTH-1:0] x;
reg [K1*D*F1*F1*DATA_WIDTH-1:0] filters1;
reg [K2*K1*F2*F2*DATA_WIDTH-1:0] filters2;
wire  [DATA_WIDTH*size2-1:0] out;
wire [DATA_WIDTH*K1*(H-F1+1+2)*(W-F1+1+2)-1:0] out_temp2;
wire [DATA_WIDTH*size1-1:0] out_temp;
wire [DATA_WIDTH*size2-1:0] out_temp3;


integer i;
localparam PERIOD = 100;
always #(PERIOD/2) clk = ~clk;
initial begin
# 0 
reset <=1'b1;
clk<=1'b0;
//x<=64'b0110001001011011001010100110011010000100001011010110110110000011;
filters1<=32'b01000100011110001110101101111101;//
filters2<=288'b010111001100111111000010011001101101001101010110111111000100001111111101101111110001111101010100000001001110100110101100000001011101000110000101111001001001111000000100001101100000111001100000101000011110000000011101101000110111001110011000110101011101010100000011110100001101110010010111;//
x<=288'b001111111110000101001111010000100010110101100001101100001000111100111111001010110101101010011100110110101001100110110110111111111100010010000010111101101000110011001111010011110110010000110001011000011101110011110100001101001001000110000110110001101110111111100101101010001100001000011101;
//x<=256'b0000100011000110010111100001011010100101101111001111101100000011110011010100111001011100011011010101011011010111011010000001100110011101111110100111000100100101110101011110001010001101010001001001110110111010111011010111011010001000101100100110011010100111;
//filters<=288'b001111000000000000111100000000000011110000000000001111000000000000111100000000000011110000000000001111000000000000111100000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
# (PERIOD/2) reset<=1'b0;


# (100*PERIOD) 
    for(i=0;i<size1;i=i+1) $display("%b ",out_temp[i*DATA_WIDTH +: DATA_WIDTH]);
# (100*PERIOD) 
    $display("two!");
    for(i=0;i<K1*(H-F1+3)*(W-F1+3);i=i+1) $display("%b ",out_temp2[i*DATA_WIDTH +: DATA_WIDTH]);
# (100*PERIOD) 
        $display("three!");
        for(i=0;i<size2;i=i+1) $display("%b ",out_temp3[i*DATA_WIDTH +: DATA_WIDTH]);
# (100*PERIOD) 
        $display("four!");
        for(i=0;i<size2;i=i+1) $display("%b ",out[i*DATA_WIDTH +: DATA_WIDTH]);
	$stop;
end


Resx #(
.D(D),
.H(H),
.W(W),
.K1(K1),
.beta(beta),
.gama(gama),
.quarter(quarter)
)
r1 (clk,reset,x,filters1,filters2,out);
assign out_temp = r1.out_temp;
assign out_temp2 = r1.out_temp2;
assign out_temp3 = r1.out_temp3;
endmodule
