module compare_test;

reg clk, rst;
reg in_RDY6;
reg signed[7:0] DATA_in6;
wire out_RDY6, state_cmp6;
wire [7:0] DATA_out6;
integer i;

compare comt(.clk(clk), .rst(rst), .in_RDY6(in_RDY6), .DATA_in6(DATA_in6), .state_cmp6(state_cmp6), .out_RDY6(out_RDY6), .DATA_out6(DATA_out6));

initial 
	begin
	     clk = 0;
	     rst = 1; 
	#10  clk = 1;
	     rst = 0;	     
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY6 = 1;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in6 = 8'b1111_1010;
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY6 = 0;
	     DATA_in6 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<4;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end

	#10  clk = 1;
	     in_RDY6 = 1;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in6 = 8'b0000_0000;
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY6 = 0;
	#10  clk = 0;
	
	for(i=0;i<4;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end

	#10  clk = 1;
	     in_RDY6 = 1;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in6 = 8'b0000_1010;
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY6 = 0;
	     DATA_in6 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<4;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end
	end
endmodule
