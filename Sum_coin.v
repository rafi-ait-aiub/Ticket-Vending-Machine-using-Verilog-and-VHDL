module sum_coins(clk, rst, in_RDY4, frt_fg4, DATA_in4, state_cmp4, out_RDY4, DATA_out4);
	input clk, rst;
	input frt_fg4, in_RDY4;
	input [7:0] DATA_in4;
	output state_cmp4, out_RDY4;
	output [7:0] DATA_out4;
	reg state_cmp4, out_RDY4;
	reg [2:0] state_summ;
	reg [7:0] money, DATA_out4;

always @(posedge clk, posedge rst) begin
	if(rst) begin
		state_cmp4 <= 0; 
		out_RDY4 <= 0;
		DATA_out4 <= 8'b0000_0000;
		money <= 8'b0000_0000;
		state_summ <= 3'b000; 	// clear every values here
		end
	else begin
		case (state_summ)
		3'b000 : begin
			 state_cmp4 <= 0;
			 if(frt_fg4)
				 money <= 0;
			 if(in_RDY4)
				 state_summ <= state_summ + 1;
			 end
		3'b001 : begin
			 money <= money + DATA_in4;
			 state_summ <= state_summ + 1;
			 end
		3'b010 : begin
			 out_RDY4 <= 1;
			 state_summ <= state_summ + 1;
			 end
		3'b011 : begin
			 DATA_out4 <= money;
			 state_summ <= state_summ + 1;
			 end
		3'b100 : begin
			 state_cmp4 <= 1;
			 out_RDY4 <= 0;
			 DATA_out4 <= 8'b0000_0000;
			 state_summ <= 3'b000;
			 end
		endcase
	end
end
endmodule
