module ALU #(parameter N=32)(
	input [N-1:0] A, B,           
	input [2:0]  ALUControl,  
	output reg [N-1:0] Result,
	output reg zero
);

 always @(*) begin
	  case (ALUControl)
			3'b000: Result = A + B;       
			3'b001: Result = A - B;       
			3'b010: Result = A & B;       
			3'b011: Result = A | B;         
			3'b101: Result = A << B; 
			default: Result = 0;     
	  endcase
	  
	  if(Result == 0)
		zero = 1;
	else
		zero = 0;
 end

endmodule
