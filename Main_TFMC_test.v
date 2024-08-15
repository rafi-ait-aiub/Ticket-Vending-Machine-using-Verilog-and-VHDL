module Main_TFMC_test;

reg clk, rst;
reg reset_button, sensor_t;
reg [7:0] DATA_inm;
wire state_cmpm;
wire [3:0] return_state;
reg [3:0] state_test, sub_state_test;
reg [3:0] j;
integer i;

Main_TFMC maint(.clkm(clk), .rstm(rst), .reset_button(reset_button), .sensor_t(sensor_t), .DATA_inm(DATA_inm), .state_cmpm(state_cmpm), .return_state(return_state));

initial
	begin
	     clk = 0;
	     rst = 1; 
	#10  clk = 1;
	     rst = 0;	
	     j = 3'b000;
	     state_test = 4'b0000;
	     sub_state_test = 4'b0000;
	end

always begin
for(i=0;i<200;i=i+1) begin
	#10 clk = 1;
	#10 clk = 0;
	end
end

always @(posedge clk) begin
	case(state_test)
	4'b0000 : begin								// for testing state 1 
	  	  case(sub_state_test)
	  	  4'b0000 : begin
			    DATA_inm = 8'b0000_1000;
			    sub_state_test = sub_state_test + 1;
		    	    end
	  	  4'b0001 : begin
			    //reset_button = 1;					// user press the reset button in state 1 
			    DATA_inm = 8'b0000_0000;
			    sub_state_test = sub_state_test + 1;
		    	    end
		  4'b0010 : begin
			    //reset_button = 0;					// clear the reset button signal
			    if(state_cmpm == 1) begin
				    state_test = state_test + 1;
				    sub_state_test = 0;
			  	    end
			    end
	 	  endcase
	 	  end
	4'b0001 : begin								// for testing state 2
		  if(state_cmpm == 1)
		  	  state_test = state_test + 1;
		  end
	4'b0010 : begin								// for testing state 3
		  case(sub_state_test)
		  4'b0000 : begin
			    DATA_inm = 8'b0000_1000;				// insert 10 bath
			    sub_state_test = sub_state_test + 1;
			    end
		  4'b0001 : begin
			    //if(j == 2)
				    //reset_button = 1;				// user press the button in state 3 after they insert coin 2 times	
			    DATA_inm = 8'b0000_0000;
			    sub_state_test = sub_state_test + 1;
			    //j = j + 1;
			    end
		  4'b0010 : begin
			    //reset_button = 0;
			    if(state_cmpm == 1) begin
				    state_test = state_test + 1;
				    sub_state_test = 0;
			  	    end
			    end
		  endcase
		  end
	4'b0011 : begin								// for testing state 4
		  if(state_cmpm == 1)
		  	  state_test = state_test + 1;
		  end
	4'b0100 : begin								// for testing state 5
		  if(state_cmpm == 1)
		  	  state_test = state_test + 1;
		  end
	4'b0101 : begin								// for testing state 6
		  case(sub_state_test)
		  4'b0000 : begin
			    if(state_cmpm == 1) 			
			    	    sub_state_test = sub_state_test + 1;
			    end
		  4'b0001 : begin
			    if(return_state == 4'b0001)
				    state_test = 4'b0001;
			    else begin
				    if(return_state == 4'b0110)
				    	    state_test = 4'b0110;
				    else
					    state_test = 4'b0111;
				    end
			    sub_state_test = 0;
			    end
		  endcase
		  end
	4'b0110 : begin								// for testing state 7
		  if(state_cmpm == 1)
		  	  state_test = state_test + 1;
		  end
	4'b0111 : begin								// for testing state 8
		  if(state_cmpm == 1)
		  	  state_test = state_test + 1;
		  end
	4'b1000 : begin								// for testing state 9
		  case(sub_state_test)
		  4'b0000 : begin		
			    sub_state_test = sub_state_test + 1;
			    end
		  4'b0001 : begin	
			    sub_state_test = sub_state_test + 1;	
			    end
		  4'b0010 : begin	
			    sensor_t = 1;	
			    sub_state_test = sub_state_test + 1;
			    end
		  4'b0011 : begin	
			    sensor_t = 0;	
			    if(state_cmpm == 1) begin
				    state_test = state_test + 1;
				    sub_state_test = 0;
			  	    end
			    end
		  endcase
		  end
	4'b1001 : begin								// for testing state 10
		  if(state_cmpm == 1)
		  	  state_test = 4'b0000;
		  end
	endcase
end
endmodule
