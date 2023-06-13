`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 09:19:37
// Design Name: 
// Module Name: padding
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


module padding(x,out);
localparam DATA_WIDTH = 16;
parameter K = 1; //Depth of image and filter
parameter H = 1; //Height of image
parameter W = 1; //Width of image

input[0:K*W*H*DATA_WIDTH-1] x;
output reg[0:K*(W+2)*(H+2)*DATA_WIDTH-1] out;

integer k,j;
always @(x) begin
    for(k=0;k<K;k=k+1) begin
            for(j=1;j<(H+1);j=j+1) begin
       
            out[0*(H+2)*DATA_WIDTH+(k*(H+2)*(W+2))*DATA_WIDTH+j*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            out[(H+1)*(H+2)*DATA_WIDTH+(k*(H+2)*(W+2))*DATA_WIDTH+j*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;   
            out[j*(H+2)*DATA_WIDTH+(k*(H+2)*(W+2))*DATA_WIDTH+0*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            out[j*(H+2)*DATA_WIDTH+(k*(H+2)*(W+2))*DATA_WIDTH+(W+1)*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000; 
            out[j*(H+2)*DATA_WIDTH+(k*(H+2)*(W+2))*DATA_WIDTH+1*DATA_WIDTH+:W*DATA_WIDTH] <= x[(j-1)*H*DATA_WIDTH+(k*H*W)*DATA_WIDTH+0*DATA_WIDTH+:W*DATA_WIDTH];    

            out[0*(H+2)*DATA_WIDTH+(k*(H+2)*(W+2))*DATA_WIDTH+0*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            out[0*(H+2)*DATA_WIDTH+(k*(H+2)*(W+2))*DATA_WIDTH+(W+1)*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            out[(H+1)*(H+2)*DATA_WIDTH+(k*(H+2)*(W+2))*DATA_WIDTH+0*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            out[(H+1)*(H+2)*DATA_WIDTH+(k*(H+2)*(W+2))*DATA_WIDTH+(W+1)*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;     
        end
    end
end
endmodule
