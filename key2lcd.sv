module key2lcd
	(
		input  letter_case,
		input  [7:0] scan_code,
		output logic [8:0] lcd_code
	);
	
always_comb begin
	if(letter_case == 1'b1)  // uppercase 
		begin
		case(scan_code)
			8'h45: lcd_code = 9'h129;   // )
			8'h16: lcd_code = 9'h121;   // !
			8'h1e: lcd_code = 9'h140;   // @
			8'h26: lcd_code = 9'h123;   // #
			8'h25: lcd_code = 9'h124;   // $
			8'h2e: lcd_code = 9'h125;   // %
			8'h36: lcd_code = 9'h15E;   // ^
			8'h3d: lcd_code = 9'h126;   // &
			8'h3e: lcd_code = 9'h12A;   // *
			8'h46: lcd_code = 9'h128;   // (
			8'h1c: lcd_code = 9'h141;   // A
			8'h32: lcd_code = 9'h142;   // B
			8'h21: lcd_code = 9'h143;   // C
			8'h23: lcd_code = 9'h144;   // D
			8'h24: lcd_code = 9'h145;   // E
			8'h2b: lcd_code = 9'h146;   // F
			8'h34: lcd_code = 9'h147;   // G
			8'h33: lcd_code = 9'h148;   // H
			8'h43: lcd_code = 9'h149;   // I
			8'h3b: lcd_code = 9'h14A;   // J
			8'h42: lcd_code = 9'h14B;   // K
			8'h4b: lcd_code = 9'h14C;   // L
			8'h3a: lcd_code = 9'h14D;   // M
			8'h31: lcd_code = 9'h14E;   // N
			8'h44: lcd_code = 9'h14F;   // O
			8'h4d: lcd_code = 9'h150;   // P
			8'h15: lcd_code = 9'h151;   // Q
			8'h2d: lcd_code = 9'h152;   // R
			8'h1b: lcd_code = 9'h153;   // S
			8'h2c: lcd_code = 9'h154;   // T
			8'h3c: lcd_code = 9'h155;   // U
			8'h2a: lcd_code = 9'h156;   // V
			8'h1d: lcd_code = 9'h157;   // W
			8'h22: lcd_code = 9'h158;   // X
			8'h35: lcd_code = 9'h159;   // Y
			8'h1a: lcd_code = 9'h15A;   // Z
			8'h0e: lcd_code = 9'h17E;   // ~
			8'h4e: lcd_code = 9'h15F;   // _
			8'h55: lcd_code = 9'h12B;   // +
			8'h54: lcd_code = 9'h17B;   // {
			8'h5b: lcd_code = 9'h17D;   // }
			8'h5d: lcd_code = 9'h17C;   // |
			8'h4c: lcd_code = 9'h13A;   // :
			8'h52: lcd_code = 9'h122;   // "
			8'h41: lcd_code = 9'h13C;   // <
			8'h49: lcd_code = 9'h13E;   // >
			8'h4a: lcd_code = 9'h13F;   // ?
			8'h29: lcd_code = 9'h120;   // space
			8'h5a: lcd_code = 9'h0C0;   // enter (jumpline)
			8'h66: lcd_code = 9'h108;   // backspace
			8'h0D: lcd_code = 9'h109;   // horizontal tab	
			
			default: lcd_code = 9'h12A; // *
		endcase
		end
	else   // lowercase
		begin
		case(scan_code)
			8'h45: lcd_code = 9'h130;   // 0
			8'h16: lcd_code = 9'h131;   // 1
			8'h1e: lcd_code = 9'h132;   // 2
			8'h26: lcd_code = 9'h133;   // 3
			8'h25: lcd_code = 9'h134;   // 4
			8'h2e: lcd_code = 9'h135;   // 5
			8'h36: lcd_code = 9'h136;   // 6
			8'h3d: lcd_code = 9'h137;   // 7
			8'h3e: lcd_code = 9'h138;   // 8
			8'h46: lcd_code = 9'h139;   // 9
			8'h1c: lcd_code = 9'h161;   // a
			8'h32: lcd_code = 9'h162;   // b
			8'h21: lcd_code = 9'h163;   // c
			8'h23: lcd_code = 9'h164;   // d
			8'h24: lcd_code = 9'h165;   // e
			8'h2b: lcd_code = 9'h166;   // f
			8'h34: lcd_code = 9'h167;   // g
			8'h33: lcd_code = 9'h168;   // h
			8'h43: lcd_code = 9'h169;   // i
			8'h3b: lcd_code = 9'h16A;   // j
			8'h42: lcd_code = 9'h16B;   // k
			8'h4b: lcd_code = 9'h16C;   // l
			8'h3a: lcd_code = 9'h16D;   // m
			8'h31: lcd_code = 9'h16E;   // n
			8'h44: lcd_code = 9'h16F;   // o
			8'h4d: lcd_code = 9'h170;   // p
			8'h15: lcd_code = 9'h171;   // q
			8'h2d: lcd_code = 9'h172;   // r
			8'h1b: lcd_code = 9'h173;   // s
			8'h2c: lcd_code = 9'h174;   // t
			8'h3c: lcd_code = 9'h175;   // u
			8'h2a: lcd_code = 9'h176;   // v
			8'h1d: lcd_code = 9'h177;   // w
			8'h22: lcd_code = 9'h178;   // x
			8'h35: lcd_code = 9'h179;   // y
			8'h1a: lcd_code = 9'h17A;   // z
			8'h0e: lcd_code = 9'h160;   // `
			8'h4e: lcd_code = 9'h12D;   // -
			8'h55: lcd_code = 9'h13D;   // =
			8'h54: lcd_code = 9'h15B;   // [
			8'h5b: lcd_code = 9'h15D;   // ]
			8'h5d: lcd_code = 9'h15C;   // \
			8'h4c: lcd_code = 9'h13B;   // ;
			8'h52: lcd_code = 9'h127;   // '
			8'h41: lcd_code = 9'h12C;   // ,
			8'h49: lcd_code = 9'h12E;   // .
			8'h4a: lcd_code = 9'h12F;   // /
			8'h29: lcd_code = 9'h120;   // space
			8'h5a: lcd_code = 9'h0C0;  // enter
			8'h66: lcd_code = 9'h108;   // backspace
			8'h0D: lcd_code = 9'h109;   // horizontal tab	
			
			default: lcd_code = 9'h120; // *
		endcase
		end
	end
endmodule
