module sumcoin_test;

reg clk, rst;
reg frt_fg4, in_RDY4;
reg [7:0] DATA_in4;
wire out_RDY4, state_cmp4;
wire [7:0] DATA_out4;
integer i;

sum_coins sumct(.clk(clk), .rst(rst), .frt_fg4(frt_fg4), .in_RDY4(in_RDY4), .DATA_in4(DATA_in4), .state_cmp4(state_cmp4), .out_RDY4(out_RDY4), .DATA_out4(DATA_out4));

initial 
	begin
	     clk = 0;
	     rst = 1; 
	#10  clk = 1;
	     rst = 0;	     
	#10  clk = 0;
	#10  clk = 1;
	     frt_fg4 = 1;
	     in_RDY4 = 1;
	#10  clk = 0;
	#10  clk = 1;
	     frt_fg4 = 0;
	     in_RDY4 = 0;
	     DATA_in4 = 8'b0000_0001;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in4 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<3;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end

	#10  clk = 1;
	     in_RDY4 = 1;
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY4 = 0;
	     DATA_in4 = 8'b0000_0101;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in4 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<3;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end

	#10  clk = 1;
	     frt_fg4 = 1;
	     in_RDY4 = 1;
	#10  clk = 0;
	#10  clk = 1;
	     frt_fg4 = 0;
	     in_RDY4 = 0;
	     DATA_in4 = 8'b0000_1010;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in4 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<3;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end
	end
endmodule
