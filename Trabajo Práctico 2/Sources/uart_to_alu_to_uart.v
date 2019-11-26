`timescale 1ns / 1ps

module uart_to_alu_to_uart
(
    input   wire            clk, reset,
    input   wire            rx_done_tick, 
    input   wire    [7:0]   rx_data,
    output  wire            tx_start,
    output  wire    [7:0]   tx_data

);
    
    localparam      [1:0]   first_state      =   2'b00,
                            second_state     =   2'b01,
                            op_state         =   2'b10,
                            calc_state       =   2'b11;
   
    reg             [1:0]   state_reg, state_next;
    reg             [7:0]   reg_a, reg_a_tmp, reg_b, reg_b_tmp, reg_tx_data, reg_tx_data_tmp;
    reg             [7:0]   reg_op, reg_op_tmp;
    reg                     reg_tx_start;
    reg                     reg_tx_start_t;

    wire            [7:0]   a_data, b_data, calc_data; 
    wire            [5:0]   op_data;

    // Maquina de estados
    always @ (posedge clk)
        begin
          if (reset)
                begin
                    reg_a <= 8'b00000000;
                    reg_b <= 8'b00000000;
                    reg_op <= 8'b00000000;
                    state_reg <= first_state;
                    //state_next <= first_state;
                end
            else
                begin
                    case(state_reg)
                        first_state : 
                                reg_a <= reg_a_tmp;                       
                        second_state :              
                                reg_b <= reg_b_tmp;           
                        op_state :
                                reg_op <= reg_op_tmp;
                        calc_state :
                                reg_tx_data <= reg_tx_data_tmp;
                    endcase
                    state_reg <= state_next;
                    reg_tx_start <= reg_tx_start_t;
                end
        end
    
    
    /*always @ (posedge clk)
            begin
                case(state_reg)
                    first_state : 
                        if(rx_done_tick)
                            begin  
                                reg_a <= reg_a_tmp;
                            end
                    second_state : 
                        if(rx_done_tick)
                            begin
                                reg_b <= reg_b_tmp;
                            end
                    op_state :
                        if(rx_done_tick)
                            begin
                                reg_op <= reg_op_tmp;
                            end
                    calc_state :
                        begin
                            reg_tx_data <= reg_tx_data_tmp;
                        end
                endcase
            end
    
    */

    // Logica de cambio de estados
    always @ (*)
        begin
            state_next = state_reg;
            case(state_reg)
                first_state : 
                    begin
                        reg_tx_start_t = 1'b0;
                        if(rx_done_tick)
                            begin
                                reg_a_tmp = rx_data;
                                state_next = second_state;
                            end
                        else
                            begin
                                state_next = first_state;
                            end
                    end
                second_state : 
                    begin
                        reg_tx_start_t = 1'b0;
                        if(rx_done_tick)
                            begin
                                reg_b_tmp = rx_data;
                                state_next = op_state;
                            end
                        else
                            begin
                                state_next = second_state;
                            end 
                    end
                op_state :
                    begin
                        reg_tx_start_t = 1'b0;
                        if(rx_done_tick)
                            begin
                                state_next = calc_state;
                                reg_op_tmp = rx_data;
                            end
                        else
                            begin
                                state_next = op_state;
                            end
                    end
                calc_state :
                        begin
                            reg_tx_data_tmp = calc_data;
                            state_next = first_state;
                            reg_tx_start_t = 1'b1;
                        end
            endcase
        end


    assign  a_data      = reg_a;
    assign  b_data      = reg_b;
    assign  op_data     = reg_op;
    assign  tx_start    = reg_tx_start;
    assign  tx_data     = reg_tx_data;
    //assign  tx_data     = reg_a + reg_b;


     TP1_ALU alu_uart (.i_A(a_data), .i_B(b_data), .i_OP(op_data),
                         .o_RES(calc_data));

endmodule


