module tx_top(
    input           sys_clk,            //�ⲿ50Mʱ��
    input           sys_rst_n,          //�ⲿ��λ�źţ�����Ч
    input           uart_en,
    input	[255:0]      dout       ,  //��������
    input             dout_vld   ,  //�������������־λ

    input             ready      ,  //fifo׼��λ������busy����
    output  [7:0] uart_txd,
    output        uart_tx_busy             //����æ״̬��־ 

);
wire       uart_tx_busy;                //UART����æ״̬��־
wire  [7:0] uart_din;
wire [7:0] din;
assign din = uart_din;
wire din_vld;



//parameter define
parameter  CLK_FREQ = 50000000;         //����ϵͳʱ��Ƶ��
parameter  UART_BPS = 115200;   
uart_send #(                          
    .CLK_FREQ       (CLK_FREQ),         //����ϵͳʱ��Ƶ��
    .UART_BPS       (UART_BPS))         //���ô��ڷ��Ͳ�����
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