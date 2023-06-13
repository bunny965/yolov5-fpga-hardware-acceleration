`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/22 18:57:25
// Design Name: 
// Module Name: Square_root
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// get square_root's daoshu;
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Square_root(x,out,clk,reset);
parameter DATA_WIDTH = 16;

input clk,reset;
input [DATA_WIDTH-1:0] x;
output [DATA_WIDTH-1:0] out;
reg [DATA_WIDTH-1:0] pre,ans,pre_i,a,yi_pai,out_o;
wire [DATA_WIDTH-1:0]add,mul1,mul2,mul3,sub,ans_o;
wire flag1,flag2;
reg flag3;//flag4;
floatMult m1 (x,16'b0011100000000000,mul1);
floatMult m2 (ans,ans,mul2);
floatMult m3 (mul1,mul2,mul3);
floatAdd a1 (16'b0011111000000000,pre_i,add);
floatMult m4 (ans,add,ans_o);
always @ (ans) begin
a[15] <= ~ans[15];
a[14:0] <= ans[14:0];
end

floatAdd a5 (ans_o,ans,sub);

always @ (mul3)begin
pre_i[15] <= ~mul3[15];
pre_i[14:0] <= mul3[14:0];
end
always @ (posedge clk or posedge reset) begin
    if(reset == 1'b1) begin
    ans <= 16'b0011110000000000;
    yi_pai <=16'b1111111111111111;
    end
    else begin
    ans <= ans_o;
    yi_pai <= ans;
    end
end
equal e1 (ans,yi_pai,flag1);
equal e2 (ans,ans_o,flag2);
always@(sub) begin
if(sub[14:0]<= 15'b000001000000000)
flag3<=1'b1;
else 
flag3<=1'b0;
end
/*always@(out)
begin
if(out[15]==1'b1) flag4<=1'b1;
else flag4<=1'b0;
end*/
always @ ( flag1  or flag2 or flag3) begin
   // if(flag4) out<=16'b0011110000000000;
    if((flag1 & flag2)|flag3) begin
        out_o <= ans_o;
    end
end
assign out = out_o;
endmodule
