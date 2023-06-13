`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 19:36:23
// Design Name: 
// Module Name: padding_tb
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


module padding_tb();
parameter DATA_WIDTH = 16;
parameter K = 1; //Depth of image and filter
parameter H = 1; //Height of image
parameter W = 1; //Width of image

reg [K*W*H*DATA_WIDTH-1:0] x;
wire [K*(W+2)*(H+2)*DATA_WIDTH-1:0] out;
wire [K*(W+2+2)*(H+2+2)*DATA_WIDTH-1:0] out1;

integer i;
initial begin
    #0 x<=16'b1111111111111111;
    #100
    for(i=0;i<K*(W+4)*(H+4);i=i+1)
    $display("%b",out1[i*DATA_WIDTH+:DATA_WIDTH]);
    $stop;
end
padding#(.K(K),.W(W),.H(H)) p (x,out);
padding#(.K(K),.W(W+2),.H(H+2)) p1(out,out1);

endmodule
