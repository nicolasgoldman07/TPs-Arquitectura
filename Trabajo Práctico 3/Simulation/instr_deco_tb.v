`timescale 1ns / 1ps

module instr_deco_tb();

    reg     [4:0]	i_OPcode;
    wire    [1:0]   o_selA;
    wire            o_selB, o_WrAcc, o_OP, o_WrPC, o_WrRam, o_RdRam;
    
    instr_deco instr_deco_tb1(.i_OPcode(i_OPcode), .o_selA(o_selA), .o_selB(o_selB),
        .o_WrAcc(o_WrAcc), .o_OP(o_OP), .o_WrPC(o_WrPC), .o_WrRam(o_WrRam), .o_RdRam(o_RdRam));
  
    initial
        begin
        //$dumpfile("out.vcd");
        //$dumpvars(1,arit_unit_tb);
        
        //HALT
        #25 i_OPcode = 5'b00000;
                
        //STORE
        #25 i_OPcode = 5'b00001;

        //LOAD
        #25 i_OPcode = 5'b00010;

        //LOADI
        #25 i_OPcode = 5'b00011;

        //ADD
        #25 i_OPcode = 5'b00100;

        //ADDI
        #25 i_OPcode = 5'b00101;

        //SUB
        #25 i_OPcode = 5'b00110;

        //SUBI
        #25 i_OPcode = 5'b00111;

        end

    initial
        #300 $finish; //Duracion de la Simulacion
endmodule
