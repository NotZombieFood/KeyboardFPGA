module keyboard
	(
		input clk, reset, 
		input  ps2d, ps2c,   	// ps2 data and clock inputs, receive enable input
		output logic done,       	 	// Flag de done
		output logic [9:0] data      	// Los datos recibidos 
	);
	
	
	// FSMD state declaration and registers
	enum 	{idle, read} state, next_state;

	// Cables internos
	logic [3:0] count;
	logic ps2cLow;
	//cambio de estado
	always_ff @(posedge clk) begin
		if(~reset) begin
			state <= idle;
		end else begin
			state <=  next_state;
		end
	end 
	posEdgeGenerator inst_posEdgeGenerator (.sig_a(~ps2c), .rst(reset), .clk(clk), .sig_a_risedge(ps2cLow));

	always @* begin
		case (state)
			idle:
				if (ps2cLow) begin    // momento de comenzar
					count <= 10;             // contaremos desde 10 bits hacía abajo}
					next_state <= read;     // go to read state
				end else begin
					next_state <= idle;
				end
				
			read:                                           // shift in 8 data, 1 parity, and 1 stop bit
				begin
				if (ps2cLow) begin       // if ps2c negative edge...
				
					data[9] <= ps2d; // sample ps2d
					count <= count - 1;   // decrement bit count
					data <= data<<1;
					done <= 1'b0;
					next_state <= read;

				end
			
				if (count==0) begin //cuenta 10 bits hasta que que pasa al siguiente estado
					 done <= 1'b1;         // assert dat received done tick
					 next_state <= idle;           // go back to idle
					 end
				end				
			default : /* default */;
		endcase
	end

endmodule // ps2_rx