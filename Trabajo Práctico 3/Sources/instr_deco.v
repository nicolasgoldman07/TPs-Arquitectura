`timescale 1ns / 1ps

module instr_deco
#( 
  //parametros
  parameter     N_OP    = 5,
  parameter     TAM     = 2
)
(
  //	ENTRADAS:
  input       [N_OP-1:0]    i_OPcode,

  //	SALIDAS: 
  output   	  [TAM-1:0]     o_selA,
  output                    o_selB,
  output                    o_WrAcc,
  output                    o_OP,
  output                    o_WrPC, 
  output                    o_WrRam,
  output                    o_RdRam
);

  localparam [N_OP-1:0] HALT  = 5'b00000,
                        STORE = 5'b00001,
                        LOAD  = 5'b00010,
                        LOADI = 5'b00011,
                        ADD   = 5'b00100,
                        ADDI  = 5'b00101,
                        SUB   = 5'b00110,
                        SUBI  = 5'b00111;

  reg   	  [TAM-1:0] reg_selA;
  reg                   reg_selB, reg_WrAcc, reg_OP, reg_WrPC, reg_WrRam, reg_RdRam;  
  always@(*)
  begin
    case(i_OPcode)
      
      HALT:
      begin
				reg_selA <= 2'b00;
				reg_selB <= 1'b0;
				reg_WrAcc <= 1'b0;
				reg_OP <= 1'b0;
                reg_WrPC <= 1'b0;
				reg_WrRam <= 1'b0;
				reg_RdRam <= 1'b0;
      end

      STORE:
      begin
				reg_selA <= 2'b00;
				reg_selB <= 1'b0;
				reg_WrAcc <= 1'b0;
				reg_OP <= 1'b0;
                reg_WrPC <= 1'b1;   //<--
				reg_WrRam <= 1'b1;  //<--
				reg_RdRam <= 1'b0;
      end

      LOAD:
      begin
				reg_selA <= 2'b00;  //<--
				reg_selB <= 1'b0;
				reg_WrAcc <= 1'b1;  //<--
				reg_OP <= 1'b0;
                reg_WrPC <= 1'b1;   //<--
				reg_WrRam <= 1'b0;
				reg_RdRam <= 1'b1;  //<--
      end

      LOADI:
      begin
				reg_selA <= 2'b01;  //<--
				reg_selB <= 1'b0;
				reg_WrAcc <= 1'b1;  //<--
				reg_OP <= 1'b0;
                reg_WrPC <= 1'b1;   //<--
				reg_WrRam <= 1'b0; 
				reg_RdRam <= 1'b0;
      end

      ADD:
      begin
				reg_selA <= 2'b10;  //<--
				reg_selB <= 1'b0;   //<--
				reg_WrAcc <= 1'b1;  //<--
				reg_OP <= 1'b0;     //<--
                reg_WrPC <= 1'b1;   //<--
				reg_WrRam <= 1'b0;
				reg_RdRam <= 1'b1;  //<--
      end

      ADDI:
      begin
				reg_selA <= 2'b10;  //<--
				reg_selB <= 1'b1;   //<--
				reg_WrAcc <= 1'b1;  //<--
				reg_OP <= 1'b0;     //<--
                reg_WrPC <= 1'b1;   //<--
				reg_WrRam <= 1'b0;
				reg_RdRam <= 1'b0;
      end

      SUB:
      begin
				reg_selA <= 2'b10;  //<--
				reg_selB <= 1'b0;   //<--
				reg_WrAcc <= 1'b1;  //<--
				reg_OP <= 1'b1;     //<--
                reg_WrPC <= 1'b1;   //<--
				reg_WrRam <= 1'b0; 
				reg_RdRam <= 1'b1;  //<--
      end

      SUBI:
      begin
				reg_selA <= 2'b10;  //<--
				reg_selB <= 1'b1;   //<--
				reg_WrAcc <= 1'b1;  //<--
				reg_OP <= 1'b1;     //<--
                reg_WrPC <= 1'b1;   //<--
				reg_WrRam <= 1'b0;
				reg_RdRam <= 1'b0;
      end
    endcase
  end
  
  assign    o_selA  =   reg_selA;
  assign    o_selB  =   reg_selB;
  assign    o_WrAcc =   reg_WrAcc;
  assign    o_OP    =   reg_OP;
  assign    o_WrPC  =   reg_WrPC;
  assign    o_WrRam =   reg_WrRam;
  assign    o_RdRam =   reg_RdRam;

endmodule
