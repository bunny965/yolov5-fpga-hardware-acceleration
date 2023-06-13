`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 23:47:32
// Design Name: 
// Module Name: floatADivB16
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


module floatADivB16( floatA,
           floatB,
           product);

input [15:0] floatA, floatB;
output reg [15:0] product;

reg sign;
reg signed[5:0] exponent;
reg [5:0] exponentA,exponentB;
reg [9:0] mantissa;
reg [15:0] regA, regB;
reg [21:0] fractionA, fractionB,fraction;
reg step;

integer i;

always @(floatA or floatB)begin
      if(floatA == 0)begin
        product = 0;
      end else if(floatB == 0)begin
        product = 0;
      end else begin
         sign = floatA[15]^floatB[15];
         exponentA = {1'b0,floatA[14:10]};
         exponentB = {1'b0,floatB[14:10]};
         exponent = exponentA + 5'd15 - exponentB + 5'd1;
         
       fractionA = {11'b0,1'b1,floatA[9:0]};
       fractionB = {1'b1,floatB[9:0],11'b0};
       
       fraction = 22'b0;
    
        for(i=0;i<32;i=i+1)begin
           fractionA = fractionA<<1;
           fraction = fraction<<1;
           if(fractionA >= fractionB)begin
           fractionA = fractionA - fractionB;
           fraction = fraction + 22'b1;
           end else begin
           fractionA = fractionA;
           fraction = fraction;
           end
        end
  
        if (fraction[21] == 1'b1) begin
            fraction = fraction << 1;
            exponent = exponent - 1; 
        end else if (fraction[20] == 1'b1) begin
            fraction = fraction << 2;
            exponent = exponent - 2;
        end else if (fraction[19] == 1'b1) begin
            fraction = fraction << 3;
            exponent = exponent - 3;
        end else if (fraction[18] == 1'b1) begin
            fraction = fraction << 4;
            exponent = exponent - 4;
        end else if (fraction[17] == 1'b1) begin
            fraction = fraction << 5;
            exponent = exponent - 5;
        end else if (fraction[16] == 1'b1) begin
            fraction = fraction << 6;
            exponent = exponent - 6;
        end else if (fraction[15] == 1'b1) begin
            fraction = fraction << 7;
            exponent = exponent - 7;
        end else if (fraction[14] == 1'b1) begin
            fraction = fraction << 8;
            exponent = exponent - 8;
        end else if (fraction[13] == 1'b1) begin
            fraction = fraction << 9;
            exponent = exponent - 9;
        end else if (fraction[12] == 1'b0) begin
            fraction = fraction << 10;
            exponent = exponent - 10;
        end 
        
        mantissa = fraction[21:12];
        if(exponent[5]==1'b1) begin //exponent is negative
            product=16'b0000000000000000;
        end
        else begin
            product = {sign,exponent[4:0],mantissa};
        end        
        
        
        
     end
 end
    
    

endmodule
