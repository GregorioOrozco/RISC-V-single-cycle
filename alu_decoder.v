module alu_decoder (
    input  wire [1:0] ALUOp,
    input  wire [2:0] funct3,
    input  wire       op5,      // Bit 5 del opcode
    input  wire       funct7_5, // Bit 5 del funct7
    output reg  [2:0] ALUControl
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 3'b000; // lw, sw -> add
            2'b01: ALUControl = 3'b001; // beq -> sub
            2'b10: begin // Tipo-R y Tipo-I
                case (funct3)
                    3'b000: begin
                        // Si op5, funct7_5 es 11 es resta, si no es suma
                        if (op5 & funct7_5) ALUControl = 3'b001; // sub
                        else                ALUControl = 3'b000; // add
                    end
                    3'b010: ALUControl = 3'b101; // slt
                    3'b110: ALUControl = 3'b011; // or
                    3'b111: ALUControl = 3'b010; // and
                    default: ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end
endmodule
