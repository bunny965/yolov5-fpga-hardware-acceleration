module tx_top(
    input           sys_clk,            //外部50M时钟
    input           sys_rst_n,          //外部复位信号，低有效
    input           uart_en,
    input	[255:0]      dout       ,  //数据输入
    input             dout_vld   ,  //数据允许输入标志位

    input             ready      ,  //fifo准备位，可与busy相连
    output  [7:0] uart_txd,
    output        uart_tx_busy             //发送忙状态标志 

);
wire       uart_tx_busy;                //UART发送忙状态标志
wire  [7:0] uart_din;
wire [7:0] din;
assign din = uart_din;
wire din_vld;



//parameter define
parameter  CLK_FREQ = 50000000;         //定义系统时钟频率
parameter  UART_BPS = 115200;   
uart_send #(                          
    .CLK_FREQ       (CLK_FREQ),         //设置系统时钟频率
    .UART_BPS       (UART_BPS))         //设置串口发送波特率
u_uart_send(                 
    .sys_clk        (sys_clk),
    .sys_rst_n      (sys_rst_n),
     
    .uart_en        (uart_en),
    .uart_din       (uart_din),
    .uart_tx_busy   (uart_tx_busy),
    .uart_txd       (uart_txd)
    );


control_fifo1 control_fifo1(
    .clk            ( sys_clk )  ,
    .rst_n          (sys_rst_n )  ,
    .dout           (dout   )  ,
    .dout_vld     (dout_vld),
    .ready          (ready)  ,
    .dout_vld(dout_vld),
    .din           (din  )  ,
    .din_vld          (din_vld)
   );


endmodule