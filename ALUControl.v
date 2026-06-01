module ALUControl (
    input wire [1:0] ALUop,
    input wire [2:0] funct3,
    input wire op5,
    input wire funct7_5,
    output reg [2:0] ALUDecoder
);

always @(*) begin
case (ALUop)
	2'b00: ALUDecoder = 3'b000;
	2'b01: ALUDecoder = 3'b001;
	2'b10: begin
	case (funct3)
		3'b000: begin
			if (op5 & funct7_5) 
				ALUDecoder = 3'b001;
			else                
				ALUDecoder = 3'b000;
		end
		 3'b001: ALUDecoder = 3'b101;
		 3'b110: ALUDecoder = 3'b011;
		 3'b111: ALUDecoder = 3'b010;
		 default: 
			ALUDecoder = 3'b000;
	endcase
end

	default: ALUDecoder = 3'b000;
endcase

end

endmodule
