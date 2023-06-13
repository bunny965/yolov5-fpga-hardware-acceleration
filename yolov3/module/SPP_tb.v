`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 20:41:53
// Design Name: 
// Module Name: SPP_tb
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


module SPP_tb();
localparam DATA_WIDTH = 16;
parameter D = 1; //Depth of image and filter
parameter H = 1; //Height of image
parameter W = 1; //Width of image

parameter F1 = 1; //Size of filter
parameter K1 = 1; //Number of filters applied
localparam size1 = K1*(H-F1+1)*(W-F1+1);
parameter beta1 =16'b0000000000000000;//0
parameter gama1 = 16'b0011110000000000;//1
parameter quarter1 = 16'b0011010000000000;//1/size
localparam channel1 = K1;
localparam size_div_channel1 = size1/channel1;

localparam s1 =5;
localparam s2 =9;
localparam s3 =13;


localparam D2 = (K1*4); //Depth of image and filter
localparam H2 = (H-F1+1); //Height of image
localparam W2 = (W-F1+1); //Width of image

parameter F2 = 1; //Size of filter
parameter K2 = 1; //Number of filters applied
localparam size2 = K2*(H2-F2+1)*(W2-F2+1);
parameter beta2 =16'b0000000000000000;//0
parameter gama2 = 16'b0011110000000000;//1
parameter quarter2 = 16'b0011010000000000;//1/size
localparam channel2 = K1;
localparam size_div_channel2 = size2/channel2;



reg clk, reset;
reg [D*H*W*DATA_WIDTH-1:0] x;
reg [K1*D*F1*F1*DATA_WIDTH-1:0] filters1;
reg [K2*D2*F2*F2*DATA_WIDTH-1:0] filters2;
//wire [DATA_WIDTH*size2-1:0] out;
wire [size2*DATA_WIDTH-1:0] out;
wire [size1*DATA_WIDTH-1:0]out_m5,out_m9,out_m13,out_cbs1;

localparam PERIOD = 100;
always #(PERIOD/2) clk = ~clk;
integer i;
initial begin
# 0 
reset <=1'b1;
clk<=1'b0;
//x<=64'b0110001001011011001010100110011010000100001011010110110110000011;
filters1<=16'b1011100010110111;//
filters2<=64'b1001110110001110100110011000010100100001111110110010101110001101;//
//x<=64'b0011110000000000001111000000000000111100000000000011110000000000;
x<=16'b0011110000000000;
# (PERIOD/2) reset<=1'b0;
# (1000*PERIOD)
	$stop;
end

SPP UUT (clk,reset,x,filters1,filters2,out);
/*assign out_m5 = UUT.out_m5;
assign out_m9 = UUT.out_m9;
assign out_m13 = UUT.out_m13;
assign out_cbs1 = UUT.out_cbs1;*/


endmodule
