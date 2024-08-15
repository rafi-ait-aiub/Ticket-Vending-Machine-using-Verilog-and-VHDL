module compare(clk, rst, in_RDY6, DATA_in6, state_cmp6, out_RDY6, DATA_out6);
	input clk, rst;
	input in_RDY6;
	input [7:0] DATA_in6;
	output state_cmp6, out_RDY6;
	output [7:0] DATA_out6;
	reg state_cmp6, out_RDY6;
	reg [1:0] result;
	reg [2:0] state_comp;
	reg [7:0] DATA_out6;
	reg signed [7:0] data_mem;

always @(posedge clk, posedge rst) begin
	if(rst) begin
		state_cmp6 <= 0; 
		out_RDY6 <= 0;
		DATA_out6 <= 8'b0000_0000;
		data_mem <= 8'b0000_0000;
		state_comp <= 3'b000;
		end
	else begin
		case (state_comp)
		3'b000 : begin
			 data_mem <= 8'b0000_0000;
			 result <= 2'b00;
			 state_cmp6 <= 0;
			 if(in_RDY6) begin
				 state_comp = state_comp + 1;
				 end
			 end
		3'b001 : begin
			 data_mem <= DATA_in6;
			 state_comp <= state_comp + 1;
			 end
		3'b010 : begin
			 if(data_mem < 0) begin
				 result <= 2'b01;
				 end
			 else begin
				if(data_mem > 0) begin
					result <= 2'b10;
					end
				else begin
					if(data_mem == 0) begin
						result <= 2'b00;
						end
					end				
			 	end
			 state_comp <= state_comp + 1;
			 end
		3'b011 : begin
			 out_RDY6 <= 1;
			 state_comp <= state_comp + 1; 
			 end
		3'b100 : begin
			 DATA_out6 <= result;
			 state_comp <= state_comp + 1; 
			 end
		3'b101 : begin
			 state_cmp6 <= 1;
			 out_RDY6 <= 0;
			 DATA_out6 <= 8'b0000_0000;
			 state_comp <= 0; 
			 end
		
		endcase
	end
end
endmodule
