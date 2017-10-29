module top(
	input clk,
	input rst, ps2c, ps2c,
	output [7:0] DATA,
	output RW, EN, RS, ON
);

logic [8:0] data_1;
logic [8:0] data_2;
logic [5:0] rd_address;
logic [5:0] rd_address_1;
logic [5:0] rd_address_2;
logic doneKey;
logic keyData;
logic lcd_code;
logic letter_case;

assign rd_address_1 = (rd_address - 6);
assign rd_address_2 = (rd_address - 23);

keyboard inst_keyboard (.clk(clk), .reset(reset), .ps2d(ps2d), .ps2c(ps2c), .done(done), .data(keyData));
key2lcd inst_key2lcd (.letter_case(letter_case), .scan_code(keyData), .lcd_code(lcd_code));



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
	.wr_data(lcd_code),
	.rd_addr(rd_address_1),
	.rd_data(data_1)
);

memory mem2(
	.clk(~clk),
	.rst(~rst),
	.wr_addr(),
	.wr_en(),
	.wr_data(lcd_code),
	.rd_addr(rd_address_2),
	.rd_data(data_2)
);



endmodule 