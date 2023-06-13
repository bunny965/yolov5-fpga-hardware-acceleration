`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/03 22:49:07
// Design Name: 
// Module Name: CSP1_1_tb
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


module CSP1_1_tb();
parameter DATA_WIDTH = 16;
parameter D = 3; //Depth of image and filter
parameter H = 4; //Height of image
parameter W = 4; //Width of image
parameter F = 3; //Size of filter
parameter cbs1_K = 2; //Number of filters applied
parameter cbs1_size = cbs1_K*(H-F+1)*(W-F+1);
parameter cbs1_beta =16'b0000000000000000;//0
parameter cbs1_gama = 16'b0011110000000000;//1
parameter cbs1_quarter = 16'b0011010000000000;//1/size
parameter cbs1_channel = cbs1_K;
localparam cbs1_size_div_channel = cbs1_size/cbs1_channel;
parameter cbs2_K = 2; //Number of filters applied
parameter cbs2_size = cbs2_K*(H-F+1)*(W-F+1);
parameter cbs2_beta =16'b0000000000000000;//0
parameter cbs2_gama = 16'b0011110000000000;//1
parameter cbs2_quarter = 16'b0011010000000000;//1/size
parameter cbs2_channel = cbs2_K;
localparam cbs2_size_div_channel = cbs2_size/cbs2_channel;

localparam  res_F1 = 1; //Size of filter
localparam  res_F2 = 3; //Size of filter
localparam res_D = cbs1_K; //Depth of image and filter
localparam res_H = H-F+1; //Height of image
localparam res_W = W-F+1; //Width of image
parameter res_K1 = 1; //Number of filters applied
parameter res_size1 = res_K1*(res_H-res_F1+1)*(res_W-res_F1+1);
parameter res_size2 = res_D*((res_H-res_F1+3)-res_F2+1)*((res_W-res_F1+3)-res_F2+1);//padding1
parameter res_beta =16'b0000000000000000;//0
parameter res_gama = 16'b0011110000000000;//1
parameter res_quarter1 = 16'b0011010000000000;//1/size
parameter res_quarter2 = 16'b0011010000000000;//1/size
localparam  res_K2 = cbs1_K; //Number of filters applied
localparam  res_channel1 =  res_K1;
localparam  res_channel2 = cbs1_K;
localparam  res_size_div_channel1 =  res_size1/ res_channel1;
localparam  res_size_div_channel2 =  res_size2/ res_channel2;

localparam cbso_D = (res_D+cbs2_K); //Depth of image and filter
localparam cbso_H = (H-F+1); //Height of image
localparam cbso_W = (W-F+1); //Width of image
parameter cbso_F = 1; //Size of filter
parameter cbso_K = 2; //Number of filters applied
localparam cbso_size = cbso_K*(cbso_H-cbso_F+1)*(cbso_W-cbso_F+1);
parameter cbso_beta =16'b0000000000000000;//0
parameter cbso_gama = 16'b0011110000000000;//1
parameter cbso_quarter = 16'b0011010000000000;//1/size
parameter cbso_channel = cbso_K;
localparam cbso_size_div_channel = cbso_size/cbso_channel;
reg clk, reset;
reg [D*H*W*DATA_WIDTH-1:0] x;
reg [cbs1_K*D*F*F*DATA_WIDTH-1:0] cbs1_filters;
reg [cbs2_K*D*F*F*DATA_WIDTH-1:0] cbs2_filters;
reg [cbso_K*cbso_D*cbso_F*cbso_F*DATA_WIDTH-1:0] cbso_filters;
reg [res_K1*res_D*res_F1*res_F1*DATA_WIDTH-1:0] res_filters1;
reg [res_K2*res_K1*res_F2*res_F2*DATA_WIDTH-1:0] res_filters2;
wire [DATA_WIDTH*cbso_size-1:0] out;
localparam PERIOD = 100;
integer i;
always #(PERIOD/2) clk = ~clk;
initial begin
#0 reset <=1'b1;
clk<=1'b0;
cbs1_filters<=864'b001111110101110111101010100010100111010011000000011101011101110111110010010101100111000110100111011000010010011011110110010000110000000101100110100110100001100100010000001111100011100101011011011100010101101110101010001000001001011000100011011100010000101000000101010001100110011000000000001001110011100111010111110110110111101010001110100100111110010010001110001111100101111010100111101000110010100101010111111000111101110100111110111010011110011001110111011110010010001111001010100101101011000100000101111011010010100001001100110001001010001101110101001011010110100111010000111100001100011011011011111101011110111101111111111111100101101100001100011110011000100000001110000001000101111010011111000000110100101101001100010110100011010011001100111110111111101111101110111111001010100110101100100111101000001010101111011111001100010100010010100000110111100100101101;
    cbs2_filters<=864'b101111111111111110010101001101000101011100000101111101110001011000001000011011111100010011100100110101001111001111011111111000000110111010111011101001001101001100111001100000111010101001110000010001000111100111100010110101001001000110100011011110010111110110010101000111010000110111111100101101011011111110110000011110100110100010111111001011000010111111001100000110001100010001111101001011010001011011111101001110100110101011110111001101110001110010010001111110000111001011011111000100111110110101000000001110110101010001111100110101101000011001111101011000010001001011010011110111100001101000101000101101011110111010000010011011101101010101001100101000101001101100010011000000111100010100010101000001110001101001101001000001000110100000010110111011000101111110110011100001010011100011111110011110011100010011100001101001000011000000001110000110011010111111111111;
    cbso_filters<=128'b01100110001110111010101100001001111010100011100011001110111100101010011000111101011010111001010001101010001101111100101100111011;
    res_filters1<=32'b11101110111110101010010000111111;
    res_filters2<=288'b000001110100010101001111110101100101101101010100100011101110000010100101100011111110011001101100100110101000001000001100110111100110010010110011001001111101000111001101010101100011100100101111100011100101110000111101011111110100100011100110101110100100100110101000101000110110000110111011;
    x<=768'b100000001000111000010100000011100001001010100110101110100100111011000001010000001100110001110010000000010010001011011100011100101110101111100100101111101000000110101000001101010011101000000000101101000111011111111110011000000010010100101110110000110000010001011111000011101110001001111101010010101110110110101101001100100011100011101110001100011001000000111101111010000000001110001010001010001100001110110010111100111000001110111011110000001011100000010101110001010100010011101011000011011011111000111011110010101000101010111001111111100100101011001110110000011100011100001100011101110101011100010001011000111110101001001011001001011011100010000100000011101101011101101000000111000110001000001101100000101101101110001110110110101110110100000100101110110000010100111011;
   # (PERIOD/2) reset<=1'b0;
   #(100*PERIOD)
    for(i=0;i<cbso_size;i=i+1) $display("%b ",out[i*DATA_WIDTH +: DATA_WIDTH]);
    $stop;
end
CSP1_1 UUT (clk,reset,x,cbs1_filters,res_filters1,res_filters2,cbs2_filters,cbso_filters,out);
endmodule
