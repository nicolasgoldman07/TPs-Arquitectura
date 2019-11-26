`timescale 1ns / 1ps

module uart_test
(
    input   wire            clk, reset,
    input   wire            rx_done_tick, 
    input   wire    [7:0]   rx_data,
    output  wire            tx_start,
    output  wire    [7:0]   tx_data
);
  
    reg             [7:0]   reg_rx;
    reg                     reg_tx_start;

    always@ (posedge clk)
      begin
        if(rx_done_tick)
          begin
            reg_tx_start  <= 1'b1;
            reg_rx    <= rx_data;
          end
        else
          reg_tx_start    <=  1'b0;
      end

    assign  tx_data   = reg_rx;
    assign  tx_start  = reg_tx_start;


endmodule
