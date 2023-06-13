`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/11 23:06:30
// Design Name: 
// Module Name: UpSampleMulti
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


module UpSampleMulti(image,out_us);

parameter D = 3;
parameter W = 2;
parameter H = 2;
parameter DATA_WIDTH = 16;

input [0:D*W*H*DATA_WIDTH-1] image;
output [0:D*2*W*2*H*DATA_WIDTH-1] out_us;

generate 
genvar counter;
for(counter=0;counter<D;counter=counter+1) begin
UpSampleSingle upmulti
(
.image(image[counter*W*H*DATA_WIDTH+:W*H*DATA_WIDTH]),
.outputUS(out_us[counter*2*W*2*H*DATA_WIDTH+:2*W*2*H*DATA_WIDTH])
);
end
endgenerate

endmodule
