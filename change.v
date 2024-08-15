module change(clk, rst, in_RDY7, DATA_in7, state_cmp7, out_RDY7, DATA_out7);
	input clk, rst;
	input in_RDY7;
	input [7:0] DATA_in7;
	output state_cmp7, out_RDY7;
	output DATA_out7;
	reg state_cmp7, out_RDY7;
	reg DATA_out7;
	reg [3:0] state_ch;
	reg signed [7:0] data_mem;

always @(posedge clk, posedge rst) begin
	if(rst) begin
		state_cmp7 <= 0; 
		out_RDY7 <= 0;
		DATA_out7 <= 0;
		data_mem <= 8'b0000_0000;
		state_ch <= 4'b0000; 	// clear every values here
		end
	else begin
		case (state_ch)
		4'b0000 : begin
			  state_cmp7 <= 0;
			  if(in_RDY7)
			 	 state_ch = state_ch + 1;
			  end
		4'b0001 : begin
			  out_RDY7 <= 1;  
			  if(DATA_in7[7])
			  	data_mem <= (~DATA_in7) + 1;
			  else
				data_mem <= DATA_in7;
			  state_ch = state_ch + 1;
			  end
		4'b0010 : begin
			  DATA_out7 <= data_mem[7];
			  state_ch = state_ch + 1;
			  end
		4'b0011 : begin
			  DATA_out7 <= data_mem[6];
			  state_ch = state_ch + 1;
			  end
		4'b0100 : begin
			  DATA_out7 <= data_mem[5];
			  state_ch = state_ch + 1;
			  end
		4'b0101 : begin
			  DATA_out7 <= data_mem[4];
			  state_ch = state_ch + 1;
			  end
		4'b0110 : begin
			  DATA_out7 <= data_mem[3];
			  state_ch = state_ch + 1;
			  end
		4'b0111 : begin
			  DATA_out7 <= data_mem[2];
			  state_ch = state_ch + 1;
			  end
		4'b1000 : begin
			  DATA_out7 <= data_mem[1];
			  state_ch = state_ch + 1;
			  end
		4'b1001 : begin
			  DATA_out7 <= data_mem[0];
			  state_ch = state_ch + 1;
			  end
		4'b1010 : begin
			  state_cmp7 <= 1;
			  out_RDY7 <= 0; 
			  DATA_out7 <= 0;
			  state_ch = 0;			
			  end
		endcase
	end
end
endmodule
