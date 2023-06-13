`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 00:01:54
// Design Name: 
// Module Name: CSP2_1
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


module CSP2_1(clk,reset,x,cbs11_filters,cbs12_filters,cbs13_filters,cbs2_filters,cbso_filters,out);
localparam DATA_WIDTH = 16;
parameter D = 3; //Depth of image and filter
parameter H = 4; //Height of image
parameter W = 4; //Width of image
parameter F = 3; //Size of filter
//cbs11
parameter cbs11_s=1;
parameter cbs11_K = 2; //Number of filters applied
localparam cbs11_size = cbs11_K*((H-F)/cbs11_s+1)*((W-F)/cbs11_s+1);
parameter cbs11_beta =16'b0000000000000000;//0
parameter cbs11_gama = 16'b0011110000000000;//1
parameter cbs11_quarter = 16'b0011010000000000;//1/size
localparam cbs11_channel = cbs11_K;
localparam cbs11_size_div_channel = cbs11_size/cbs11_channel;
//cbs2
parameter cbs2_s=1;
parameter cbs2_K = 2; //Number of filters applied
localparam cbs2_size = cbs2_K*((H-F)/cbs2_s+1)*((W-F)/cbs2_s+1);
parameter cbs2_beta =16'b0000000000000000;//0
parameter cbs2_gama = 16'b0011110000000000;//1
parameter cbs2_quarter = 16'b0011010000000000;//1/size
localparam cbs2_channel = cbs2_K;
localparam cbs2_size_div_channel = cbs2_size/cbs2_channel;

//cbs12 and cbs13
parameter cbs12_s=1;
localparam cbs12_D = cbs11_K; //Depth of image and filter
localparam cbs12_H = ((H-F)/cbs11_s+1); //Height of image
localparam cbs12_W = ((W-F)/cbs11_s+1); //Width of image
localparam cbs12_F = 1; //Number of filters applied
parameter cbs12_K = 2; //Number of filters applied
localparam cbs12_size = cbs12_K*((cbs12_H-cbs12_F)/cbs12_s+1)*((cbs12_W-cbs12_F)/cbs12_s+1);
parameter cbs12_beta =16'b0000000000000000;//0
parameter cbs12_gama = 16'b0011110000000000;//1
parameter cbs12_quarter = 16'b0011010000000000;//1/size
localparam cbs12_channel = cbs12_K;
localparam cbs12_size_div_channel = cbs12_size/cbs12_channel;

parameter cbs13_s=1;
localparam cbs13_D = cbs12_K; //Depth of image and filter
localparam cbs13_H = ((cbs12_H-cbs12_F)/cbs12_s+3); //Height of image
localparam cbs13_W = ((cbs12_W-cbs12_F)/cbs12_s+3); //Width of image
localparam cbs13_F = 3; //Number of filters applied
parameter cbs13_K = 2; //Number of filters applied
localparam cbs13_size = cbs13_K*((cbs13_H-cbs13_F)/cbs13_s+1)*((cbs13_W-cbs13_F)/cbs13_s+1);
parameter cbs13_beta =16'b0000000000000000;//0
parameter cbs13_gama = 16'b0011110000000000;//1
parameter cbs13_quarter = 16'b0011010000000000;//1/size
localparam cbs13_channel = cbs13_K;
localparam cbs13_size_div_channel = cbs13_size/cbs13_channel;

parameter cbso_s=1;
localparam cbso_D = (cbs13_K+cbs2_K); //Depth of image and filter
localparam cbso_H = ((H-F)/cbs2_s+1); //Height of image
localparam cbso_W = ((W-F)/cbs2_s+1); //Width of image
parameter cbso_F = 1; //Size of filter
parameter cbso_K = 2; //Number of filters applied
localparam cbso_size = cbso_K*((cbso_H-cbso_F)/cbso_s+1)*((cbso_W-cbso_F)/cbso_s+1);
parameter cbso_beta =16'b0000000000000000;//0
parameter cbso_gama = 16'b0011110000000000;//1
parameter cbso_quarter = 16'b0011010000000000;//1/size
localparam cbso_channel = cbso_K;
localparam cbso_size_div_channel = cbso_size/cbso_channel;

input clk, reset;
input [0:D*H*W*DATA_WIDTH-1] x;
input [0:cbs11_K*D*F*F*DATA_WIDTH-1] cbs11_filters;
input [0:cbs2_K*D*F*F*DATA_WIDTH-1] cbs2_filters;
input [0:cbso_K*cbso_D*cbso_F*cbso_F*DATA_WIDTH-1] cbso_filters;
input [0:cbs12_K*cbs12_D*cbs12_F*cbs12_F*DATA_WIDTH-1] cbs12_filters;
input [0:cbs13_K*cbs13_D*cbs13_F*cbs13_F*DATA_WIDTH-1] cbs13_filters;
output [0:DATA_WIDTH*cbso_size-1] out;
wire [0:DATA_WIDTH*cbs11_size-1] cbs11_out;
wire [0:DATA_WIDTH*cbs12_size-1] cbs12_out;
wire [0:DATA_WIDTH*cbs13_size-1] cbs13_out;
wire [0:DATA_WIDTH*cbs2_size-1] cbs2_out;
wire [0:cbso_D*cbso_H*cbso_W*DATA_WIDTH-1] cbso_in;
reg [0:DATA_WIDTH*cbs2_K*((cbs12_H-cbs12_F)/cbs12_s+3)*((cbs12_W-cbs12_F)/cbs12_s+3)-1] cbs12_out_p;

CBS #(
.D(D),
.H(H),
.W(W),
.F(F),
.K(cbs11_K),
.beta(cbs11_beta),
.gama(cbs11_gama),
.quarter(cbs11_quarter),
.s(cbs11_s)
)
c11 (clk,reset,x,cbs11_filters,cbs11_out);

CBS #(
.D(cbs12_D),
.H(cbs12_H),
.W(cbs12_W),
.F(cbs12_F),
.K(cbs12_K),
.beta(cbs12_beta),
.gama(cbs12_gama),
.quarter(cbs12_quarter),
.s(cbs12_s)
)
c12 (clk,reset,cbs11_out,cbs12_filters,cbs12_out);

CBS #(
.D(cbs13_D),
.H(cbs13_H),
.W(cbs13_W),
.F(cbs13_F),
.K(cbs13_K),
.beta(cbs13_beta),
.gama(cbs13_gama),
.quarter(cbs13_quarter),
.s(cbs13_s)
)
c13 (clk,reset,cbs12_out_p,cbs13_filters,cbs13_out);


CBS #(
.D(D),
.H(H),
.W(W),
.F(F),
.K(cbs2_K),
.beta(cbs2_beta),
.gama(cbs2_gama),
.quarter(cbs2_quarter),
.s(cbs2_s)
)
c2 (clk,reset,x,cbs2_filters,cbs2_out);

assign cbso_in = {cbs13_out,cbs2_out};

CBS #(
.D(cbso_D),
.H(cbso_H),
.W(cbso_W),
.F(cbso_F),
.K(cbso_K),
.beta(cbso_beta),
.gama(cbso_gama),
.quarter(cbso_quarter),
.s(cbso_s)
)
co (clk,reset,cbso_in,cbso_filters,out);
integer j,k;
always @(cbs12_out) begin
    for(k=0;k<cbs12_K;k=k+1) begin
            for(j=1;j<((cbs12_H-cbs12_F)/cbs12_s+1);j=j+1) begin :f1
            cbs12_out_p[0*((cbs12_H-cbs12_F)/cbs12_s+3)*DATA_WIDTH+(k*((cbs12_H-cbs12_F)/cbs12_s+3)*((cbs12_W-cbs12_F)/cbs12_s+3))*DATA_WIDTH+j*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            cbs12_out_p[((cbs12_H-cbs12_F)/cbs12_s+2)*((cbs12_H-cbs12_F)/cbs12_s+3)*DATA_WIDTH+(k*((cbs12_H-cbs12_F)/cbs12_s+3)*((cbs12_W-cbs12_F)/cbs12_s+3))*DATA_WIDTH+j*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;   
            cbs12_out_p[j*((cbs12_H-cbs12_F)/cbs12_s+3)*DATA_WIDTH+(k*((cbs12_H-cbs12_F)/cbs12_s+3)*((cbs12_H-cbs12_F)/cbs12_s+3))*DATA_WIDTH+0*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            cbs12_out_p[j*((cbs12_H-cbs12_F)/cbs12_s+3)*DATA_WIDTH+(k*((cbs12_H-cbs12_F)/cbs12_s+3)*((cbs12_W-cbs12_F)/cbs12_s+3))*DATA_WIDTH+((cbs12_H-cbs12_F)/cbs12_s+2)*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000; 
            cbs12_out_p[j*((cbs12_H-cbs12_F)/cbs12_s+3)*DATA_WIDTH+(k*((cbs12_H-cbs12_F)/cbs12_s+3)*((cbs12_H-cbs12_F)/cbs12_s+3))*DATA_WIDTH+1*DATA_WIDTH+:((cbs12_W-cbs12_F)/cbs12_s+1)*DATA_WIDTH] <= cbs12_out[(j-1)*((cbs12_H-cbs12_F)/cbs12_s+1)*DATA_WIDTH+(k*((cbs12_H-cbs12_F)/cbs12_s+1)*((cbs12_W-cbs12_F)/cbs12_s+1))*DATA_WIDTH+0*DATA_WIDTH+:((cbs12_H-cbs12_F)/cbs12_s+1)*DATA_WIDTH];    

            cbs12_out_p[0*((cbs12_H-cbs12_F)/cbs12_s+3)*DATA_WIDTH+(k*((cbs12_H-cbs12_F)/cbs12_s+3)*((cbs12_H-cbs12_F)/cbs12_s+3))*DATA_WIDTH+0*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            cbs12_out_p[0*((cbs12_H-cbs12_F)/cbs12_s+3)*DATA_WIDTH+(k*((cbs12_H-cbs12_F)/cbs12_s+3)*((cbs12_H-cbs12_F)/cbs12_s+3))*DATA_WIDTH+((cbs12_W-cbs12_F)/cbs12_s+2)*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            cbs12_out_p[((cbs12_H-cbs12_F)/cbs12_s+2)*((cbs12_H-cbs12_F)/cbs12_s+3)*DATA_WIDTH+(k*((cbs12_H-cbs12_F)/cbs12_s+3)*((cbs12_W-cbs12_F)/cbs12_s+3))*DATA_WIDTH+0*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;
            cbs12_out_p[((cbs12_H-cbs12_F)/cbs12_s+2)*((cbs12_H-cbs12_F)/cbs12_s+3)*DATA_WIDTH+(k*((cbs12_H-cbs12_F)/cbs12_s+3)*((cbs12_W-cbs12_F)/cbs12_s+3))*DATA_WIDTH+((cbs12_W-cbs12_F)/cbs12_s+2)*DATA_WIDTH+:DATA_WIDTH] <= 16'b0000000000000000;     
        end
    end
end

endmodule
