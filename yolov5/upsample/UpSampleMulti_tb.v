`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/11 23:23:38
// Design Name: 
// Module Name: UpSampleMulti_tb
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


module UpSampleMulti_tb();
parameter D = 3;
parameter DATA_WIDTH = 16;
parameter H = 2;
parameter W = 2;
reg [0:D*W*H*DATA_WIDTH-1] image;
wire [0:D*2*W*2*H*DATA_WIDTH-1] outputUS;

initial begin
# 0 
image <= 192'h421694754c7b3e70ce554c63c719047a587edb40e6bf5f7c5a941f3c763fcfc6be3eee468d6cfe780b02a3c90ed19abcd218bf3e48e5afcd469becb82a3bbd89522bf49b1d317829d44d16d7b6f0b342221df990883950fa71e98fed143995c8;

#100
image <= 192'h715519216cf790b0c1049ff08bc26cd4874f4b721db04610008147d979eadf203bb2c10c08c4849e4a843116e60b99f5c85cbc3321a7251372591e75aa86e5bfce2b89c7a72c8f5a031379d055132895d56bf26767def1924219d99ac5f6e528;

end
UpSampleMulti
#(
.D(D),
.W(2),
.H(2),
.DATA_WIDTH(16)
) UU
(
.image(image),
.out_us(outputUS)
);

endmodule
