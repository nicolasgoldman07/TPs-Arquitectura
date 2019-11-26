`timescale 1ns / 1ps
module uart_tb;

	// Inputs
	reg i_clk;
	reg i_reset;
	reg i_rx;

	// Outputs
	wire o_tx;
	wire [7:0] o_led;
	
	reg trans;

	// Instantiate the Unit Under Test (UUT)
	uart #(.DVSR(5)) uut (
		.clk(i_clk), 
		.reset(i_reset), 
		.rx(i_rx), 
		.tx(o_tx),
		.led(o_led)
	);

	initial begin
		// Initialize Inputs
		i_clk = 1'b1;
		i_reset = 1'b1;
		i_rx = 1'b1; //inicio
		
		#5
		i_reset = 1'b0;
		#160 //startA
		i_rx = 1'b0; 
		#160
		i_rx = 1'b1; //dataA = 00000001
		#160
		i_rx = 1'b0; 
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160 //stop
		i_rx = 1'b1; 
		
		#160 //startB
		i_rx = 1'b0; 
		#160
		i_rx = 1'b0; //dataB = 00000010
		#160
		i_rx = 1'b1; 
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160 //stop
		i_rx = 1'b1; 
		
		#160 //start OP
		i_rx = 1'b0; 
		#160
		i_rx = 1'b0; //dataOP = 00100000
		#160
		i_rx = 1'b0; 
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b1;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160 //stop
		i_rx = 1'b1; 
	end
	
	always begin
     #1
     i_clk = ~i_clk;
   end
	
	always @ (*) begin
		if(i_reset)
			trans <= 1'b0;
		else
			trans <= o_tx;
	end
      
endmodule