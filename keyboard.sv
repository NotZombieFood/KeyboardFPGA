module keyboard
	(
		input clk, reset, 
		input  ps2d, ps2c,   	// ps2 data and clock inputs, receive enable input
		output logic done,       	 	// Flag de done
		output logic [9:0] data      	// Los datos recibidos 
	);
	
	
	// FSMD state declaration and registers
	enum 	{idle, read, DLY} state, next_state;

	// Cables internos
	logic [3:0] count;
	logic ps2cLow;
	logic en_esperados;
	logic rst_espera;
	logic [31:0]espera;
	//cambio de estado
	always_ff @(posedge clk) begin
		if(reset) begin
			state <= idle;
		end else begin
			state <=  next_state;
		end
	end 
	posEdgeGenerator inst_posEdgeGenerator (.sig_a(~ps2c), .rst(~reset), .clk(clk), .sig_a_risedge(ps2cLow));

	always_ff @ (posedge ps2cLow) begin
		if (reset) begin
			count <= 15;
			next_state <= idle;
			data <= 0;
		end
		case (state)
			idle:
				if (ps2cLow) begin    // momento de comenzar
					count <= 0;             // contaremos desde 10 bits hacía abajo}
					next_state <= read;     // go to read state
					en_esperados <= 0;
					rst_espera <= 1;
				end else begin
					next_state <= idle;
					en_esperados <= 0;
					rst_espera <= 1;
				end
				
			read:                                           // shift in 8 data, 1 parity, and 1 stop bit
				begin
				en_esperados <= 0;
				rst_espera <= 1;
				if (ps2cLow) begin       // if ps2c negative edge...
				
					data[count] <= ps2d; // sample ps2d
					count <= count + 1;   // decrement bit count
					next_state <= read;

				end
			
				if (count==10) begin //cuenta 10 bits hasta que que pasa al siguiente estado
					 next_state <= DLY;           // go back to idle
					 end
				end
			DLY: begin
				count <= 0;
				data <= 0;
				en_esperados <= 1;
				rst_espera <= 0;
				if (espera > 5000000)
					next_state <= read;
				else 
					next_state <= DLY;
			end
			default : /* default */;
		endcase
	end
	
	always_ff @ (posedge clk) begin
		if (count == 10 ) 
			done = 1;
		else 
			done = 0;
	end
	
	always_ff @ (posedge clk) begin
		if (rst_espera | reset)
			espera <= 0;
		else if (en_esperados)
			espera <= espera +1;
		else 
			espera <= espera;
	end

endmodule // ps2_rx