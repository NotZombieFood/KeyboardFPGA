module top(
	input clk,
	input rst,
	output [7:0] DATA,
	output RW, EN, RS, ON
);

logic [8:0] data_1;
logic [8:0] data_2;
logic [5:0] rd_address;
logic [5:0] rd_address_1;
logic [5:0] rd_address_2;

assign rd_address_1 = (rd_address - 6);
assign rd_address_2 = (rd_address - 23);

LCD lm(
	.clk(clk),
	.rst(rst),
	.data_mem_1(data_1),
	.data_mem_2(data_2),
	.DATA(DATA),
	.address(rd_address),
	.RW(RW),
	.EN(EN),
	.RS(RS),
	.ON(ON)
);

memory mem1(
	.clk(~clk),
	.rst(~rst),
	.wr_addr(),
	.wr_en(),
	.wr_data(),
	.rd_addr(rd_address_1),
	.rd_data(data_1)
);

memory mem2(
	.clk(~clk),
	.rst(~rst),
	.wr_addr(),
	.wr_en(),
	.wr_data(),
	.rd_addr(rd_address_2),
	.rd_data(data_2)
);



endmodule 