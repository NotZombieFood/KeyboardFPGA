module KeyFsm (
	input clk, rst, doneKey,
	input [9:0] keyData,
	output logic doneLCD, upper
);

enum 	{init, waitKey, waitKeyMayus, waitKeyShiftUpper, waitKeyShiftLower} state, next_state;

// 8'h58 is caps, 8'h12  y 8'h59 es shift  8'h5A es enter y 8'h66 es backspace


//Transición de estado
always_ff @ (posedge clk) begin
	if (rst)
		state <= init;
	else 
		state <= next_state;
end


//Siguiente estado
always_comb begin
	if (rst)
		next_state = init;
	else
		case(state)
			init: 
				next_state = waitKey;
			//estando en lowercase
			waitKey: if(doneKey & keyData== 8'h58) begin
				//pico a mayus
				next_state = waitKeyMayus;
			end 
			else if (doneKey & keyData== 8'h12) begin  
				next_state = waitKeyShiftUpper;
			end
			else if (doneKey & keyData== 8'h58) begin  
				next_state = waitKeyShiftUpper;
			end
			//estando en uppercase
			waitKeyMayus: if(doneKey & keyData== 8'h58) begin
				//pico a mayus
				next_state = waitKey;
			end 
			else if (doneKey & keyData== 8'h12) begin  
				//pico a shift
				next_state = waitKeyShiftLower;
			end
			else if (doneKey & keyData== 8'h58) begin 
				//pico a shift
				next_state = waitKeyShiftLower;
			end
			// shift cuando vienes de uppercase
			waitKeyShiftLower:
				next_state = waitKeyMayus;
			//shift cuando vienes de lower case
			waitKeyShiftUpper:
				next_state = waitKey;
			default: next_state = init;
		endcase
end

//Salidas
always_comb begin
		case (state)
			init: begin
				doneLCD = 0;
				upper = 0;
			end
			waitKey: begin
				doneLCD= 1;
				upper = 0;
			end
			waitKeyMayus: begin
				doneLCD= 1;
				upper = 1;
			end
			waitKeyShiftLower: begin
				doneLCD= 1;
				upper = 0;
			end
			waitKeyShiftUpper: begin
				doneLCD= 1;
				upper = 1;
			end
			default: begin
				doneLCD= 0;
				upper = 0;
			end
		endcase
end

endmodule