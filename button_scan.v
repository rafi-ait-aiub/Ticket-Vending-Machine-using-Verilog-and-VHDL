module button_scan(clk, rst, but, state_cmp1, out_RDY1, DATA_out1);
	input clk, rst;
	input [7:0] but;
	output state_cmp1, out_RDY1;
	output [7:0] DATA_out1;
	reg state_cmp1, out_RDY1;
	reg opr_fg;
	reg [2:0] state_out;
	reg [3:0] state_but;
	reg [7:0] DATA_out1, train_fee, NMS;

always @(posedge clk, posedge rst) begin
	if(rst) begin
		state_cmp1 <= 0; 
		out_RDY1 <= 0;
		opr_fg <= 0;
		DATA_out1 <= 8'b0000_0000;
		state_out <= 3'b000;
		state_but <= 4'b0000;
		end
	else begin
		if(but == 8'b0000_0001) begin
			state_but <= 4'b0001;
			end
		else begin
			if(but == 8'b0000_0010) begin
				state_but <= 4'b0010;
				end
			else begin
				if(but == 8'b0000_0100) begin
					state_but <= 4'b0011;
					end
				else begin
					if(but == 8'b0000_1000) begin
						state_but <= 4'b0100;
						end
					else begin
						if(but == 8'b0001_0000) begin
							state_but <= 4'b0101;
							end
						else begin
							if(but == 8'b0010_0000) begin
								state_but <= 4'b0110;
								end
							else begin
								if(but == 8'b0100_0000) begin
									state_but <= 4'b0111;
										end
								else begin
									if(but == 8'b1000_0000) begin
										state_but <= 4'b1000;
										end
									//else state_but <= 4'b0000;
								end
							end
						end							
					end
				end
			end				
		end
	end
end

always @ (state_but) begin
	case(state_but)
	4'b0000 : begin
		  train_fee <= 8'b0000_0000;
		  NMS <= 8'b0000_0000;
		  end
	4'b0001 : begin
		  train_fee <= 8'b0001_0000;	// 16 DEC
		  NMS <= 8'b0000_0001;		// 1 DEC
		  opr_fg <= 1;
		  end
	4'b0010 : begin
		  train_fee <= 8'b0001_0111;	// 23 DEC
		  NMS <= 8'b0000_0010;		// 2 DEC
		  opr_fg <= 1;
		  end
	4'b0011 : begin
		  train_fee <= 8'b0001_1010;	// 26 DEC
		  NMS <= 8'b0000_0011;		// 3 DEC
		  opr_fg <= 1;
		  end
	4'b0100 : begin
		  train_fee <= 8'b0001_1110;	// 30 DEC
		  NMS <= 8'b0000_0100;		// 4 DEC
		  opr_fg <= 1;
		  end
	4'b0101 : begin
		  train_fee <= 8'b0010_0001;	// 33 DEC
		  NMS <= 8'b0000_0101;		// 5 DEC
		  opr_fg <= 1;
		  end
	4'b0110 : begin
		  train_fee <= 8'b0010_0100;	// 37 DEC
		  NMS <= 8'b0000_0110;		// 6 DEC
		  opr_fg <= 1;
		  end
	4'b0111 : begin
		  train_fee <= 8'b0010_1000;	// 40 DEC
		  NMS <= 8'b0000_0111;		// 7 DEC
		  opr_fg <= 1;
		  end
	4'b1000 : begin
		  train_fee <= 8'b0010_1100;	// 44 DEC
		  NMS <= 8'b0001_0111;		// 23 DEC
		  opr_fg <= 1;
		  end
	endcase
end

always @(posedge clk, posedge rst) begin
	if(rst)
		state_out <= 3'b000;
	else begin
		if(opr_fg == 1 && state_out == 3'b000) begin
			state_out <= 3'b001;
			opr_fg <= 0;
			end

		case(state_out)
		3'b000 : begin
			 state_cmp1 <= 0;
			 out_RDY1 <= 0;
			 DATA_out1 <= 8'b0000_0000;
			 end
		3'b001 : begin
			 out_RDY1 <= 1;
			 state_out <= state_out + 1;
			 end
		3'b010 : begin
			 DATA_out1 <= train_fee;
			 state_out <= state_out + 1;
			 end
		3'b011 : begin
			 DATA_out1 <= NMS;
			 state_out <= state_out + 1;
			 end
		3'b100 : begin
			 state_cmp1 <= 1;
			 out_RDY1 <= 0;
			 DATA_out1 <= 8'b0000_0000;
			 state_out <= 3'b000;
			 state_but <= 4'b0000;
			 end
		endcase
	end
end
endmodule
	