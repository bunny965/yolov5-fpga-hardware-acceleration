//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved	                               
//----------------------------------------------------------------------------------------
// File name:           uart_recv
// Last modified Date:  2019/10/9 9:56:36
// Last Version:        V1.1
// Descriptions:        UART串口接收模块
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2019/10/9 9:56:36
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module uart_recv(
    input			  sys_clk,                  //系统时钟
    input             sys_rst_n,                //系统复位，低电平有效
    
    input             uart_rxd,                 //UART接收端口
    output  reg       uart_done,                //接收一帧数据完成标志
    output  reg       rx_flag,                  //接收过程标志信号
    output  reg [ 3:0] rx_cnt,                  //接收数据计数器
    output  reg [ 7:0] rxdata,
    output  reg [7:0] uart_data                 //接收的数据
    );
    
//parameter define
parameter  CLK_FREQ = 50000000;                //系统时钟频率
parameter  UART_BPS = 9600;                    //串口波特率
localparam  BPS_CNT  = CLK_FREQ/UART_BPS;       //为得到指定波特率，
                                                //需要对系统时钟计数BPS_CNT次
//reg define
reg        uart_rxd_d0;
reg        uart_rxd_d1;
reg [15:0] clk_cnt;                              //系统时钟计数器

//wire define
wire       start_flag;

//*****************************************************
//**                    main code
//*****************************************************
//捕获接收端口下降沿(起始位)，得到一个时钟周期的脉冲信号
assign  start_flag = uart_rxd_d1 & (~uart_rxd_d0);    

//对UART接收端口的数据延迟两个时钟周期
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        uart_rxd_d0 <= 1'b0;
        uart_rxd_d1 <= 1'b0;          
    end
    else begin
        uart_rxd_d0  <= uart_rxd;                   
        uart_rxd_d1  <= uart_rxd_d0;
    end   
end

//当脉冲信号start_flag到达时，进入接收过程           
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)                                  
        rx_flag <= 1'b0;
    else begin
        if(start_flag)                          //检测到起始位
            rx_flag <= 1'b1;                    //进入接收过程，标志位rx_flag拉高
                                                //计数到停止位中间时，停止接收过程
        else if((rx_cnt == 4'd9) && (clk_cnt == BPS_CNT/2))
            rx_flag <= 1'b0;                    //接收过程结束，标志位rx_flag拉低
        else
            rx_flag <= rx_flag;
    end
end

//进入接收过程后，启动系统时钟计数器
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)                             
        clk_cnt <= 16'd0;                                  
    else if ( rx_flag ) begin                   //处于接收过程
        if (clk_cnt < BPS_CNT - 1)
            clk_cnt <= clk_cnt + 1'b1;
        else
            clk_cnt <= 16'd0;               	//对系统时钟计数达一个波特率周期后清零
    end
    else                              				
        clk_cnt <= 16'd0;						//接收过程结束，计数器清零
end

//进入接收过程后，启动接收数据计数器
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)                             
        rx_cnt  <= 4'd0;
    else if ( rx_flag ) begin                   //处于接收过程
        if (clk_cnt == BPS_CNT - 1)				//对系统时钟计数达一个波特率周期
            rx_cnt <= rx_cnt + 1'b1;			//此时接收数据计数器加1
        else
            rx_cnt <= rx_cnt;       
    end
	 else
        rx_cnt  <= 4'd0;						//接收过程结束，计数器清零
end

//根据接收数据计数器来寄存uart接收端口数据
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( !sys_rst_n)  
        rxdata <= 8'd0;                                     
    else if(rx_flag)                            //系统处于接收过程
        if (clk_cnt == BPS_CNT/2) begin         //判断系统时钟计数器计数到数据位中间
            case ( rx_cnt )
             4'd1 : rxdata[0] <= uart_rxd_d1;   //寄存数据位最低位
             4'd2 : rxdata[1] <= uart_rxd_d1;
             4'd3 : rxdata[2] <= uart_rxd_d1;
             4'd4 : rxdata[3] <= uart_rxd_d1;
             4'd5 : rxdata[4] <= uart_rxd_d1;
             4'd6 : rxdata[5] <= uart_rxd_d1;
             4'd7 : rxdata[6] <= uart_rxd_d1;
             4'd8 : rxdata[7] <= uart_rxd_d1;   //寄存数据位最高位
             default:;                                    
            endcase
        end
        else 
            rxdata <= rxdata;
    else
        rxdata <= 8'd0;
end

//数据接收完毕后给出标志信号并寄存输出接收到的数据
always @(posedge sys_clk or negedge sys_rst_n) begin        
    if (!sys_rst_n) begin
        uart_data <= 8'd0;                               
        uart_done <= 1'b0;
    end
    else if(rx_cnt == 4'd9) begin               //接收数据计数器计数到停止位时           
        uart_data <= rxdata;                    //寄存输出接收到的数据
        uart_done <= 1'b1;                      //并将接收完成标志位拉高
    end
    else begin
        uart_data <= 8'd0;                                   
        uart_done <= 1'b0; 
    end    
end

endmodule	
