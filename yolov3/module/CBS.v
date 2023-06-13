`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 00:43:37
// Design Name: 
// Module Name: CBS
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


module CBS(clk,reset,x,filters,out);
localparam DATA_WIDTH = 16;
parameter D = 1; //Depth of image and filter
parameter H = 32; //Height of image
parameter W = 32; //Width of image
parameter F = 3; //Size of filter
parameter K = 13; //Number of filters applied
parameter s = 1;
localparam size = K*((H-F)/s+1)*((W-F)/s+1);
parameter beta =16'b0000000000000000;//0
parameter gama = 16'b0011110000000000;//1
parameter quarter = 16'b0011010000000000;//1/size
localparam channel = K;
localparam size_div_channel = size/channel;

input clk, reset;
input [0:D*H*W*DATA_WIDTH-1] x;
input [0:K*D*F*F*DATA_WIDTH-1] filters;
output [0:DATA_WIDTH*size-1] out;
wire [0:size*DATA_WIDTH-1] outputConv;
reg [0:size*DATA_WIDTH-1] bn_input;
wire [0:DATA_WIDTH*size-1] out_bn;
wire Finished;

convLayerMulti #(
.D(D), //Depth of image and filter
.H(H), //Height of image
.W(W), //Width of image
.F(F), //Size of filter
.K(K),
.s(s)) 
conv (clk,reset,x,filters,outputConv,Finished);

    bn_multi #(
    .size(size),
    .beta(16'b0000000000000000),//0
    .gama(16'b0011110000000000),//1
    .quarter(quarter),
    .channel(K)
    ) 
    bn (bn_input,out_bn,clk,reset);
    
    Silumulti #(
    .size(size)
    )
    acti (out_bn,reset,clk,out);
    
always @(posedge Finished) begin
    if(Finished <=1'b1) 
        bn_input <= outputConv;
end

endmodule
