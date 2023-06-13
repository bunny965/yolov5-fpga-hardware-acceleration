`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:Meyesemi 
// Engineer: Will
// 
// Create Date: 2023-01-29 20:31  
// Design Name:  
// Module Name: 
// Project Name: 
// Target Devices: Pango
// Tool Versions: 
// Description: 
//      
// Dependencies: 
// 
// Revision:
// Revision 1.0 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1

module hdmi_loop(
    input wire        sys_clk,     // input system clock 50MHz
    
    output            rstn_out,
    output            iic_scl,
    inout             iic_sda, 
    output            iic_tx_scl,
    inout             iic_tx_sda, 
    input             pixclk_in,                            
    input             vs_in, 
    input             hs_in, 
    input             de_in,
    input     [7:0]   r_in, 
    input     [7:0]   g_in, 
    input     [7:0]   b_in,  

    output               pixclk_out,                            
    output reg           vs_out, 
    output reg           hs_out, 
    output reg           de_out,
    output reg    [7:0]  r_out, 
    output reg    [7:0]  g_out, 
    output reg    [7:0]  b_out,
    output               led_int
);

    parameter   X_WIDTH = 4'd12;
    parameter   Y_WIDTH = 4'd12;    
//MODE_1080p
    parameter V_TOTAL = 12'd1125;
    parameter V_FP = 12'd4;
    parameter V_BP = 12'd36;
    parameter V_SYNC = 12'd5;
    parameter V_ACT = 12'd1080;
    parameter H_TOTAL = 12'd2200;
    parameter H_FP = 12'd88;
    parameter H_BP = 12'd148;
    parameter H_SYNC = 12'd44;
    parameter H_ACT = 12'd1920;
    parameter HV_OFFSET = 12'd0;

    reg [15:0]  rstn_1ms       ;
    wire        pix_clk        ;
    wire        cfg_clk        ;
    wire        locked         ;

    PLL u_pll (
      .clkin1       (sys_clk   ),   // input//50MHz
      .pll_lock     (locked    ),   // output
      .clkout0      (cfg_clk   )    // output//10MHz
    );

    ms72xx_ctl ms72xx_ctl(
        .clk         (  cfg_clk    ), //input       clk,
        .rst_n       (  rstn_out   ), //input       rstn,
                                
        .init_over   (  init_over  ), //output      init_over,
        .iic_tx_scl  (  iic_tx_scl ), //output      iic_scl,
        .iic_tx_sda  (  iic_tx_sda ), //inout       iic_sda
        .iic_scl     (  iic_scl    ), //output      iic_scl,
        .iic_sda     (  iic_sda    )  //inout       iic_sda
    );

    assign    led_int  =  init_over; 

    always @(posedge cfg_clk)
    begin
    	if(!locked)
    	    rstn_1ms <= 16'd0;
    	else
    	begin
    		if(rstn_1ms == 16'h2710)
    		    rstn_1ms <= rstn_1ms;
    		else
    		    rstn_1ms <= rstn_1ms + 1'b1;
    	end
    end
    
    assign rstn_out = (rstn_1ms == 16'h2710);

//HDMI_OUT  =  HDMI_IN 
    assign pixclk_out   =  pixclk_in    ;

    always  @(posedge pixclk_out)begin
        if(!init_over)begin
    	        vs_out       <=  1'b0        ;
            hs_out       <=  1'b0        ;
            de_out       <=  1'b0        ;
            r_out        <=  8'b0        ;
            g_out        <=  8'b0        ;
            b_out        <=  8'b0        ;
        end
    	    else begin
            vs_out       <=  vs_in        ;
            hs_out       <=  hs_in        ;
            de_out       <=  de_in        ;
            r_out        <=  r_in         ;
            g_out        <=  g_in         ;
            b_out        <=  b_in         ;
        end
    end

endmodule
