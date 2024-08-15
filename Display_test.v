module Display_test;

reg clk, rst;
reg in_RDY2;
wire out_RDY2, state_cmp2;
wire [7:0] DATA_out2;
reg [7:0] DATA_in2;
integer i;

Display dspt(.clk(clk), .rst(rst), .in_RDY2(in_RDY2), .DATA_in2(DATA_in2), .state_cmp2(state_cmp2), .out_RDY2(out_RDY2), .DATA_out2(DATA_out2));

initial 
	begin
	     clk = 0;
	     rst = 1; 
	#10  clk = 1;
	#10  clk = 0;
	#10  clk = 1;
	     rst = 0;
	     in_RDY2 = 1;	     
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY2 = 0;
	     DATA_in2 = 8'b0000_0101;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in2 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<10;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end

	#10  clk = 1;
	     in_RDY2 = 1;	     
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY2 = 0;
	     DATA_in2 = 8'b0000_1010;
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in2 = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<10;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end
	end
endmodule

