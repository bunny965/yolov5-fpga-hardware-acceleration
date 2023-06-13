`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 22:45:54
// Design Name: 
// Module Name: Sigmoid
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


module Sigmoid(x,reset,clk,OutputFinal);
localparam DATA_WIDTH = 16;
//assign coeff = 63'b0011100000000000_0011010000000000_1010010101010101_0001100001000100;
input signed [DATA_WIDTH-1:0] x;

input clk;
input reset;
output reg[DATA_WIDTH-1:0]  OutputFinal;
reg [DATA_WIDTH*3-1:0] Coefficients ; 
wire [DATA_WIDTH-1:0] Xsquared; //To always generate a squared version of the input to increment the power by 2 always.
reg [DATA_WIDTH-1:0] ForXSqOrOne; //For Multiplying The power of X(1 or X^2)
reg [DATA_WIDTH-1:0] ForMultPrevious; //output of the first multiplication which is either with 1 or x(X or Output1)
wire [DATA_WIDTH-1:0] OutputOne; //the output of Mulitplying the X term with its corresponding power coeff.
wire [DATA_WIDTH-1:0] OutOfCoeffMult; //the output of Mulitplying the X term with its corresponding power coeff.
reg  [DATA_WIDTH-1:0] OutputAdditionInAlways;
wire [DATA_WIDTH-1:0] OutputAddition; //the output of the Addition each cycle 

floatMult MSquaring (x,x,Xsquared);//Generating x^2
floatMult MGeneratingXterm (ForXSqOrOne,ForMultPrevious,OutputOne); //Generating the X term [x,x^3,x^5,...]
floatMult MTheCoefficientTerm (OutputOne,Coefficients[DATA_WIDTH-1:0],OutOfCoeffMult); //Multiplying the X term by its corresponding coeff.
floatAdd FADD1 (OutOfCoeffMult,OutputAdditionInAlways,OutputAddition); //Adding the new term to the previous one     ex: x-1/3*(x^3)
always @ (posedge clk) begin
    
    if(reset==1'b1)begin  
        Coefficients<=48'b0001100001000100_1010010101010101_0011010000000000;//the 3 coefficients of taylor expansion
        ForXSqOrOne<=16'b0011110000000000; //initially 1
        OutputAdditionInAlways<=16'b0011100000000000; //initially 0.5
        ForMultPrevious<=x;
    end
    else begin
        ForXSqOrOne<=Xsquared;
        ForMultPrevious<=OutputOne; 
        Coefficients<=Coefficients>>DATA_WIDTH; 
      OutputAdditionInAlways<=OutputAddition;
    end
    // the end of the sigmoid
    if(Coefficients==48'b0000000000000000_0000000000000000_0000000000000000)begin 
        OutputFinal<=OutputAddition;
    end
end 
endmodule
