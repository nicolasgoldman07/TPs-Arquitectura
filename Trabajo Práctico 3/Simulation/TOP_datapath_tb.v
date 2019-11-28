`timescale 1ns/1ps

module TOP_datapath_tb();
    
    reg                 i_clk;
    reg     [11-1:0]    i_signal;
    reg     [16-1:0]    i_Out_Data;
    reg     [2-1:0]     i_selA;
    reg                 i_selB, i_WrAcc, i_OP;

    wire    [11-1:0]    o_Addr;
    wire    [16-1:0]    o_In_Data;

    TOP_datapath TOP_datapath_tb(i_clk, i_signal, i_Out_Data,
        i_selA, i_selB, i_WrAcc, i_OP, o_Addr, o_In_Data);

    initial
        begin
        //$dumpfile("out.vcd");
        //$dumpvars(1,TOP_datapath_tb);

        #0 //RESETEO LOS VALORES
        i_clk = 1'b1;
        i_signal = 11'b00000000000;
        i_Out_Data = 16'b0000000000000000;
        i_selA = 2'b00;
        i_selB = 1'b0;
        i_WrAcc = 1'b0;
        i_OP = 1'b0;


        // SUMA INMEDIATA 7 + 10
        #20 //LOAD INMEDIATO
        i_signal = 11'b00000000111;
        i_selA = 2'b01;
        i_WrAcc = 1'b1;

        #3 //TERMINO DE ESCRIBIR EL ACUMULADOR
        i_WrAcc = 1'b0;
        
        #25 //HAGO SUMA CON UN DATO CARGADO DE MEM  ORIA
        i_Out_Data = 16'b0000000000001010;
        i_OP = 1'b0;
        i_selB = 1'b0;

        #30 // GUARDO EL VALOR EN EL ACUMULADOR
            // DEBERIA VERSE EN o_Addr
        i_selA = 2'b10;
        i_WrAcc = 1'b1;

        #3
        i_WrAcc = 1'b0;


    end

    always 
    begin
        #1
        i_clk = ~i_clk;
    end

endmodule
