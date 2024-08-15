module updata(clk, rst, in_RDY8, DATA_in8, state_cmp8, out_RDY8, DATA_out8);
	input clk, rst;
	input in_RDY8;
	input [7:0] DATA_in8;
	output state_cmp8, out_RDY8;
	output DATA_out8;
	reg state_cmp8, out_RDY8;
	reg DATA_out8;
	reg [2:0] state_up;
	reg [7:0] i, data_mem1, data_mem2;

always @(posedge clk, posedge rst) begin
	if(rst) begin
		state_cmp8 <= 0; 
		out_RDY8 <= 0;
		DATA_out8 <= 0;
		data_mem1 <= 8'b0000_0000;
		data_mem2 <= 8'b0000_0000;
		state_up <= 3'b000; 	// clear every values here
		end
	else begin
		case (state_up)
		3'b000 : begin
			 state_cmp8 <= 0;
			 data_mem1 <= 8'b0000_0000;
			 data_mem2 <= 8'b0000_0000;
			 if(in_RDY8)
			 	state_up = state_up + 1;
			 end
		3'b001 : begin  
			 data_mem1 <= DATA_in8;
			 state_up = state_up + 1;
			 end
		3'b010 : begin
			 data_mem2 <= DATA_in8;
			 out_RDY8 <= 1;
			 state_up = state_up + 1;
			 i <= 8'b0000_0111;
			 end
		3'b011 : begin
			 if(i >= 0) begin
			 	DATA_out8 <= data_mem1[i];
				i <= i - 1;
				if(i == 0) begin
					state_up = state_up + 1;
					i <= 8'b0000_0111;
					end
				end
			 end
		3'b100 : begin
			 if(i >= 0) begin
			 	DATA_out8 <= data_mem2[i];
				i <= i - 1;
			  	if(i == 0) begin
					state_up = state_up + 1;
					end
				end
			 end
		3'b101 : begin
			  state_cmp8 <= 1;
			  out_RDY8 <= 0; 
			  DATA_out8 <= 0;
			  state_up = 0;			
			  end
		endcase
	end
end
endmodule
