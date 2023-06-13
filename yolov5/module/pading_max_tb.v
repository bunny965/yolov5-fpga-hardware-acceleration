`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 23:28:59
// Design Name: 
// Module Name: pading_max_tb
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


module pading_max_tb(

    );
localparam DATA_WIDTH = 16;
    parameter K = 1; //Depth of image and filter
    parameter H = 1; //Height of image
    parameter W = 1; //Width of image
    reg clk,reset;
    reg [K*W*H*DATA_WIDTH-1:0] x;
    wire [K*(H)*(W)*DATA_WIDTH-1:0] out_m5;
    wire [K*(H)*(W)*DATA_WIDTH-1:0] out_m9;
    wire [K*(H)*(W)*DATA_WIDTH-1:0] out_m13;
    wire [K*(H+12)*(W+12)*DATA_WIDTH-1:0] out_p6;
    wire [K*(H+10)*(W+10)*DATA_WIDTH-1:0] out_p5;

integer i;
    localparam PERIOD = 100;
    always #(PERIOD/2) clk = ~clk;
    initial begin
    # 0 
    reset <=1'b1;
    clk<=1'b0;
    x=16'b1111000011111111;
    # (PERIOD/2) reset<=1'b0;
    #(2*PERIOD)
    reset <=1'b1;
        x=16'b0000110100111101;
        # (PERIOD/2) reset<=1'b0;
        #200
    for(i=0;i<K*(H+12)*(W+12);i=i+1) $display("%b",out_p6[i*DATA_WIDTH+:DATA_WIDTH]);
     $stop;
    end
pading_max UUT (clk,reset,x,out_m5,out_m9,out_m13);
assign out_p6=UUT.out_p6;
endmodule
