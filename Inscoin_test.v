module Insc_test;

reg clk, rst;
wire out_RDY3, state_cmp3;
wire [7:0] DATA_out3;
reg [7:0] coin_in;
integer i;

Ins_coin insct(.clk(clk), .rst(rst), .coin_in(coin_in), .state_cmp3(state_cmp3), .out_RDY3(out_RDY3), .DATA_out3(DATA_out3));

initial 
	begin
	     clk = 0;
	     rst = 1; 
	#10  clk = 1;
	     rst = 0;	     
	#10  clk = 0;
	#10  clk = 1;
	     coin_in = 4'b0001;
	#10  clk = 0;
	#10  clk = 1;
	     coin_in = 4'b0000;
	#10  clk = 0;
	
	for(i=0;i<5;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end

	#10  clk = 0;
	#10  clk = 1;
	     coin_in = 4'b0100;
	#10  clk = 0;
	#10  clk = 1;
	     coin_in = 4'b0000;
	#10  clk = 0;
	
	for(i=0;i<5;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end
	end
endmodule
