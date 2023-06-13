`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 16:37:34
// Design Name: 
// Module Name: slice
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


module slice(x,out);
parameter W=4;
parameter H=4;
parameter K=3;
localparam DATA_WIDTH=16;

input [0:W*H*K*DATA_WIDTH-1] x;
output reg [0:(W/2)*(H/2)*(4*K)*DATA_WIDTH-1] out;
integer i,j,k;
always @(x) begin
    for(i=0;i<K;i=i+1) begin
        for(j=0;j<H;j=j+2) begin
            for(k=0;k<W;k=k+2) begin
                out[((i*W/2*H/2)+(j/2*W/2)+k/2)*DATA_WIDTH+:DATA_WIDTH]<=x[(i*W*H+j*W+k)*DATA_WIDTH+:DATA_WIDTH];
                out[(((i+K)*W/2*H/2)+(j/2*W/2)+k/2)*DATA_WIDTH+:DATA_WIDTH]<=x[(i*W*H+j*W+k+1)*DATA_WIDTH+:DATA_WIDTH];
                out[(((i+2*K)*W/2*H/2)+(j/2*W/2)+k/2)*DATA_WIDTH+:DATA_WIDTH]<=x[(i*W*H+(j+1)*W+k)*DATA_WIDTH+:DATA_WIDTH];
                out[(((i+3*K)*W/2*H/2)+(j/2*W/2)+k/2)*DATA_WIDTH+:DATA_WIDTH]<=x[(i*W*H+(j+1)*W+k+1)*DATA_WIDTH+:DATA_WIDTH];
            end
        end
    end
end
endmodule
