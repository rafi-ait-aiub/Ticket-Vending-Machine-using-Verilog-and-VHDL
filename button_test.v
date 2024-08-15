module button_scan_test;

reg clk, rst;
wire out_RDY1, state_cmp1;
wire [7:0] DATA_out1;
reg [7:0] button;
integer i;

button_scan btst(.clk(clk), .rst(rst), .but(button), .state_cmp1(state_cmp1), .out_RDY1(out_RDY1), .DATA_out1(DATA_out1));

initial 
	begin
	     clk = 0;
	     rst = 1; 
	#10  clk = 1;
	     rst = 0;	     
	#10  clk = 0;
	#10  clk = 1;
	     button = 8'b0001_0000;
	#10  clk = 0;
	#10  clk = 1;
	     button = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<10;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end

	#10  clk = 0;
	#10  clk = 1;
	     button = 8'b0000_0100;
	#10  clk = 0;
	#10  clk = 1;
	     button = 8'b0000_0000;
	#10  clk = 0;
	
	for(i=0;i<10;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end
	end
endmodule
