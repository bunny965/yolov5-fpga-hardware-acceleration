`timescale 1 ns / 10 ps

module AvgUnit (x,AvgOut,clk,reset);
  
parameter DATA_WIDTH = 16;
parameter quarter = 16'b0011010000000000;
parameter size = 4;
parameter channel = 1;
parameter size_div_channel = size/channel;

input clk,reset;
input [DATA_WIDTH*size_div_channel-1:0] x;
output [DATA_WIDTH-1:0] AvgOut;
wire [DATA_WIDTH-1:0] sum;
reg [DATA_WIDTH-1:0] add;
reg flag,flag2;
reg [10:0] num;
reg [DATA_WIDTH*size_div_channel-1:0] x_temp;
reg [DATA_WIDTH-1:0] sum_temp;

always @( clk or reset or  flag or  flag2) begin
    if(reset==1'b1) begin
        num<=0;
        x_temp<=0;
        sum_temp<=0;
    end else begin
        x_temp<=x;
        sum_temp<=sum;
        if(flag==1'b1) begin
            num<=0;
            sum_temp<=0;
            //cheng<=16'b0000000000000000;
        end else begin
            //cheng<=16'b0011110000000000;
          //  if(cheng==16'b0011110000000000) begin
                if(flag2==1'b1) num<=num;
                else    num<=num+1;
           // end
        end
    end
end


always @(x or x_temp) begin
if(x==x_temp)
 flag<=1'b0;
else 
flag<=1'b1;
end

always @(num) begin
    if(num>size_div_channel+2) flag2<=1'b1;
     else flag2<=1'b0;

    if(num<size_div_channel) begin
        add<=x[num*DATA_WIDTH+:DATA_WIDTH];
    end else begin
        add<=0;
    end
end

floatAdd FADD1 (add,sum_temp,sum);

//floatMult FM (sum,cheng,sum);  

floatMult FM1 (sum,quarter,AvgOut);  

endmodule