`timescale 1ns / 1ps
// Code your design here

//////////////////////////////////////////////////////////////////////////////////
// Company: UNC
// Engineer: Drudi - Goldman
// Create Date:    13:22:41 03/11/2019 
// Module Name:    ALU_TP1 
// Project Name: Trabajo Practico 1 - ALU
//////////////////////////////////////////////////////////////////////////////////

module TP1_ALU
  #( 
    //parametros
    parameter	N_BUS 	= 8,
    parameter	N_OP 	= 6
   )
  (
    //	ENTRADAS:
    input   signed  [N_BUS-1:0]	i_A,
    input   signed  [N_BUS-1:0]	i_B,
    input           [N_OP-1:0]	i_OP,

    //	SALIDAS: 
    output  signed	[N_BUS-1:0] o_RES
  );
    //Parametros de operacion
    localparam	OP_ADD 	= 6'b100000;	//SUMA
    localparam	OP_SUB 	= 6'b100010;	//RESTA
    localparam	OP_AND 	= 6'b100100;    //AND
    localparam	OP_OR	= 6'b100101;	//OR
    localparam	OP_XOR	= 6'b100110;	//XOR
    localparam	OP_SRA	= 6'b000011;	//SHIFT R (DER) ARITMETICO >>>
    localparam	OP_SRL	= 6'b000010;	//SHIFT R (DER) LOGICO >>
    localparam	OP_NOR	= 6'b100111;	//NOR

  reg   signed	[N_BUS-1:0]	RegR;

  
    always @(*)
        begin
            case (i_OP)
                OP_ADD 	:	RegR		<= 		i_A + i_B; 
                OP_SUB 	: 	RegR 		<= 		i_A - i_B; 
                OP_AND 	: 	RegR 		<= 		i_A & i_B;
                OP_OR 	: 	RegR 		<= 		i_A | i_B;
                OP_XOR	: 	RegR 		<= 		i_A ^ i_B;
                OP_SRA	: 	RegR		<= 		i_A >>> i_B;
                OP_SRL	: 	RegR 		<= 		i_A >> i_B;
                OP_NOR	: 	RegR	 	<=		~(i_A | i_B);
                default	:	RegR 		<=		6'b000000;
            endcase
        end

  assign o_RES = RegR;

endmodule
