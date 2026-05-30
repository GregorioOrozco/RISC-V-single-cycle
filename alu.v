module alu (
    input  wire [31:0] A,         
    input  wire [31:0] B,           
    input  wire [2:0]  ALUControl,  // Selector de operación
    output reg  [31:0] N            // Resultado
);

    always @(*) begin
        case (ALUControl)
            3'b000: N = A + B;       // ADD
            3'b001: N = A - B;       // SUBTRACT
            3'b010: N = A & B;       // AND
            3'b011: N = A | B;       // OR   
            3'b101: N = (A < B) ? 1 : 0; // SLT (Set on Less Than)
            default: N = 32'b0;      // Default a 0
        endcase
    end

endmodule
