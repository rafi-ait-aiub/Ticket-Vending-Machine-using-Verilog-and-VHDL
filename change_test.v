module change_test;

reg clk, rst;
reg in_RDY7;
wire out_RDY7, state_cmp7;
wire [7:0] DATA_out7;
reg [7:0] DATA_in7;
integer i;

change chgt(.clk(clk), .rst(rst), .in_RDY7(in_RDY7), .DATA_in7(DATA_in7), .state_cmp7(state_cmp7), .out_RDY7(out_RDY7), .DATA_out7(DATA_out7));

initial 
	begin
	     clk = 0;
	     rst = 1; 
	#10  clk = 1;
	#10  clk = 0;
	#10  clk = 1;
	     rst = 0;
	     in_RDY7 = 1;	     
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY7 = 0;
	     DATA_in7 = 8'b1111_1010;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in7 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<10;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end

	#10  clk = 1;
	     in_RDY7 = 1;	     
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY7 = 0;
	     DATA_in7 = 8'b0000_1010;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in7 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<10;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end
	end
endmodule
