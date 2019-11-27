`timescale 1ns / 1ps

module arit_unit
#( 
  //parametros
  parameter	N_BUS 	= 16,
  parameter	N_OP 	  = 5
)
(
  //	ENTRADAS:
  input     signed  [N_BUS-1:0] i_ACC,
  input     signed  [N_BUS-1:0]	i_DATA,
  input             [N_OP-1:0]  i_OP,

  //	SALIDAS: 
  output    signed	[N_BUS-1:0] o_RES
);

//Parametros de operacion
  localparam	OP_ADD 	    = 5'b00100;	//SUMA 
  localparam	OP_ADDI 	  = 5'b00101;	//SUMA INMEDIATA
  localparam	OP_SUB 	    = 5'b00110;	//RESTA
  localparam	OP_SUBI 	  = 5'b00111;	//RESTA INMEDIATA
    
  reg   signed	[N_BUS-1:0] RegR;

  always @(*)
      begin
          case (i_OP)
              OP_ADD 	:   RegR		<= 		i_ACC + i_DATA; 
              OP_ADDI :   RegR		<= 		i_ACC + i_DATA; 
              OP_SUB 	: 	RegR 		<= 		i_ACC - i_DATA; 
              OP_SUBI : 	RegR 		<= 		i_ACC - i_DATA;
              default	:   RegR 		<=		5'b00000;
          endcase
      end

assign o_RES = RegR;

endmodule
