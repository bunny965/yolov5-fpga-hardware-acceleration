`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 00:17:28
// Design Name: 
// Module Name: UpSample
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


module UpSampleSingle(image,outputUS);

parameter DATA_WIDTH = 16;
parameter H = 2;
parameter W = 2;
parameter D = 1;

input [0:D*W*H*DATA_WIDTH-1] image;
output reg [0:D*2*W*2*W*DATA_WIDTH-1] outputUS;


generate 
genvar counter,row;

    for (row=0;row<W;row=row+1) begin
        for(counter=0;counter<H;counter=counter+1) begin
            always @ (*) begin
                    outputUS[((row*2)*2*W*DATA_WIDTH+2*counter*DATA_WIDTH)+:DATA_WIDTH] <=   image[(row*W*DATA_WIDTH+counter*DATA_WIDTH)+:DATA_WIDTH];
                    outputUS[((row*2+1)*2*W*DATA_WIDTH+2*counter*DATA_WIDTH)+:DATA_WIDTH] <=   image[(row*W*DATA_WIDTH+counter*DATA_WIDTH)+:DATA_WIDTH];
                    outputUS[((row*2)*2*W*DATA_WIDTH+(2*counter+1)*DATA_WIDTH)+:DATA_WIDTH] <=   image[(row*W*DATA_WIDTH+counter*DATA_WIDTH)+:DATA_WIDTH];
                    outputUS[((row*2+1)*2*W*DATA_WIDTH+(2*counter+1)*DATA_WIDTH)+:DATA_WIDTH] <=   image[(row*W*DATA_WIDTH+counter*DATA_WIDTH)+:DATA_WIDTH];
            end
        end
    end

endgenerate
    
endmodule
