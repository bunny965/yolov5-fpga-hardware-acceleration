`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 23:10:25
// Design Name: 
// Module Name: MaxUnit9_tb
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


module MaxUnit9_tb(
 );
 parameter DATA_WIDTH = 16;
 localparam size = 9;
 reg [DATA_WIDTH*size*size-1:0] x;
 wire [DATA_WIDTH-1:0] MaxOut;
 
 initial begin
 #0 x<=1296'h400040004000400040004000400040004000400040004000400040004000400040004000400040004200400040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000420040004000400040004000400040004000400040004000400040004000400040004000400040004500400040004000400040004200400040004000400042004200420042004200;
// #300 x<=400'hBC00C000C200C400C000C200C400C50044004200420042004200420042004200420042004200;
 end
 MaxUnit9 m (x,MaxOut);
endmodule
