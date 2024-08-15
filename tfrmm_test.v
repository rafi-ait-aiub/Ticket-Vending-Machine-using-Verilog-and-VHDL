module tfrmm_test;

reg clk, rst;
reg in_RDY5;
reg [7:0] DATA_in5;
wire out_RDY5, state_cmp5;
wire [7:0] DATA_out5;
integer i;

tf_rmm trmt(.clk(clk), .rst(rst), .in_RDY5(in_RDY5), .DATA_in5(DATA_in5), .state_cmp5(state_cmp5), .out_RDY5(out_RDY5), .DATA_out5(DATA_out5));

initial 
	begin
	     clk = 0;
	     rst = 1; 
	#10  clk = 1;
	     rst = 0;	     
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY5 = 1;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in5 = 8'b0001_1110;			// Train fee
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in5 = 8'b0000_0101;			// money 
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY5 = 0;
	     DATA_in5 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<4;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end

	#10  clk = 1;
	     in_RDY5 = 1;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in5 = 8'b0001_1110;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in5 = 8'b0000_1010;
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY5 = 0;
	     DATA_in5 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<4;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end

	#10  clk = 1;
	     in_RDY5 = 1;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in5 = 8'b0000_1010;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in5 = 8'b0001_1110;
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY5 = 0;
	     DATA_in5 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<4;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end
	end
endmodule
