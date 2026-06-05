module ImmediateGenerator (
	input [31:0] instruction,
	output reg [31:0] imm_ext
);

always @(*) begin
	case (instruction[6:0])
		7'b0010011, 7'b0000011, 7'b1100111: begin
			imm_ext = {{20{instruction[31]}}, instruction[31:20]};
		end
		7'b0100011: begin
			imm_ext = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
		end
		7'b1100011: begin
			imm_ext = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
		end
		7'b1101111: begin
			imm_ext = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
		end
		7'b0110111, 7'b0010111: begin
			imm_ext = {instruction[31:12], 12'b0};
		end
		default: imm_ext = 0;
	endcase
end

endmodule
