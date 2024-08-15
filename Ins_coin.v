module Ins_coin(clk, rst, coin_in, state_cmp3, out_RDY3, DATA_out3);
	input clk, rst;
	input [3:0] coin_in;
	output state_cmp3, out_RDY3;
	output [7:0] DATA_out3;
	reg state_cmp3, out_RDY3;
	reg opr_fg;
	reg [2:0] state_out;
	reg [2:0] state_insc;
	reg [7:0] DATA_out3, coin;


always @(posedge clk, posedge rst) begin
	if(rst) begin
		state_cmp3 <= 0; 
		out_RDY3 <= 0;
		opr_fg <= 0;
		DATA_out3 <= 8'b0000_0000;
		coin <= 8'b0000_0000;
		state_out <= 3'b000;
		state_insc <= 3'b000;
		end
	else begin
		if(coin_in == 4'b0001) begin
			state_insc <= 3'b001;
			end
		else begin
			if(coin_in == 4'b0010) begin
				state_insc <= 3'b010;
				end
			else begin
				if(coin_in == 4'b0100) begin
					state_insc <= 3'b011;
					end
				else begin
					if(coin_in == 4'b1000) begin
						state_insc <= 3'b100;
						end
				end
			end
		end
	end
end

always @ (state_insc) begin
	case(state_insc)
	3'b000 : begin
		 coin <= 8'b0000_0000;
		 end	
	3'b001 : begin
		 coin <= 8'b0000_0001;		// Coin 1
		 opr_fg <= 1;
		 end
	3'b010 : begin
		 coin <= 8'b0000_0010;		// Coin 2
		 opr_fg <= 1;
		 end
	3'b011 : begin
		 coin <= 8'b0000_0101;		// Coin 5
		 opr_fg <= 1;
		 end
	3'b100 : begin
		 coin <= 8'b0000_1010;		// Coin 10
		 opr_fg <= 1;
		 end
	endcase
end

always @(posedge clk, posedge rst) begin
	if(rst)
		state_out <= 3'b000;
	else begin
		if(opr_fg == 1 && state_out == 3'b000) begin
			state_out <= 3'b001;
			opr_fg <= 0;
			end

		case(state_out)
		3'b000 : begin
			 state_cmp3 <= 0;
			 out_RDY3 <= 0;
			 DATA_out3 <= 8'b0000_0000;
			 end
		3'b001 : begin
			 out_RDY3 <= 1;
			 state_out <= state_out + 1;
			 end
		3'b010 : begin
			 DATA_out3 <= coin;
			 state_out <= state_out + 1;
			 end
		3'b011 : begin
			 state_cmp3 <= 1;
			 out_RDY3 <= 0;
			 DATA_out3 <= 8'b0000_0000;
			 state_out <= 3'b000;
			 state_insc <= 3'b000;		
			 end	 
		endcase
	end
end
endmodule
