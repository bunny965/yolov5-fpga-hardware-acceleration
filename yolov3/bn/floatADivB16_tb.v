`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 23:50:28
// Design Name: 
// Module Name: floatADivB16_tb
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


module floatADivB16_tb();
reg [15:0] numA,numB;
wire [15:0] out;
initial begin
#0 numA <= 16'b0010101111000101;
numB <= 16'b0010101100011110;
#20 numA <= 16'b0010111100110000;
 numB <= 16'b1001001010101101;
#20 numA <= 16'b0001010001001000;
numB <= 16'b1100001101100111;
#20
$stop;
end
floatADivB16 a ( numA,
           numB,
           out);
endmodule
