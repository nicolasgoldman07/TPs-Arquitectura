`timescale 1ns / 1ps

module mult_B
#(
    parameter	N_BUS 	= 16
)
(
      //	ENTRADAS:
    input                       i_selB,
    input   signed  [N_BUS-1:0] i_DATA, i_SIGNAL,

  //	SALIDAS: 
    output  signed  [N_BUS-1:0] o_MUL_B
);

    reg     signed  [N_BUS-1:0] RegSelected;

    always @(*)
        begin
            if (i_selB) begin
                RegSelected = i_SIGNAL;
            end else begin
                RegSelected = i_DATA;
            end
        end

    assign o_MUL_B = RegSelected;   

endmodule
