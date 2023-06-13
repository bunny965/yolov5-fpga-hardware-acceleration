`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 09:15:35
// Design Name: 
// Module Name: compare_tb
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


module compare_tb();
parameter DATA_WIDTH = 16;
reg[DATA_WIDTH-1:0] numA,numB;
wire [DATA_WIDTH-1:0] max;
initial begin 
# 0 numA<=16'b1011010011110110;
numB<=16'b1111110111110110;
#20 numA<=16'b0001011001010011;
numB<=16'b0101000000100010;
#20 numA<=16'b1011010011110110;
numB<=16'b0111011000110111;
#20
$stop;
end

compare c (numA,numB,max);
endmodule
