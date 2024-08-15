module updata_test;

reg clk, rst;
reg in_RDY8;
wire out_RDY8, state_cmp8;
wire [7:0] DATA_out8;
reg [7:0] DATA_in8;
integer i;


updata updt(.clk(clk), .rst(rst), .in_RDY8(in_RDY8), .DATA_in8(DATA_in8), .state_cmp8(state_cmp8), .out_RDY8(out_RDY8), .DATA_out8(DATA_out8));

initial 
	begin
	     clk = 0;
	     rst = 1; 
	#10  clk = 1;
	#10  clk = 0;
	#10  clk = 1;
	     rst = 0;
	     in_RDY8 = 1;	     
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in8 = 8'b000_1000;			// number of stations --> 8 DEC
	#10  clk = 0;
	#10  clk = 1;
	     DATA_in8 = 8'b0010_0010;			// location --> line 1 station 2
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY8 = 0;	
	     DATA_in8 = 8'b0000_0000;			// clear input
	#10  clk = 0;
	
	for(i=0;i<17;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end
	end
endmodule
