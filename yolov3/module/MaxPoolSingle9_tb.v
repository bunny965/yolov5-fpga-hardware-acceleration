`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 23:14:27
// Design Name: 
// Module Name: MaxPoolSingle9_tb
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


module MaxPoolSingle9_tb(

    );
    parameter DATA_WIDTH = 16;
    parameter InputH = 9;
    parameter InputW = 9;
    localparam Depth = 1;
    localparam s =9;
    
    reg [InputH*InputW*Depth*DATA_WIDTH-1:0] mPoolIn;
    wire [(InputH/s)*(InputW/s)*Depth*DATA_WIDTH-1:0] mPoolOut;
    
    initial begin
    #0 mPoolIn<=1296'h400040004000400040004000400040004000400040004000400040004000400040004000400040004200400040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000420040004000400040004000400040004000400040004000400040004000400040004000400040004500400040004000400040004200400040004000400042004200420042004200;
    #200
    $stop;
    end
     MaxPoolSingle9 m (mPoolIn,mPoolOut);

endmodule
