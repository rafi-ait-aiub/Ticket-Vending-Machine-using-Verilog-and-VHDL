module Ticketout_test;

reg clk, rst;
reg sensor_t, in_RDY9;
wire ticket_out, state_cmp9;
integer i;

Ticketout tckt(.clk(clk), .rst(rst), .sensor_t(sensor_t), .in_RDY9(in_RDY9),.state_cmp9(state_cmp9), .ticket_out(ticket_out));

initial 
	begin
	     clk = 0;
	     rst = 1; 
	#10  clk = 1;
	#10  clk = 0;
	#10  clk = 1;
	     rst = 0;
	     in_RDY9 = 1;	     
	#10  clk = 0;
	#10  clk = 1;
	     in_RDY9 = 0;
	#10  clk = 0;
	
	for(i=0;i<2;i=i+1) begin	// time 2 cycles
		#10 clk = 1;
		#10 clk = 0;
		end
	#10  clk = 1;
	     sensor_t = 1;
	#10  clk = 0;
	#10  clk = 1;
	     sensor_t = 0;
	#10  clk = 0;



	#10  clk = 1;
	#1   in_RDY9 = 1;	     
	#9   clk = 0;
	#10  clk = 1;
	#1   in_RDY9 = 0;		// edit time delay
	#9   clk = 0;
	
	
	for(i=0;i<5;i=i+1) begin	// change time 5 cycles
		#10 clk = 1;
		#10 clk = 0;
		end
	#10  clk = 1;
	     sensor_t = 1;
	#10  clk = 0;
	#10  clk = 1;
	     sensor_t = 0;
	#10  clk = 0;

	for(i=0;i<2;i=i+1) begin
		#10 clk = 1;
		#10 clk = 0;
		end
	end

endmodule

