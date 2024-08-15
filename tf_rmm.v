module tf_rmm(clk, rst, in_RDY5, DATA_in5, state_cmp5, out_RDY5, DATA_out5);
	input clk, rst;
	input in_RDY5;
	input [7:0] DATA_in5;
	output state_cmp5, out_RDY5;
	output [7:0] DATA_out5;
	reg state_cmp5, out_RDY5;
	reg [2:0] state_sub;
	reg [7:0] train_fee, money, DATA_out5;
	reg signed [7:0] rmm;

always @(posedge clk, posedge rst) begin
	if(rst) begin
		state_cmp5 <= 0; 
		out_RDY5 <= 0;
		DATA_out5 <= 8'b0000_0000;
		train_fee <= 8'b0000_0000;
		money <= 8'b0000_0000;
		rmm <= 8'b0000_0000;
		state_sub <= 3'b000; 	// clear every values here
		end
	else begin
		case (state_sub)
		3'b000 : begin
			 state_cmp5 <= 0; 
			 if(in_RDY5)
				 state_sub <= state_sub + 1;
			 end
		3'b001 : begin
			 train_fee <= DATA_in5;
			 state_sub <= state_sub + 1;
			 end
		3'b010 : begin 
			 money <= DATA_in5;
			 state_sub <= state_sub + 1;
			 end
		3'b011 : begin
			 rmm <= train_fee - money;
			 out_RDY5 <= 1;
			 state_sub = state_sub + 1;
			 end
		3'b100 : begin
			 DATA_out5 <= rmm;
			 state_sub <= state_sub + 1;
			 end	
		3'b101 : begin
			 state_cmp5 <= 1;
			 out_RDY5 <= 0;
			 DATA_out5 <= 0;
			 state_sub <= 3'b000;
			 end	 
		endcase
	end
end
endmodule
	