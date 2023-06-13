//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved	                               
//----------------------------------------------------------------------------------------
// File name:           uart_send
// Last modified Date:  2019/10/9 10:07:36
// Last Version:        V1.1
// Descriptions:        UART串口发送模块
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2019/10/9 10:07:36
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module uart_send(
    input	      sys_clk,                  //系统时钟
    input         sys_rst_n,                //系统复位，低电平有效
    
    input         uart_en,                  //发送使能信号
    input  [7:0]  uart_din,                 //待发送数据
    output        uart_tx_busy,             //发送忙状态标志 
    output        en_flag     ,
    output  reg [ 7:0] tx_data,             //寄存发送数据
    output  reg [ 3:0] tx_cnt,              //发送数据计数器
    output  reg   uart_txd                  //UART发送端口
    );
    
//parameter define
parameter  CLK_FREQ = 50000000;            //系统时钟频率
parameter  UART_BPS = 9600;                //串口波特率
localparam  BPS_CNT  = CLK_FREQ/UART_BPS;   //为得到指定波特率，对系统时钟计数BPS_CNT次

//reg define
reg        uart_en_d0; 
reg        uart_en_d1;  
reg [15:0] clk_cnt;                           //系统时钟计数器
reg        tx_flag;                  //发送过程标志信号

//wire define
wire       en_flag;

//*****************************************************
//**                    main code
//*****************************************************
//在串口发送过程中给出忙状态标志
assign uart_tx_busy = tx_flag; 

//捕获uart_en上升沿，得到一个时钟周期的脉冲信号
assign en_flag = (~uart_en_d1) & uart_en_d0;

//对发送使能信号uart_en延迟两个时钟周期
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        uart_en_d0 <= 1'b0;                                  
        uart_en_d1 <= 1'b0;
    end                                                      
    else begin                                               
        uart_en_d0 <= uart_en;                               
        uart_en_d1 <= uart_en_d0; 		  
    end
end

//当脉冲信号en_flag到达时,寄存待发送的数据，并进入发送过程          
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin                                  
        tx_flag <= 1'b0;
        tx_data <= 8'd0;
    end 
    else if (en_flag) begin                 //检测到发送使能上升沿                      
            tx_flag <= 1'b1;                //进入发送过程，标志位tx_flag拉高				
            tx_data <= uart_din;            //寄存待发送的数据
        end
                                            //计数到停止位结束时，停止发送过程
        else if ((tx_cnt == 4'd9) && (clk_cnt == BPS_CNT - (BPS_CNT/16))) begin                                       
            tx_flag <= 1'b0;                //发送过程结束，标志位tx_flag拉低				
            tx_data <= 8'd0;
        end
        else begin
            tx_flag <= tx_flag;
            tx_data <= tx_data;
        end 
end

//进入发送过程后，启动系统时钟计数器
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)                             
        clk_cnt <= 16'd0;                                  
    else if (tx_flag) begin                 //处于发送过程
        if (clk_cnt < BPS_CNT - 1)
            clk_cnt <= clk_cnt + 1'b1;
        else
            clk_cnt <= 16'd0;               //对系统时钟计数达一个波特率周期后清零
    end
    else                             
        clk_cnt <= 16'd0; 				    //发送过程结束
end

//进入发送过程后，启动发送数据计数器
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)                             
        tx_cnt <= 4'd0;
    else if (tx_flag) begin                 //处于发送过程
        if (clk_cnt == BPS_CNT - 1)			//对系统时钟计数达一个波特率周期
            tx_cnt <= tx_cnt + 1'b1;		//此时发送数据计数器加1
        else
            tx_cnt <= tx_cnt;       
    end
    else                              
        tx_cnt  <= 4'd0;				    //发送过程结束
end

//根据发送数据计数器来给uart发送端口赋值
always @(posedge sys_clk or negedge sys_rst_n) begin        
    if (!sys_rst_n)  
        uart_txd <= 1'b1;        
    else if (tx_flag)
        case(tx_cnt)
            4'd0: uart_txd <= 1'b0;         //起始位 
            4'd1: uart_txd <= tx_data[0];   //数据位最低位
            4'd2: uart_txd <= tx_data[1];
            4'd3: uart_txd <= tx_data[2];
            4'd4: uart_txd <= tx_data[3];
            4'd5: uart_txd <= tx_data[4];
            4'd6: uart_txd <= tx_data[5];
            4'd7: uart_txd <= tx_data[6];
            4'd8: uart_txd <= tx_data[7];   //数据位最高位
            4'd9: uart_txd <= 1'b1;         //停止位
            default: ;
        endcase
    else 
        uart_txd <= 1'b1;                   //空闲时发送端口为高电平
end

endmodule	          
