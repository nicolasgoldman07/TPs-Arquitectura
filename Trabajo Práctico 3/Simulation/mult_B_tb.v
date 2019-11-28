`timescale 1ns/1ps

module mult_B_tb();

    reg             i_selB;
    reg     [15:0]  i_DATA, i_SIGNAL;
    wire    [15:0]  o_MUL_B;  

    mult_B mult_B_tb(.i_selB(i_selB), .i_DATA(i_DATA),
        .i_SIGNAL(i_SIGNAL), .o_MUL_B(o_MUL_B));

    initial
        begin
        //$dumpfile("out.vcd");
        //$dumpvars(1,mult_B_tb);

        #25 i_selB = 1'b0; i_DATA = 16'b1111100000000000; i_SIGNAL = 16'b0000000000011111; 
        #25 i_selB = 1'b1; i_DATA = 16'b1111100000000000; i_SIGNAL = 16'b0000000000011111;
        end

    initial
        #100 $finish;
endmodule