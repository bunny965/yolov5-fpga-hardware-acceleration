module rx_top (
    input   	        sys_clk        ,
    input            sys_rst_n,                //ϵͳ��λ���͵�ƽ��Ч
    input            uart_rxd,
    input               ready      , //control_er_ready
    output  [255:0]       din        ,
    output	            din_vld  , //��û��ʹ��һֱд����������~done
    output	  [10:0] wr_water_level,
    output      almost_full        
);
wire [7:0] data;
wire [255:0] uart_data;
wire dout_vld   ;


//parameter define
parameter  CLK_FREQ = 50000000;         //����ϵͳʱ��Ƶ��
parameter  UART_BPS = 115200;           //���崮�ڲ�����
uart_recv #(                          
    .CLK_FREQ       (CLK_FREQ),         //����ϵͳʱ��Ƶ��
    .UART_BPS       (UART_BPS))         //���ô��ڽ��ղ�����
u_uart_recv(       
    .sys_clk(sys_clk ),                  //ϵͳʱ��
    .sys_rst_n      (sys_rst_n),
    .uart_rxd(uart_rxd),
     .uart_done      (uart_done),
    .uart_data       (uart_data)
);


assign dout_vld =~uart_done;
assign data = uart_data;
control_fifo1 control_fifo1(
    .clk            ( sys_clk )  ,
    .rst_n          (sys_rst_n )  ,
    .dout           (data   )  ,
    .ready          (ready)  ,
    .dout_vld(dout_vld),
    .din           (din  )  ,
    .din_vld          (din_vld),
               .wr_water_level     (wr_water_level),
	 .almost_full         (almost_full)
);
endmodule 