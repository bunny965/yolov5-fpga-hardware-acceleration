`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 17:13:12
// Design Name: 
// Module Name: UpSampleSingle_tb
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


module UpSampleSingle_tb();
reg [63:0] image;
wire [16*16-1:0] o;

initial begin
# 10

image <= 64'h4000C00000001000;

# 200 
image <= 64'hC000230011002222;
end

UpSampleSingle #(
     .DATA_WIDTH(16),
     .H(2),
     .W(2),
     .D(1) )
     us(
     .image(image),
     .outputUS(o)
     );



endmodule
