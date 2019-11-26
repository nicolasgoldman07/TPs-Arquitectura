`timescale 1ns / 1ps

module uart_to_alu_to_uart
(
    input   wire            clk, reset,
    input   wire            rx_done_tick, 
    input   wire    [7:0]   rx_data,
    output  wire            tx_start,
    output  wire    [7:0]   tx_data

);
    
    localparam      [1:0]   first_state      =   2'b00;
    localparam      [1:0]   second_state     =   2'b01;
    localparam      [1:0]   op_state         =   2'b10;
    localparam      [1:0]   calc_state       =   2'b11;
   
    reg             [1:0]   state_reg, state_next;
    reg             [7:0]   reg_a, reg_b, reg_tx_data;
    reg             [5:0]   reg_op;
    reg                     reg_tx_start;

    wire            [7:0]   a_data, b_data, calc_data; 
    wire            [5:0]   op_data;

    // Maquina de estados
    always @ (posedge clk, posedge reset)
        begin
          if (reset)
                begin
                    state_reg <= first_state;
                    state_next <= first_state;
                end
            else
                begin
                    state_reg <= state_next;
                end
        end
    
    always @ (posedge clk)
        begin
            if(rx_done_tick)
                begin
                    case(state_reg)
                        first_state : 
                            begin  
                                reg_a = rx_data;
                            end
                        second_state : 
                            begin
                                reg_b = rx_data;
                            end
                        op_state :
                            begin
                                reg_op = rx_data;
                            end
                        calc_state :
                            begin
                                reg_tx_data = calc_data;
                            end
                    endcase
                end
        end
    

    // Logica de cambio de estados
    always @ (*)
        begin
            state_next = state_reg;
            reg_tx_start = 1'b0;
            if(rx_done_tick)
                begin
                    case(state_reg)
                        first_state : 
                            begin
                                state_next = second_state;
                            end
                        second_state : 
                            begin
                                state_next = op_state;
                            end
                        op_state :
                            begin
                                state_next = calc_state;
                            end
                        calc_state :
                            begin
                                state_next = first_state;
                                reg_tx_start = 1'b1;
                            end
                    endcase
                end
        end


    assign  a_data      = reg_a;
    assign  b_data      = reg_b;
    assign  op_data     = reg_op;
    assign  tx_start    = reg_tx_start;
    assign  tx_data     = reg_tx_data;

    TP1_ALU alu_uart (.i_A(a_data), .i_B(b_data), .i_OP(op_data),
                        .o_RES(calc_data));

endmodule
