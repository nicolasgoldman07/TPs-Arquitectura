`timescale 1ns / 1ps

module TOPLVL_TP1_ALU
    #(
    parameter	N_BUS 	= 8,
    parameter	N_OP 	= 6,
    parameter   N_BTN   = 3
    )
    (
    //ENTRADAS
    input   signed  [N_BUS-1:0]     i_switch,
    input           [N_BTN-1:0]     i_btn,
    input                           i_clk,
    
    //SALIDAS
    output  signed [N_BUS-1:0]  o_led
    );
    
    reg     signed      [N_BUS-1:0] RegA, RegB;
    reg                 [N_OP-1:0]  RegOP; 
    wire    signed      [N_BUS-1:0] LEDs;
    
    assign o_led = LEDs;
    
    always @(posedge i_clk)
        begin
            casez (i_btn)
                3'b??1  :   RegA    <=  i_switch;
                3'b?1?  :   RegB    <=  i_switch;
                3'b1??  :   RegOP   <=  i_switch; // Ver si toma los MSB o LSB
            endcase
        end
        
    TP1_ALU 
    #(
        .N_BUS  (N_BUS),
        .N_OP   (N_OP)
    )
   
    alu1 
    (
        .i_A    (RegA),
        .i_B    (RegB),
        .i_OP   (RegOP),
        .o_RES  (LEDs)
    );
    
endmodule
