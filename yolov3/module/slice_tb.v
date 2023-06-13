`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 17:00:23
// Design Name: 
// Module Name: slice_tb
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


module slice_tb();
parameter W=4;
parameter H=4;
parameter K=3;
localparam DATA_WIDTH=16;
integer i;
reg [0:W*H*K*DATA_WIDTH-1] x;
wire [0:(W/2)*(H/2)*(4*K)*DATA_WIDTH-1] out;
initial begin
    #20
    x<=768'h0001000200010002_0003000400030004_0001000200010002_00030004000300040001000200010002_0003000400030004_0001000200010002_00030004000300040001000200010002_0003000400030004_0001000200010002_0003000400030004;
    #200
    for(i=0;i<48;i=i+1) $display("%h",out[i*DATA_WIDTH+:DATA_WIDTH]);
end
slice s (x,out);
endmodule
