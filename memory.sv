module memory 
#(
  parameter NUM_REGS = 16, 
  parameter SIZE = 32
)(
  input clk,
  input rst,
  input  [5:0]  wr_addr,
  input         wr_en,
  input  [31:0] wr_data,
  input  [5:0]  rd_addr,
  output [31:0] rd_data

);
  
    logic [SIZE-1:0] rf [NUM_REGS-1:0];
  
    integer i;
	 always_ff @ (posedge clk) begin
      if (rst)
			for (i = 0; i < NUM_REGS-1; i = i + 1)
				rf[i] <= 9'h120;
		//else  if (wr_en)
        //rf[wr_addr] <= wr_data;
		else begin
			rf[0] = 9'h120;
			rf[1] = 9'h120;
			rf[2] = 9'h148;
			rf[3] = 9'h161;
			rf[4] = 9'h162;
			rf[5] = 9'h16F;
			rf[6] = 9'h120;
			rf[7] = 9'h165;
			rf[8] = 9'h173;
			rf[9] = 9'h165;
			rf[10] = 9'h16c;
		end
		
		  
	end
	
    assign rd_data = rf[rd_addr];

endmodule 