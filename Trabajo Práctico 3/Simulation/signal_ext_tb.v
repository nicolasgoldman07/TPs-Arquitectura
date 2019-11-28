`timescale 1ns/1ps

module signal_ext_tb();

    reg     [10:0]  i_signal;
    wire    [15:0]  o_signal;

    signal_ext signal_ext_tb(.i_signal(i_signal), 
        .o_signal(o_signal));

    initial
        begin
        //$dumpfile("out.vcd");
        //$dumpvars(1,signal_ext_tb);

        #25 i_signal = 10'b1111100000;
        #25 i_signal = 10'b1111111111;
        #25 i_signal = 10'b0001110010;
        end

    initial
        #100 $finish;
endmodule