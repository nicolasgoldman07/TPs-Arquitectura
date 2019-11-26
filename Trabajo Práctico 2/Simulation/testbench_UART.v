// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module testbench_UART();

    reg         i_clk, i_rst;
    reg [7:0]   rx_data;
    reg         rx_done_tick;
    wire        tx_start;
    wire [7:0]  tx_data;

    
  uart_to_alu_to_uart a(i_clk, i_rst, rx_done_tick,rx_data, tx_start,tx_data);

  always 
        begin
            #1  i_clk = ~i_clk;
        end
  
    initial 
      begin
      
    //$dumpfile("out.vcd");
    //$dumpvars(1,testbench_UART);
    end
      

    initial
        begin
            #0  i_clk           = 1'b1;
                i_rst           = 1'b1;
          		rx_done_tick	= 1'b0;

            #1  i_rst           = 1'b0;
            
            //ENVIO PRIMEROS 3 DATOS
            #15 rx_data         = 8'b00000010;
            //#16 
                rx_done_tick    = 1'b1;

            #1 rx_done_tick    = 1'b0;

            #15 rx_data         = 8'b00000001;
                rx_done_tick    = 1'b1;
            
            #1 rx_done_tick    = 1'b0;

            #15 rx_data         = 6'b100000;
                rx_done_tick    = 1'b1;
            
            #1 rx_done_tick    = 1'b0;
            
            //ENVIO SEGUNDOS 3 DATOS
            #15 rx_data         = 8'b00000111;
            //#16 
                rx_done_tick    = 1'b1;

            #1 rx_done_tick    = 1'b0;

            #15 rx_data         = 8'b00000101;
                rx_done_tick    = 1'b1;
            
            #1 rx_done_tick    = 1'b0;

            #15 rx_data         = 6'b100100;
                rx_done_tick    = 1'b1;
            
            #1 rx_done_tick    = 1'b0;

            #250 $finish; //Duraci?n de la Simulaci?n


        end

endmodule