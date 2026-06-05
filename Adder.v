module Adder #(parameter N=32) (
    input [N-1:0] A, B,
    output reg [N-1:0] Result
);

always @(*) begin
	Result=A+B;
end

endmodule 
