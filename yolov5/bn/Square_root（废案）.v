`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/22 15:39:31
// Design Name: 
// Module Name: Square_root
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


module Square_root(x,reset,clk,OutputFinal,Finished);
parameter DATA_WIDTH = 16;
//assign coeff = 144'b0011110000000000_0011100000000000_1011000000000000_0010110000000000_1010100100000000_0010011100000000_0010010101000000_0010010000100000_1010001010110100;
input signed [DATA_WIDTH-1:0] x;

input clk;
input reset;
output reg Finished;
output reg[DATA_WIDTH-1:0]  OutputFinal;
reg [DATA_WIDTH*5-1:0] Coefficients ; 
wire [DATA_WIDTH-1:0] Xsquared; //To always generate a squared version of the input to increment the power by 2 always.
wire [DATA_WIDTH-1:0] ForXSqOrOne; //For Multiplying The power of X(1 or X^2)
reg [DATA_WIDTH-1:0] ForMultPrevious; //output of the first multiplication which is either with 1 or x(X or Output1)
wire [DATA_WIDTH-1:0] OutputOne; //the output of Mulitplying the X term with its corresponding power coeff.
wire [DATA_WIDTH-1:0] OutOfCoeffMult; //the output of Mulitplying the X term with its corresponding power coeff.
reg  [DATA_WIDTH-1:0] OutputAdditionInAlways;
wire [DATA_WIDTH-1:0] OutputAddition; //the output of the Addition each cycle 

floatAdd x_sub1 (x,16'b1011110000000000,ForXSqOrOne);
floatMult MGeneratingXterm (ForXSqOrOne,ForMultPrevious,OutputOne); //Generating the X term [x,x^2,x^3,x^4,x^5,...] x:input-1
floatMult MTheCoefficientTerm (OutputOne,Coefficients[DATA_WIDTH-1:0],OutOfCoeffMult); //Multiplying the X term by its corresponding coeff.
floatAdd FADD1 (OutOfCoeffMult,OutputAdditionInAlways,OutputAddition); //Adding the new term to the previous one     ex: x-1/3*(x^3)
always @ (posedge clk) begin
    
    if(reset==1'b1)begin  
        Coefficients<=80'b0010011100000000_1010100100000000_0010110000000000_1011000000000000_0011100000000000;//the 8 coefficients of taylor expansion
        OutputAdditionInAlways<=16'b0011110000000000; //initially 1
        ForMultPrevious<=16'b0011110000000000;
    Finished<=0;
    end
    else begin
        ForMultPrevious<=OutputOne; 
        Coefficients<=Coefficients>>DATA_WIDTH; 
      OutputAdditionInAlways<=OutputAddition;
      Finished<=0;
    end
    // the end of the sigmoid
    if(Coefficients==80'b0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000)begin 
        OutputFinal<=OutputAddition;
        Finished <=1'b 1;
    end
end 
endmodule
