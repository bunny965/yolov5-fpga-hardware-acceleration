//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 2023/05/06 16:17:57
//// Design Name: 
//// Module Name: Yolo
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////
//
//
//module Yolo(clk,reset,x,out_yolo1,out_yolo2,out_yolo3);
//localparam DATA_WIDTH=16;
//
//input clk,reset;
//input [0:640*640*3*DATA_WIDTH-1] x;
//output [0:80*80*75*DATA_WIDTH-1] out_yolo1;
//output [0:40*40*75*DATA_WIDTH-1] out_yolo2;
//output [0:20*20*75*DATA_WIDTH-1] out_yolo3;
//wire [0:320*320*12*DATA_WIDTH-1] slice;
//wire [0:322*322*12*DATA_WIDTH-1] c1_in;
//wire [0:320*320*32*DATA_WIDTH-1] c1_out;
//wire [0:322*322*32*DATA_WIDTH-1] c2_in;
//wire [0:160*160*64*DATA_WIDTH-1] c2_out;
//wire [0:160*160*64*DATA_WIDTH-1] csp11_1_out;
//wire [0:162*162*64*DATA_WIDTH-1] c3_in;
//wire [0:80*80*128*DATA_WIDTH-1] c3_out;
//wire [0:80*80*128*DATA_WIDTH-1] csp13_1_out;
//reg [0:80*80*128*DATA_WIDTH-1] csp13_1_out_temp;
//wire [0:82*82*128*DATA_WIDTH-1] c4_in;
//wire [0:40*40*256*DATA_WIDTH-1] c4_out;
//wire [0:40*40*256*DATA_WIDTH-1] csp13_2_out;
//reg [0:40*40*256*DATA_WIDTH-1] csp13_2_out_temp;
//wire [0:42*42*256*DATA_WIDTH-1] c5_in;
//wire [0:20*20*512*DATA_WIDTH-1] c5_out;
//wire [0:20*20*512*DATA_WIDTH-1] spp1_out;
//wire [0:20*20*512*DATA_WIDTH-1] csp21_1_out;
//wire [0:20*20*256*DATA_WIDTH-1] c6_out;
//reg [0:20*20*256*DATA_WIDTH-1] csp21_1_c6_out_temp;;
//wire [0:40*40*256*DATA_WIDTH-1] c6_out_upsample;
//wire [0:40*40*512*DATA_WIDTH-1] csp21_2_in;
//wire [0:40*40*256*DATA_WIDTH-1] csp21_2_out;
//wire [0:40*40*128*DATA_WIDTH-1] c7_out;
//reg [0:40*40*128*DATA_WIDTH-1] c7_out_temp;
//wire [0:80*80*128*DATA_WIDTH-1] c7_out_upsample;
//wire [0:80*80*256*DATA_WIDTH-1] csp21_3_1_in;
//wire [0:80*80*128*DATA_WIDTH-1] csp21_3_1_out;
//reg [0:80*80*128*DATA_WIDTH-1] csp21_3_1_out_temp;
//wire [0:82*82*128*DATA_WIDTH-1] c8_in;
//wire [0:40*40*128*DATA_WIDTH-1] c8_out;
//wire [0:40*40*256*DATA_WIDTH-1] csp21_3_2_in;
//wire [0:40*40*256*DATA_WIDTH-1] csp21_3_2_out;
//reg [0:40*40*256*DATA_WIDTH-1] csp21_3_2_out_temp;
//wire [0:42*42*256*DATA_WIDTH-1] c9_in;
//wire [0:20*20*256*DATA_WIDTH-1] c9_out;
//wire [0:20*20*512*DATA_WIDTH-1] csp21_3_3_in;
//wire [0:20*20*512*DATA_WIDTH-1] csp21_3_3_out;
//
//
////filters
//wire [0:3*3*12*32*DATA_WIDTH-1] filters1;
//
//wire [0:3*3*32*64*DATA_WIDTH-1] filters2;
//
//wire [0:1*1*64*32*DATA_WIDTH-1] csp11_1_cbs1_filters;
//wire [0:1*1*32*32*DATA_WIDTH-1] csp11_1_res_filters1;
//wire [0:3*3*32*32*DATA_WIDTH-1] csp11_1_res_filters2;
//wire [0:1*1*64*32*DATA_WIDTH-1] csp11_1_cbs2_filters;
//wire [0:1*1*64*64*DATA_WIDTH-1] csp11_1_cbso_filters;
//
//wire [0:3*3*64*128*DATA_WIDTH-1] filters3;
//
//wire [0:1*1*128*64*DATA_WIDTH-1] csp13_1_cbs1_filters;
//wire [0:1*1*64*64*DATA_WIDTH-1] csp13_1_res1_filters1;
//wire [0:3*3*64*64*DATA_WIDTH-1] csp13_1_res1_filters2;
//wire [0:1*1*64*64*DATA_WIDTH-1] csp13_1_res2_filters1;
//wire [0:3*3*64*64*DATA_WIDTH-1] csp13_1_res2_filters2;
//wire [0:1*1*64*64*DATA_WIDTH-1] csp13_1_res3_filters1;
//wire [0:3*3*64*64*DATA_WIDTH-1] csp13_1_res3_filters2;
//wire [0:1*1*128*64*DATA_WIDTH-1] csp13_1_cbs2_filters;
//wire [0:1*1*128*128*DATA_WIDTH-1] csp13_1_cbso_filters;
//
//wire [0:3*3*128*256*DATA_WIDTH-1] filters4;
//
//wire [0:1*1*256*128*DATA_WIDTH-1] csp13_2_cbs1_filters;
//wire [0:1*1*128*128*DATA_WIDTH-1] csp13_2_res1_filters1;
//wire [0:3*3*128*128*DATA_WIDTH-1] csp13_2_res1_filters2;
//wire [0:1*1*128*128*DATA_WIDTH-1] csp13_2_res2_filters1;
//wire [0:3*3*128*128*DATA_WIDTH-1] csp13_2_res2_filters2;
//wire [0:1*1*128*128*DATA_WIDTH-1] csp13_2_res3_filters1;
//wire [0:3*3*128*128*DATA_WIDTH-1] csp13_2_res3_filters2;
//wire [0:1*1*256*128*DATA_WIDTH-1] csp13_2_cbs2_filters;
//wire [0:1*1*256*256*DATA_WIDTH-1] csp13_2_cbso_filters;
//
//wire [0:3*3*256*512*DATA_WIDTH-1] filters5;
//
//wire [0:1*1*512*256*DATA_WIDTH-1] spp1_filters1;
//wire [0:1*1*1024*512*DATA_WIDTH-1] spp1_filters2;
//
//wire [0:1*1*512*256*DATA_WIDTH-1] csp21_1_cbs11_filters;
//wire [0:1*1*256*256*DATA_WIDTH-1] csp21_1_cbs12_filters;
//wire [0:3*3*256*256*DATA_WIDTH-1] csp21_1_cbs13_filters;
//wire [0:1*1*512*256*DATA_WIDTH-1] csp21_1_cbs2_filters;
//wire [0:1*1*512*512*DATA_WIDTH-1] csp21_1_cbso_filters;
//
//wire [0:1*1*512*256*DATA_WIDTH-1] filters6;
//
//wire [0:1*1*512*128*DATA_WIDTH-1] csp21_2_cbs11_filters;
//wire [0:1*1*128*128*DATA_WIDTH-1] csp21_2_cbs12_filters;
//wire [0:3*3*128*128*DATA_WIDTH-1] csp21_2_cbs13_filters;
//wire [0:1*1*512*128*DATA_WIDTH-1] csp21_2_cbs2_filters;
//wire [0:1*1*256*256*DATA_WIDTH-1] csp21_2_cbso_filters;
//
//wire [0:1*1*256*128*DATA_WIDTH-1] filters7;
//
//wire [0:1*1*256*64*DATA_WIDTH-1] csp21_3_1_cbs11_filters;
//wire [0:1*1*64*64*DATA_WIDTH-1] csp21_3_1_cbs12_filters;
//wire [0:3*3*64*64*DATA_WIDTH-1] csp21_3_1_cbs13_filters;
//wire [0:1*1*256*64*DATA_WIDTH-1] csp21_3_1_cbs2_filters;
//wire [0:1*1*128*128*DATA_WIDTH-1] csp21_3_1_cbso_filters;
//
//wire [0:3*3*128*128*DATA_WIDTH-1] filters8;
//
//wire [0:1*1*256*128*DATA_WIDTH-1] csp21_3_2_cbs11_filters;
//wire [0:1*1*128*128*DATA_WIDTH-1] csp21_3_2_cbs12_filters;
//wire [0:3*3*128*128*DATA_WIDTH-1] csp21_3_2_cbs13_filters;
//wire [0:1*1*256*128*DATA_WIDTH-1] csp21_3_2_cbs2_filters;
//wire [0:1*1*256*256*DATA_WIDTH-1] csp21_3_2_cbso_filters;
//
//
//wire [0:1*1*128*75*DATA_WIDTH-1] filters_out_1;
//wire [0:1*1*256*75*DATA_WIDTH-1] filters_out_2;
//wire [0:1*1*512*75*DATA_WIDTH-1] filters_out_3;
//
//
//wire [0:3*3*256*256*DATA_WIDTH-1] filters9;
//
//wire [0:1*1*512*256*DATA_WIDTH-1] csp21_3_3_cbs11_filters;
//wire [0:1*1*256*256*DATA_WIDTH-1] csp21_3_3_cbs12_filters;
//wire [0:3*3*256*256*DATA_WIDTH-1] csp21_3_3_cbs13_filters;
//wire [0:1*1*512*256*DATA_WIDTH-1] csp21_3_3_cbs2_filters;
//wire [0:1*1*512*512*DATA_WIDTH-1] csp21_3_3_cbso_filters;
//
//
//
//
//slice#(.W(640), .H(640),.K(3)) s (x,slice);
//padding#(.W(320), .H(320),.K(12)) p1(slice,c1_in);
//
//CBS #(
//.D(12),
//.H(322),
//.W(322),
//.F(3),
//.K(32),
//.s(1),
//.beta(16'b0011110000000000),
//.gama(16'b0011110000000000),
//.quarter(16'b0011110000000000)//320
//)
//c1 (clk,reset,c1_in,filters1,c1_out);
//
//padding#(.W(320), .H(320),.K(32)) p2 (c1_out,c2_in);
//
//CBS #(
//.D(32),
//.H(322),
//.W(322),
//.F(3),
//.K(64),
//.s(2),
//.beta(16'b0011110000000000),
//.gama(16'b0011110000000000),
//.quarter(16'b0011110000000000)//160
//)
//c2 (clk,reset,c2_in,filters2,c2_out);
//
//CSP1_1#(
//.D(64),//Depth of image and filter
//.H(160), //Height of image
//.W(160), //Width of image
//.F(1), //Size of filter
//.cbs1_s(1),
//.cbs1_K(32), //Number of filters applied
//.cbs1_beta(16'b0000000000000000),//0
//.cbs1_gama(16'b0011110000000000),//1
//.cbs1_quarter(16'b0011010000000000),//160
//.cbs2_s(1),
//.cbs2_K(32), //Number of filters applied
//.cbs2_beta(16'b0000000000000000),
//.cbs2_gama(16'b0011110000000000),
//.cbs2_quarter(16'b0011010000000000),//160
//.res_s1(1),
//.res_s2(1),
//.res_K1(32), //Number of filters applied
//.res_beta(16'b0000000000000000),//0
//.res_gama(16'b0011110000000000),//1
//.res_quarter1(16'b0011010000000000),//160
//.res_quarter2(16'b0011010000000000),//160
//.cbso_s(1),
//.cbso_F(1), //Size of filter
//.cbso_K(64), //Number of filters applied
//.cbso_beta(16'b0000000000000000),
//.cbso_gama(16'b0011110000000000),
//.cbso_quarter(16'b0011010000000000))//160
//  csp11_1 (clk,reset,c2_out,csp11_1_cbs1_filters,csp11_1_res_filters1,csp11_1_res_filters2,csp11_1_cbs2_filters,csp11_1_cbso_filters,csp11_1_out);
//
//padding#(.W(160), .H(160),.K(64)) p3 (csp11_1_out,c3_in);
//
//CBS #(
//.D(64),
//.H(162),
//.W(162),
//.F(3),
//.K(128),
//.s(2),
//.beta(16'b0011110000000000),
//.gama(16'b0011110000000000),
//.quarter(16'b0011110000000000)//80
//)
//c3 (clk,reset,c3_in,filters3,c3_out);
//
//CSP1_3#(
//.D(128),
//.H(80),
//.W(80),
//.F(1),
//.cbs1_s(1),
//.cbs1_K(64),
//.cbs1_beta(16'b0011110000000000),
//.cbs1_gama(16'b0011110000000000),
//.cbs1_quarter(16'b0011110000000000),//80
//.cbs2_s(1),
//.cbs2_K(64),
//.cbs2_beta(16'b0011110000000000),
//.cbs2_gama(16'b0011110000000000),
//.cbs2_quarter(16'b0011110000000000),//80
//.res_s1(1),
//.res_s2(1),
//.res1_K1(64),
//.res2_K1(64),
//.res3_K1(64),
//.res1_beta(16'b0011110000000000),
//.res1_gama(16'b0011110000000000),
//.res1_quarter1(16'b0011110000000000),//80
//.res1_quarter2(16'b0011110000000000),//80
//.res2_beta(16'b0011110000000000),
//.res2_gama(16'b0011110000000000),
//.res2_quarter1(16'b0011110000000000),//80
//.res2_quarter2(16'b0011110000000000),//80
//.res3_beta(16'b0011110000000000),
//.res3_gama(16'b0011110000000000),
//.res3_quarter1(16'b0011110000000000),//80
//.res3_quarter2(16'b0011110000000000),//80
//.cbso_s(1),
//.cbso_F(1),
//.cbso_K(128),
//.cbso_beta(16'b0011110000000000),
//.cbso_gama(16'b0011110000000000),
//.cbso_quarter(16'b0011110000000000)//80
//)
//csp13_1(clk,reset,c3_out,csp13_1_cbs1_filters,csp13_1_res1_filters1,csp13_1_res1_filters2,csp13_1_cbs2_filters,csp13_1_cbso_filters,csp13_1_res2_filters1,csp13_1_res2_filters2,csp13_1_res3_filters1,csp13_1_res3_filters2,csp13_1_out);
//
//always@(csp13_1_out) csp13_1_out_temp <= csp13_1_out;
//
//padding#(.W(80), .H(80),.K(128)) p4 (csp13_1_out,c4_in);
//
//CBS #(
//.D(128),
//.H(82),
//.W(82),
//.F(3),
//.K(256),
//.s(2),
//.beta(16'b0011110000000000),
//.gama(16'b0011110000000000),
//.quarter(16'b0011110000000000)//80
//)
//c4 (clk,reset,c4_in,filters4,c4_out);
//
//CSP1_3#(
//.D(256),
//.H(40),
//.W(40),
//.F(1),
//.cbs1_s(1),
//.cbs1_K(128),
//.cbs1_beta(16'b0011110000000000),
//.cbs1_gama(16'b0011110000000000),
//.cbs1_quarter(16'b0011110000000000),//40
//.cbs2_s(1),
//.cbs2_K(128),
//.cbs2_beta(16'b0011110000000000),
//.cbs2_gama(16'b0011110000000000),
//.cbs2_quarter(16'b0011110000000000),//40
//.res_s1(1),
//.res_s2(1),
//.res1_K1(128),
//.res2_K1(128),
//.res3_K1(128),
//.res1_beta(16'b0011110000000000),
//.res1_gama(16'b0011110000000000),
//.res1_quarter1(16'b0011110000000000),//40
//.res1_quarter2(16'b0011110000000000),//40
//.res2_beta(16'b0011110000000000),
//.res2_gama(16'b0011110000000000),
//.res2_quarter1(16'b0011110000000000),//40
//.res2_quarter2(16'b0011110000000000),//40
//.res3_beta(16'b0011110000000000),
//.res3_gama(16'b0011110000000000),
//.res3_quarter1(16'b0011110000000000),//40
//.res3_quarter2(16'b0011110000000000),//40
//.cbso_s(1),
//.cbso_F(1),
//.cbso_K(256),
//.cbso_beta(16'b0011110000000000),
//.cbso_gama(16'b0011110000000000),
//.cbso_quarter(16'b0011110000000000)//40
//)
//csp13_2(clk,reset,c4_out,csp13_2_cbs1_filters,csp13_2_res1_filters1,csp13_2_res1_filters2,csp13_2_cbs2_filters,csp13_2_cbso_filters,csp13_2_res2_filters1,csp13_2_res2_filters2,csp13_2_res3_filters1,csp13_2_res3_filters2,csp13_2_out);
//
//always@(csp13_2_out) csp13_2_out_temp <= csp13_2_out;
//
//padding#(.W(40), .H(40),.K(256)) p5 (csp13_2_out,c5_in);
//
//CBS #(
//.D(256),
//.H(42),
//.W(42),
//.F(3),
//.K(512),
//.s(2),
//.beta(16'b0011110000000000),
//.gama(16'b0011110000000000),
//.quarter(16'b0011110000000000)//20
//)
//c5 (clk,reset,c5_in,filters5,c5_out);
//
// SPP#(
// .D(512),
// .H(20),
// .W(20),
// .cbs1_s(1),
// .cbs2_s(1),
// .F1(1),
// .K1(256),
// .beta1(16'b0011110000000000),
// .gama1(16'b0011110000000000),
// .quarter1(16'b0011110000000000),//20
// .F2(1),
// .K2(512),
// .beta2(16'b0011110000000000),
// .gama2(16'b0011110000000000),
// .quarter2(16'b0011110000000000)//20
// )
// spp1 (clk,reset,c5_out,spp1_filters1,spp1_filters2,spp1_out);
// 
// CSP2_1#(
//.D(512),
//.H(20),
//.W(20),
//.F(1),
//.cbs11_s(1),
//.cbs11_K(256),
//.cbs11_beta(16'b0011010000000000),
//.cbs11_gama(16'b0011010000000000),
//.cbs11_quarter(16'b0011010000000000),//20
//.cbs2_s(1),
//.cbs2_K(256),
//.cbs2_beta(16'b0011010000000000),
//.cbs2_gama(16'b0011010000000000),
//.cbs2_quarter(16'b0011010000000000),//20
//.cbs12_s(1),
//.cbs12_K(256),
//.cbs12_beta(16'b0011010000000000),
//.cbs12_gama(16'b0011010000000000),
//.cbs12_quarter(16'b0011010000000000),//20
//.cbs13_s(1),
//.cbs13_K(256),
//.cbs13_beta(16'b0011010000000000),
//.cbs13_gama(16'b0011010000000000),
//.cbs13_quarter(16'b0011010000000000),//20
//.cbso_s(1),
//.cbso_F(1),
//.cbso_K(512),
//.cbso_beta(16'b0011010000000000),
//.cbso_gama(16'b0011010000000000),
//.cbs11_quarter(16'b0011010000000000)//20
//)
//csp21_1 (clk,reset,spp1_out,csp21_1_cbs11_filters,csp21_1_cbs12_filters,csp21_1_cbs13_filters,csp21_1_cbs2_filters,csp21_1_cbso_filters,csp21_1_out);
// 
//CBS #(
//.D(512),
//.H(20),
//.W(20),
//.F(1),
//.K(256),
//.s(1),
//.beta(16'b0011110000000000),
//.gama(16'b0011110000000000),
//.quarter(16'b0011110000000000)//20
//)
//c6 (clk,reset,csp21_1_out,filters6,c6_out);
//
//always@(c6_out) csp21_1_c6_out_temp <= c6_out;
//
//UpSampleMulti#(.D(256),.W(20),.H(20)) up1 (c6_out,c6_out_upsample);
//
//assign csp21_2_in = {c6_out_upsample,csp13_2_out_temp};
//
//CSP2_1#(
//.D(512),
//.H(40),
//.W(40),
//.F(1),
//.cbs11_s(1),
//.cbs11_K(128),
//.cbs11_beta(16'b0011010000000000),
//.cbs11_gama(16'b0011010000000000),
//.cbs11_quarter(16'b0011010000000000),//40
//.cbs2_s(1),
//.cbs2_K(128),
//.cbs2_beta(16'b0011010000000000),
//.cbs2_gama(16'b0011010000000000),
//.cbs2_quarter(16'b0011010000000000),//40
//.cbs12_s(1),
//.cbs12_K(128),
//.cbs12_beta(16'b0011010000000000),
//.cbs12_gama(16'b0011010000000000),
//.cbs12_quarter(16'b0011010000000000),//40
//.cbs13_s(1),
//.cbs13_K(128),
//.cbs13_beta(16'b0011010000000000),
//.cbs13_gama(16'b0011010000000000),
//.cbs13_quarter(16'b0011010000000000),//40
//.cbso_s(1),
//.cbso_F(1),
//.cbso_K(256),
//.cbso_beta(16'b0011010000000000),
//.cbso_gama(16'b0011010000000000),
//.cbs11_quarter(16'b0011010000000000)//40
//)
//csp21_2 (clk,reset,csp21_2_in,csp21_2_cbs11_filters,csp21_2_cbs12_filters,csp21_2_cbs13_filters,csp21_2_cbs2_filters,csp21_2_cbso_filters,csp21_2_out);
//
//CBS #(
//.D(256),
//.H(40),
//.W(40),
//.F(1),
//.K(128),
//.s(1),
//.beta(16'b0011110000000000),
//.gama(16'b0011110000000000),
//.quarter(16'b0011110000000000)//40
//)
//c7 (clk,reset,csp21_2_out,filters7,c7_out);
//
//always@(c7_out) c7_out_temp <= c7_out;
//
//UpSampleMulti#(.D(128),.W(40),.H(40)) up2 (c7_out,c7_out_upsample);
//
//assign csp21_3_1_in = {csp13_1_out_temp,c7_out_upsample};
//
//CSP2_1#(
//.D(256),
//.H(80),
//.W(80),
//.F(1),
//.cbs11_s(1),
//.cbs11_K(64),
//.cbs11_beta(16'b0011010000000000),
//.cbs11_gama(16'b0011010000000000),
//.cbs11_quarter(16'b0011010000000000),//80
//.cbs2_s(1),
//.cbs2_K(64),
//.cbs2_beta(16'b0011010000000000),
//.cbs2_gama(16'b0011010000000000),
//.cbs2_quarter(16'b0011010000000000),//80
//.cbs12_s(1),
//.cbs12_K(64),
//.cbs12_beta(16'b0011010000000000),
//.cbs12_gama(16'b0011010000000000),
//.cbs12_quarter(16'b0011010000000000),//80
//.cbs13_s(1),
//.cbs13_K(64),
//.cbs13_beta(16'b0011010000000000),
//.cbs13_gama(16'b0011010000000000),
//.cbs13_quarter(16'b0011010000000000),//80
//.cbso_s(1),
//.cbso_F(1),
//.cbso_K(128),
//.cbso_beta(16'b0011010000000000),
//.cbso_gama(16'b0011010000000000),
//.cbs11_quarter(16'b0011010000000000)//80
//)
//csp21_3_1 (clk,reset,csp21_3_1_in,csp21_3_1_cbs11_filters,csp21_3_1_cbs12_filters,csp21_3_1_cbs13_filters,csp21_3_1_cbs2_filters,csp21_3_1_cbso_filters,csp21_3_1_out);
//
//always@(csp21_3_1_out) csp21_3_1_out_temp <= csp21_3_1_out;
//
//convLayerMulti #(
//.D(128), //Depth of image and filter
//.H(80), //Height of image
//.W(80), //Width of image
//.F(1), //Size of filter
//.K(75),
//.s(1)) 
//conv1 (clk,reset,csp21_3_1_out,filters_out_1,out_yolo1);
//
//padding#(.W(80), .H(80),.K(128)) p6 (csp21_3_1_out_temp,c8_in);
//
//
//CBS #(
//.D(128),
//.H(82),
//.W(82),
//.F(3),
//.K(128),
//.s(2),
//.beta(16'b0011110000000000),
//.gama(16'b0011110000000000),
//.quarter(16'b0011110000000000)//40
//)
//c8 (clk,reset,c8_in,filters8,c8_out);
//
//assign csp21_3_2_in = {c8_out,c7_out_temp};
//
//CSP2_1#(
//.D(256),
//.H(40),
//.W(40),
//.F(1),
//.cbs11_s(1),
//.cbs11_K(128),
//.cbs11_beta(16'b0011010000000000),
//.cbs11_gama(16'b0011010000000000),
//.cbs11_quarter(16'b0011010000000000),//40
//.cbs2_s(1),
//.cbs2_K(128),
//.cbs2_beta(16'b0011010000000000),
//.cbs2_gama(16'b0011010000000000),
//.cbs2_quarter(16'b0011010000000000),//40
//.cbs12_s(1),
//.cbs12_K(128),
//.cbs12_beta(16'b0011010000000000),
//.cbs12_gama(16'b0011010000000000),
//.cbs12_quarter(16'b0011010000000000),//40
//.cbs13_s(1),
//.cbs13_K(128),
//.cbs13_beta(16'b0011010000000000),
//.cbs13_gama(16'b0011010000000000),
//.cbs13_quarter(16'b0011010000000000),//40
//.cbso_s(1),
//.cbso_F(1),
//.cbso_K(256),
//.cbso_beta(16'b0011010000000000),
//.cbso_gama(16'b0011010000000000),
//.cbs11_quarter(16'b0011010000000000)//40
//)
//csp21_3_2 (clk,reset,csp21_3_2_in,csp21_3_2_cbs11_filters,csp21_3_2_cbs12_filters,csp21_3_2_cbs13_filters,csp21_3_2_cbs2_filters,csp21_3_2_cbso_filters,csp21_3_2_out);
//
//convLayerMulti #(
//.D(256), //Depth of image and filter
//.H(40), //Height of image
//.W(40), //Width of image
//.F(1), //Size of filter
//.K(75),
//.s(1)) 
//conv2 (clk,reset,csp21_3_2_out,filters_out_2,out_yolo2);
//
//always@(csp21_3_2_out) csp21_3_2_out_temp <= csp21_3_2_out;
//
//padding#(.W(40), .H(40),.K(256)) p7 (csp21_3_2_out_temp,c9_in);
//
//
//CBS #(
//.D(256),
//.H(42),
//.W(42),
//.F(3),
//.K(256),
//.s(2),
//.beta(16'b0011110000000000),
//.gama(16'b0011110000000000),
//.quarter(16'b0011110000000000)//20
//)
//c9 (clk,reset,c9_in,filters9,c9_out);
//
//assign csp21_3_3_in = {c9_out,csp21_1_c6_out_temp}
//
//CSP2_1#(
//.D(512),
//.H(20),
//.W(20),
//.F(1),
//.cbs11_s(1),
//.cbs11_K(256),
//.cbs11_beta(16'b0011010000000000),
//.cbs11_gama(16'b0011010000000000),
//.cbs11_quarter(16'b0011010000000000),//20
//.cbs2_s(1),
//.cbs2_K(256),
//.cbs2_beta(16'b0011010000000000),
//.cbs2_gama(16'b0011010000000000),
//.cbs2_quarter(16'b0011010000000000),//20
//.cbs12_s(1),
//.cbs12_K(256),
//.cbs12_beta(16'b0011010000000000),
//.cbs12_gama(16'b0011010000000000),
//.cbs12_quarter(16'b0011010000000000),//20
//.cbs13_s(1),
//.cbs13_K(256),
//.cbs13_beta(16'b0011010000000000),
//.cbs13_gama(16'b0011010000000000),
//.cbs13_quarter(16'b0011010000000000),//20
//.cbso_s(1),
//.cbso_F(1),
//.cbso_K(512),
//.cbso_beta(16'b0011010000000000),
//.cbso_gama(16'b0011010000000000),
//.cbs11_quarter(16'b0011010000000000)//20
//)
//csp21_3_3 (clk,reset,csp21_3_3_in,csp21_3_3_cbs11_filters,csp21_3_3_cbs12_filters,csp21_3_3_cbs13_filters,csp21_3_3_cbs2_filters,csp21_3_3_cbso_filters,csp21_3_3_out);
//
//convLayerMulti #(
//.D(512), //Depth of image and filter
//.H(20), //Height of image
//.W(20), //Width of image
//.F(1), //Size of filter
//.K(75),
//.s(1)) 
//conv3 (clk,reset,csp21_3_3_out,filters_out_3,out_yolo3);
//
//endmodule
//