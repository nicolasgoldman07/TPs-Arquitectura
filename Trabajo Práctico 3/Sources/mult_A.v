`timescale 1ns / 1ps

module mult_A
#(
    parameter	N_BUS 	= 16,
    parameter	TAM 	= 2
)
(
      //	ENTRADAS:
    input           [TAM-1:0]   i_selA,
    input   signed  [N_BUS-1:0] i_DATA, i_SIGNAL, i_RES_ARIT,

  //	SALIDAS: 
    output  signed  [N_BUS-1:0] o_MUL_A
);

    reg     signed  [N_BUS-1:0] RegSelected;

    always @(*)
        begin
            case (i_selA)
                2'b00   :   RegSelected = i_DATA; 
                2'b01   :   RegSelected = i_SIGNAL; 
                2'b10   :   RegSelected = i_RES_ARIT; 
            endcase
        end

    assign o_MUL_A = RegSelected;   

endmodule
