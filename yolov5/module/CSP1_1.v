`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/03 16:51:11
// Design Name: 
// Module Name: CSP1_1
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


module CSP1_1(clk,reset,x,cbs1_filters,res_filters1,res_filters2,cbs2_filters,cbso_filters,out);
localparam DATA_WIDTH = 16;
parameter D = 3; //Depth of image and filter
parameter H = 4; //Height of image
parameter W = 4; //Width of image
parameter F = 3; //Size of filter
parameter cbs1_s=1;
parameter cbs1_K = 2; //Number of filters applied
localparam cbs1_size = cbs1_K*((H-F)/cbs1_s+1)*((W-F)/cbs1_s+1);
parameter cbs1_beta =16'b0000000000000000;//0
parameter cbs1_gama = 16'b0011110000000000;//1
parameter cbs1_quarter = 16'b0011010000000000;//1/size
localparam cbs1_channel = cbs1_K;
localparam cbs1_size_div_channel = cbs1_size/cbs1_channel;
parameter cbs2_s=1;
parameter cbs2_K = 2; //Number of filters applied
localparam cbs2_size = cbs2_K*((H-F)/cbs2_s+1)*((W-F)/cbs2_s+1);
parameter cbs2_beta =16'b0000000000000000;//0
parameter cbs2_gama = 16'b0011110000000000;//1
parameter cbs2_quarter = 16'b0011010000000000;//1/size
localparam cbs2_channel = cbs2_K;
localparam cbs2_size_div_channel = cbs2_size/cbs2_channel;

parameter res_s1=1;
parameter res_s2=1;
localparam  res_F1 = 1; //Size of filter
localparam  res_F2 = 3; //Size of filter
localparam res_D = cbs1_K; //Depth of image and filter
localparam res_H = ((H-F)/cbs1_s+1); //Height of image
localparam res_W = ((W-F)/cbs1_s+1); //Width of image
parameter res_K1 = 1; //Number of filters applied
localparam res_size1 = res_K1*((res_H-res_F1)/res_s1+1)*((res_W-res_F1)/res_s1+1);
localparam res_size2 = res_D*(((res_H-res_F1+3)-res_F2)/res_s2+1)*(((res_W-res_F1+3)-res_F2)/res_s2+1);//padding1
parameter res_beta =16'b0000000000000000;//0
parameter res_gama = 16'b0011110000000000;//1
parameter res_quarter1 = 16'b0011010000000000;//1/size
parameter res_quarter2 = 16'b0011010000000000;//1/size
localparam  res_K2 = cbs1_K; //Number of filters applied
localparam  res_channel1 =  res_K1;
localparam  res_channel2 = cbs1_K;
localparam  res_size_div_channel1 =  res_size1/ res_channel1;
localparam  res_size_div_channel2 =  res_size2/ res_channel2;


parameter cbso_s=1;
localparam cbso_D = (res_D+cbs2_K); //Depth of image and filter
localparam cbso_H = ((H-F)/cbs2_s+1); //Height of image
localparam cbso_W = ((W-F)/cbs2_s+1); //Width of image
parameter cbso_F = 1; //Size of filter
parameter cbso_K = 2; //Number of filters applied
localparam cbso_size = cbso_K*((cbso_H-cbso_F)/cbso_s+1)*((cbso_W-cbso_F)/cbso_s+1);
parameter cbso_beta =16'b0000000000000000;//0
parameter cbso_gama = 16'b0011110000000000;//1
parameter cbso_quarter = 16'b0011010000000000;//1/size
localparam cbso_channel = cbso_K;
localparam cbso_size_div_channel = cbso_size/cbso_channel;

input clk, reset;
input [0:D*H*W*DATA_WIDTH-1] x;
input [0:cbs1_K*D*F*F*DATA_WIDTH-1] cbs1_filters;
input [0:cbs2_K*D*F*F*DATA_WIDTH-1] cbs2_filters;
input [0:cbso_K*cbso_D*cbso_F*cbso_F*DATA_WIDTH-1] cbso_filters;
input [0:res_K1*res_D*res_F1*res_F1*DATA_WIDTH-1] res_filters1;
input [0:res_K2*res_K1*res_F2*res_F2*DATA_WIDTH-1] res_filters2;
output [0:DATA_WIDTH*cbso_size-1] out;
wire [0:DATA_WIDTH*cbs1_size-1] cbs1_out,res_out;
wire [0:DATA_WIDTH*cbs2_size-1] cbs2_out;
wire [0:cbso_D*cbso_H*cbso_W*DATA_WIDTH-1] cbso_in;

CBS #(
.D(D),
.H(H),
.W(W),
.F(F),
.K(cbs1_K),
.beta(cbs1_beta),
.gama(cbs1_gama),
.quarter(cbs1_quarter),
.s(cbs1_s)
)
c1 (clk,reset,x,cbs1_filters,cbs1_out);

CBS #(
.D(D),
.H(H),
.W(W),
.F(F),
.K(cbs2_K),
.beta(cbs2_beta),
.gama(cbs2_gama),
.quarter(cbs2_quarter),
.s(cbs2_s)
)
c2 (clk,reset,x,cbs2_filters,cbs2_out);

Resx #(
.D(res_D),
.H(res_H),
.W(res_W),
.K1(res_K1),
.beta(res_beta),
.gama(res_gama),
.quarter1(res_quarter1),
.quarter2(res_quarter2),
.s1(res_s1),
.s2(res_s2)
)
r1 (clk,reset,cbs1_out,res_filters1,res_filters2,res_out);

assign cbso_in = {res_out,cbs2_out};

CBS #(
.D(cbso_D),
.H(cbso_H),
.W(cbso_W),
.F(cbso_F),
.K(cbso_K),
.beta(cbso_beta),
.gama(cbso_gama),
.quarter(cbso_quarter),
.s(cbso_s)
)
co (clk,reset,cbso_in,cbso_filters,out);
endmodule
