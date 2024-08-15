module Ticketout(clk, rst, sensor_t, in_RDY9, ticket_out, state_cmp9);
	input clk, rst;
	input sensor_t, in_RDY9;
	output ticket_out, state_cmp9;
	reg state_cmp9, ticket_out;
	reg [1:0] state_tic;

always @(posedge clk, posedge rst) begin
	if(rst) begin
		ticket_out <= 0;
		state_cmp9 <= 0; 
		state_tic <= 2'b00; 	// clear every values here
		end
	else begin
		case (state_tic)
		2'b00 : begin
			ticket_out <= 0;
			state_cmp9 <= 0; 
			if(in_RDY9) begin
				state_tic <= state_tic + 1;
				end
			end 
		2'b01 : begin
			ticket_out <= 1;
			state_tic <= state_tic + 1;
			end
		2'b10 : begin
			if(sensor_t) begin
				ticket_out <= 0;
				state_tic <= state_tic + 1;
				end
			end
		2'b11 : begin
			state_cmp9 <= 1;
			state_tic <= 2'b00;
			end
		endcase
	end
end
endmodule
			  
			 