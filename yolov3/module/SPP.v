`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 23:54:31
// Design Name: 
// Module Name: SPP
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


module SPP(clk,reset,x,filters1,filters2,out);
localparam DATA_WIDTH = 16;
parameter D = 1; //Depth of image and filter
parameter H = 2; //Height of image
parameter W = 2; //Width of image

parameter cbs1_s=1;
parameter cbs2_s=1;
parameter F1 = 1; //Size of filter
parameter K1 = 1; //Number of filters applied
localparam size1 = K1*((H-F1)/cbs1_s+1)*((W-F1)/cbs1_s+1);
parameter beta1 =16'b0000000000000000;//0
parameter gama1 = 16'b0011110000000000;//1
parameter quarter1 = 16'b0011010000000000;//1/size
localparam channel1 = K1;
localparam size_div_channel1 = size1/channel1;

localparam s1 =5;
localparam s2 =9;
localparam s3 =13;


localparam D2 = (K1*4); //Depth of image and filter
localparam H2 = ((H-F1)/cbs1_s+1); //Height of image
localparam W2 = ((W-F1)/cbs1_s+1); //Width of image

parameter F2 = 1; //Size of filter
parameter K2 = 1; //Number of filters applied
localparam size2 = K2*((H2-F2)/cbs2_s+1)*((W2-F2)/cbs2_s+1);
parameter beta2 =16'b0000000000000000;//0
parameter gama2 = 16'b0011110000000000;//1
parameter quarter2 = 16'b0011010000000000;//1/size
localparam channel2 = K1;
localparam size_div_channel2 = size2/channel2;


input clk, reset;
input [0:D*H*W*DATA_WIDTH-1] x;
input [0:K1*D*F1*F1*DATA_WIDTH-1] filters1;
input [0:K2*D2*F2*F2*DATA_WIDTH-1] filters2;
output [0:DATA_WIDTH*size2-1] out;
wire [0:DATA_WIDTH*size1-1] out_cbs1;
reg [0:DATA_WIDTH*size1-1] out_cbs1_temp;
wire [0:size1*DATA_WIDTH-1] out_m5;
wire [0:size1*DATA_WIDTH-1] out_m9;
wire [0:size1*DATA_WIDTH-1] out_m13;
wire [0:4*size1*DATA_WIDTH-1] in_cbs2;

CBS #(
.D(D),
.H(H),
.W(W),
.F(F1),
.K(K1),
.beta(beta1),
.gama(gama1),
.quarter(quarter1),
.s(cbs1_s)
)
c1 (clk,reset,x,filters1,out_cbs1);

always@(out_cbs1) begin
out_cbs1_temp <=out_cbs1;
end

pading_max#(.K(K1),.H(H-F1+1),.W(W-F1+1)) get_maxpool (clk,reset,out_cbs1_temp,out_m5,out_m9,out_m13);


assign   in_cbs2 = {out_cbs1,out_m5,out_m9,out_m13};

CBS #(
.D(D2),
.H(H2),
.W(W2),
.F(F2),
.K(K2),
.beta(beta2),
.gama(gama2),
.quarter(quarter2),
.s(cbs2_s)
)
c2 (clk,reset,in_cbs2,filters2,out);

endmodule
