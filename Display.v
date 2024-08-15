 module Display(clk, rst, in_RDY2, state_cmp2, out_RDY2, DATA_in2, DATA_out2);
	input clk, rst;
	input in_RDY2;
	input [7:0] DATA_in2;
	output DATA_out2;
	output state_cmp2, out_RDY2;
	reg DATA_out2;
	reg state_cmp2, out_RDY2;
	reg [3:0] state_dis;
	reg [7:0] data_mem;

always @(posedge clk, posedge rst) begin
	if(rst) begin
		state_cmp2 <= 0; 
		out_RDY2 <= 0;
		DATA_out2 <= 0;
		data_mem <= 8'b0000_0000;
		state_dis <= 4'b0000;
		end
	else begin
		case(state_dis)
		4'b0000 : begin
			  state_cmp2 <= 0;
			  DATA_out2 <= 0;
			  if(in_RDY2)
			  	state_dis = state_dis + 1;
			  end
		4'b0001 : begin
			  out_RDY2 <= 1;  
			  data_mem <= DATA_in2;
			  state_dis = state_dis + 1;
			  end
		4'b0010 : begin
			  DATA_out2 <= data_mem[7];
			  state_dis = state_dis + 1;
			  end
		4'b0011 : begin
			  DATA_out2 <= data_mem[6];
			  state_dis = state_dis + 1;
			  end
		4'b0100 : begin
			  DATA_out2 <= data_mem[5];
			  state_dis = state_dis + 1;
			  end
		4'b0101 : begin
			  DATA_out2 <= data_mem[4];
			  state_dis = state_dis + 1;
			  end
		4'b0110 : begin
			  DATA_out2 <= data_mem[3];
			  state_dis = state_dis + 1;
			  end
		4'b0111 : begin
			  DATA_out2 <= data_mem[2];
			  state_dis = state_dis + 1;
			  end
		4'b1000 : begin
			  DATA_out2 <= data_mem[1];
			  state_dis = state_dis + 1;
			  end
		4'b1001 : begin
			  DATA_out2 <= data_mem[0];
			  state_dis = state_dis + 1;
			  end
		4'b1010 : begin
			  state_cmp2 <= 1;
			  out_RDY2 <= 0; 
			  DATA_out2 <= 0;
			  state_dis = 0;			
			  end
		endcase
	end	
end
endmodule


