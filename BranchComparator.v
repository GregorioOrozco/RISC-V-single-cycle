module BranchComparator #(parameter N=32) (
	input [N-1:0] A, B,
	input [2:0] funct3,
	output reg TakeBranch
);

always @(*) begin
	case (funct3)
		3'b000:  TakeBranch = (A == B);
		3'b001:  TakeBranch = (A != B);
		3'b100:  TakeBranch = ($signed(A) < $signed(B));
		3'b101:  TakeBranch = ($signed(A) >= $signed(B));
		3'b110:  TakeBranch = (A < B);
		3'b111:  TakeBranch = (A >= B);
		default: TakeBranch = 0;
	endcase
end

endmodule
