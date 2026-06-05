module ControlUnit (
	input [6:0] opcode,
	input [2:0] funct3,
	input op5,
	input funct7_5,
	output reg [1:0] ALUOp,
	output reg ALUSrc,
	output reg MemToReg,
	output reg RegWrite,
	output reg MemWrite,
	output reg Branch,
	output reg Jump,
	output reg [2:0] ALUControl
);

always @(*) begin
	case (opcode)
		7'b0110011: begin
			RegWrite   = 1;
			ALUSrc     = 0;
			MemWrite   = 0;
			MemToReg   = 0;
			Branch     = 0;
			Jump       = 0;
			ALUOp      = 2'b10;
		end
		7'b0010011: begin
			RegWrite   = 1;
			ALUSrc     = 1;
			MemWrite   = 0;
			MemToReg   = 0;
			Branch     = 0;
			Jump       = 0;
			ALUOp      = 2'b10;
		end
		7'b0000011: begin
			RegWrite   = 1;
			ALUSrc     = 1;
			MemWrite   = 0;
			MemToReg   = 1;
			Branch     = 0;
			Jump       = 0;
			ALUOp      = 2'b00;
		end
		7'b0100011: begin
			RegWrite   = 0;
			ALUSrc     = 1;
			MemWrite   = 1;
			MemToReg   = 0;
			Branch     = 0;
			Jump       = 0;
			ALUOp      = 2'b00;
		end
		7'b1100011: begin
			RegWrite   = 0;
			ALUSrc     = 0;
			MemWrite   = 0;
			MemToReg   = 0;
			Branch     = 1;
			Jump       = 0;
			ALUOp      = 2'b01;
		end
		7'b1101111: begin
			RegWrite   = 1;
			ALUSrc     = 0;
			MemWrite   = 0;
			MemToReg   = 0;
			Branch     = 0;
			Jump       = 1;
			ALUOp      = 2'b00;
		end
		default: begin
			RegWrite   = 0;
			ALUSrc     = 0;
			MemWrite   = 0;
			MemToReg   = 0;
			Branch     = 0;
			Jump       = 0;
			ALUOp      = 2'b00;
		end
	endcase
end

always @(*) begin
	case (ALUOp)
		2'b00: ALUControl = 3'b000;
		2'b01: ALUControl = 3'b001;
		2'b10: begin
			case (funct3)
				3'b000: begin
					if (op5 & funct7_5) 
						ALUControl = 3'b001;
					else                
						ALUControl = 3'b000;
				end
				3'b001: ALUControl = 3'b101;
				3'b110: ALUControl = 3'b011;
				3'b111: ALUControl = 3'b010;
				default: ALUControl = 3'b000;
			endcase
		end
		default: ALUControl = 3'b000;
	endcase
end

endmodule
