`timescale 1ns/1ps
module tb_ctr ();
reg            clk      ; 
reg            rst_n    ; 
reg  [7:0]     data     ; 
reg            rdreq    ; 
reg            wrreq    ; 
wire           empty    ; 
wire           full     ; 
wire [255:0]     q        ; 
wire      usedw    ; 
wire  almost_full;
wire   [10:0] wr_water_level;


control_fifo1 control(
    .clk            (clk    )  ,
    .rst_n          (rst_n  )  ,
    .dout           (data   )  ,
    .din              (q      )  ,
    .ready          (rdreq  )  ,
    .wrreq          (wrreq  )  ,
    .empty          (empty  )  ,
    .full           (full   )  ,
    .almost_empty         (usedw  ),
    .almost_full         (almost_full),
    .wr_water_level     (wr_water_level)
);

parameter CYCLE = 20;
always #(CYCLE/2) clk=~clk;
integer i=0,j=0;

initial begin
    clk=1;
    rst_n=1;
    data=0;
    #200.1;
    rst_n=0;   //复位
    rdreq=0;
    wrreq=0;
    #(CYCLE*10);
    rst_n=1;
    #(CYCLE*10)
   //wrreq  50M
    for(i=0;i<256;i=i+1)begin     //因为我们的数据深度设置的是256，所以这里写进去256个数据
        wrreq = 1'b1;//写使能
        data = {$random}%101;
        #CYCLE;
    end
    wrreq = 1'b0;//写完拉低
    #(CYCLE*5);

    //rdreq  50M
    for(j=0;j<256;j=j+1)begin
        rdreq = 1'b1;//读使能
        #CYCLE;
    end
    rdreq = 1'b0;
    #(CYCLE*10);
    

    $stop;
end


endmodule