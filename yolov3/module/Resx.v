`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/30 16:44:18
// Design Name: 
// Module Name: Resx
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


module Resx(clk,reset,x,filters1,filters2,out);
localparam DATA_WIDTH = 16;
parameter D = 1; //Depth of image and filter
parameter H = 4; //Height of image
parameter W = 4; //Width of image
parameter s1 = 1;
parameter s2 = 1;
localparam F1 = 1; //Size of filter
localparam F2 = 3; //Size of filter
parameter K1 = 1; //Number of filters applied
localparam K2 = D; //Number of filters applied
localparam size1 = K1*((H-F1)/s1+1)*((W-F1)/s1+1);
localparam size2 = D*(((((H-F1)/s1+1)+2)-F2)/s2+1)*(((((W-F1)/s1+1)+2)-F2)/s2+1);//padding1
parameter beta =16'b0000000000000000;//0
parameter gama = 16'b0011110000000000;//1
parameter quarter1 = 16'b0011010000000000;//1/size
parameter quarter2 = 16'b0011010000000000;//1/size
localparam channel1 = K1;
localparam channel2 = D;
localparam size_div_channel1 = size1/channel1;
localparam size_div_channel2 = size2/channel2;


input clk, reset;
input [0:D*H*W*DATA_WIDTH-1] x;
input [0:K1*D*F1*F1*DATA_WIDTH-1] filters1;
input [0:K2*K1*F2*F2*DATA_WIDTH-1] filters2;
output  [0:DATA_WIDTH*size2-1] out;
wire [0:DATA_WIDTH*size1-1] out_temp;
wire [0:DATA_WIDTH*size2-1] out_temp3;
reg [0:DATA_WIDTH*K1*(((H-F1)/s1+1)+2)*(((W-F1)/s1+1)+2)] out_temp2;

CBS #(
.D(D),
.H(H),
.W(W),
.F(F1),
.K(K1),
.beta(beta),
.gama(gama),
.quarter(quarter1),
.s(s1)
)
c1 (clk,reset,x,filters1,out_temp);



CBS #(
.D(K1),
.H(H-F1+3),
.W(W-F1+3),
.F(F2),
.K(K2),
.beta(beta),
.gama(gama),
.quarter(quarter2),
.s(s2)
)
c2 (clk,reset,out_temp2,filters2,out_temp3);

integer j,k;
always @(out_temp) begin
    for(k=0;k<K1;k=k+1) begin
            for(j=1;j<((H-F1)/s1+2);j=j+1) begin
       
            out_temp2[0*((H-F1)/s1+3)*DATA_WIDTH+(k*((H-F1)/s1+3)*((H-F1)/s1+3))*DATA_WIDTH+j*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            out_temp2[((H-F1)/s1+2)*((H-F1)/s1+3)*DATA_WIDTH+(k*((H-F1)/s1+3)*((W-F1)/s1+3))*DATA_WIDTH+j*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;   
            out_temp2[j*((H-F1)/s1+3)*DATA_WIDTH+(k*((H-F1)/s1+3)*((W-F1)/s1+3))*DATA_WIDTH+0*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            out_temp2[j*((H-F1)/s1+3)*DATA_WIDTH+(k*((H-F1)/s1+3)*((W-F1)/s1+3))*DATA_WIDTH+((W-F1)/s1+2)*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000; 
            out_temp2[j*((H-F1)/s1+3)*DATA_WIDTH+(k*((H-F1)/s1+3)*((W-F1)/s1+3))*DATA_WIDTH+1*DATA_WIDTH+:((W-F1)/s1+1)*DATA_WIDTH] <= out_temp[(j-1)*((H-F1)/s1+1)*DATA_WIDTH+(k*((H-F1)/s1+1)*((W-F1)/s1+1))*DATA_WIDTH+0*DATA_WIDTH+:((W-F1)/s1+1)*DATA_WIDTH];    

            out_temp2[0*((H-F1)/s1+3)*DATA_WIDTH+(k*((H-F1)/s1+3)*((W-F1)/s1+3))*DATA_WIDTH+0*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            out_temp2[0*((H-F1)/s1+3)*DATA_WIDTH+(k*((H-F1)/s1+3)*((W-F1)/s1+3))*DATA_WIDTH+((W-F1)/s1+2)*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            out_temp2[((H-F1)/s1+2)*((H-F1)/s1+3)*DATA_WIDTH+(k*((H-F1)/s1+3)*((W-F1)/s1+3))*DATA_WIDTH+0*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            out_temp2[((H-F1)/s1+2)*((H-F1)/s1+3)*DATA_WIDTH+(k*((H-F1)/s1+3)*((W-F1)/s1+3))*DATA_WIDTH+((W-F1)/s1+2)*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;     
        end
    end
end

genvar i;
generate
    for(i=0;i<size2;i=i+1) begin
         floatAdd f (out_temp3[i*DATA_WIDTH+:DATA_WIDTH],x[i*DATA_WIDTH+:DATA_WIDTH],out[i*DATA_WIDTH+:DATA_WIDTH]);
    end
endgenerate


endmodule
