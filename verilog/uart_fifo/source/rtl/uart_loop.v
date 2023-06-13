//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved	                               
//----------------------------------------------------------------------------------------
// File name:           uart_loop
// Last modified Date:  2019/10/8 17:25:36
// Last Version:        V1.1
// Descriptions:        串口数据环回模块
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2019/10/8 17:25:36
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module uart_loop(
    input	         sys_clk,                   //系统时钟
    input            sys_rst_n,                 //系统复位，低电平有效
     
    input            recv_done,                 //接收一帧数据完成标志
    input      [7:0] recv_data,                 //接收的数据
     
    input            tx_busy,                   //发送忙状态标志      
    output reg       send_en,                   //发送使能信号
    output reg [7:0] send_data                  //待发送数据
    );

//reg define
reg recv_done_d0;
reg recv_done_d1;
reg tx_ready;

//wire define
wire recv_done_flag;

//*****************************************************
//**                    main code
//*****************************************************

//捕获recv_done上升沿，得到一个时钟周期的脉冲信号
assign recv_done_flag = (~recv_done_d1) & recv_done_d0;
                                                 
//对发送使能信号recv_done延迟两个时钟周期
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        recv_done_d0 <= 1'b0;                                  
        recv_done_d1 <= 1'b0;
    end                                                      
    else begin                                               
        recv_done_d0 <= recv_done;                               
        recv_done_d1 <= recv_done_d0;                            
    end
end

//判断接收完成信号，并在串口发送模块空闲时给出发送使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        tx_ready  <= 1'b0; 
        send_en   <= 1'b0;
        send_data <= 8'd0;
    end                                                      
    else begin                                               
        if(recv_done_flag)begin                 //检测串口接收到数据
            tx_ready  <= 1'b1;                  //准备启动发送过程
            send_en   <= 1'b0;
            send_data <= recv_data;             //寄存串口接收的数据
        end
        else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
            tx_ready <= 1'b0;                   //准备过程结束
            send_en  <= 1'b1;                   //拉高发送使能信号
        end
    end
end

endmodule 
