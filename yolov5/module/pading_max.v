`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 23:18:34
// Design Name: 
// Module Name: pading_max
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


module pading_max(clk,reset,x,out_m5,out_m9,out_m13);
localparam DATA_WIDTH = 16;
parameter K = 1; //Depth of image and filter
parameter H = 1; //Height of image
parameter W = 1; //Width of image

input clk,reset;
input [0:K*W*H*DATA_WIDTH-1] x;
wire [0:K*(H+2)*(W+2)*DATA_WIDTH-1] out_p1;
wire [0:K*(H+4)*(W+4)*DATA_WIDTH-1] out_p2;
wire [0:K*(H+6)*(W+6)*DATA_WIDTH-1] out_p3;
wire [0:K*(H+8)*(W+8)*DATA_WIDTH-1] out_p4;
wire [0:K*(H+10)*(W+10)*DATA_WIDTH-1] out_p5;
wire [0:K*(H+12)*(W+12)*DATA_WIDTH-1] out_p6;
output [0:K*(H)*(W)*DATA_WIDTH-1] out_m5;
output [0:K*(H)*(W)*DATA_WIDTH-1] out_m9;
output [0:K*(H)*(W)*DATA_WIDTH-1] out_m13;

padding#(.K(K),.H(H),.W(W)) p1(x,out_p1);
padding#(.K(K),.H(H+2),.W(W+2)) p2(out_p1,out_p2);
padding#(.K(K),.H(H+4),.W(W+4)) p3(out_p2,out_p3);
padding#(.K(K),.H(H+6),.W(W+6)) p4(out_p3,out_p4);
padding#(.K(K),.H(H+8),.W(W+8)) p5(out_p4,out_p5);
padding#(.K(K),.H(H+10),.W(W+10)) p6(out_p5,out_p6);
MaxPoolMulti5#(.D(K),.H(H+4),.W(W+4)) m5 (clk, reset, out_p2, out_m5);
MaxPoolMulti9#(.D(K),.H(H+8),.W(W+8)) m9 (clk, reset, out_p4, out_m9);
MaxPoolMulti13#(.D(K),.H(H+12),.W(W+12)) m13 (clk, reset, out_p6, out_m13);
endmodule
