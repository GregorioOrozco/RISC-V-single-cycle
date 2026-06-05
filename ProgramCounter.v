module ProgramCounter #(parameter N=32) (
	input clk,
	input rst,
	input [N-1:0] PC_in,
	output reg [N-1:0] PC_out
);

always @(posedge clk or posedge rst) begin
	if (rst) begin
		PC_out <= 0;
	end 
	else begin
		PC_out <= PC_in;
	end
end

endmodule
