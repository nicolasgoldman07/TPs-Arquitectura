`timescale 1ns/1ps

module mult_A_tb();

    reg     [1:0]   i_selA;
    reg     [15:0]  i_DATA, i_SIGNAL, i_RES_ARIT;
    wire    [15:0]  o_MUL_A;

    mult_A mult_A_tb(.i_selA(i_selA), .i_DATA(.i_DATA),
        .i_SIGNAL(i_SIGNAL), .i_RES_ARIT(i_RES_ARIT), 
        .o_MUL_A(o_MUL_A));

    initial
        begin
        $dumpfile("out.vcd");
        $dumpvars(1,mult_A_tb);

        #25 i_selA = 2'b00; i_DATA = 16'b1111100000000000;
                            i_SIGNAL = 16'b0000000000011111;
                            i_RES_ARIT = 16'b0000000000000000;

        #25 i_selA = 2'b01; i_DATA = 16'b1111100000000000;
                            i_SIGNAL = 16'b0000000000011111;
                            i_RES_ARIT = 16'b0000000000000000;

        #25 i_selA = 2'b10; i_DATA = 16'b1111100000000000; 
                            i_SIGNAL = 16'b0000000000011111;
                            i_RES_ARIT = 16'b0000000000000000;
        end

    initial
        #100 $finish;
endmodule
