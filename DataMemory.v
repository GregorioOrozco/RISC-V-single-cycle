module DataMemory #( parameter DATA_width = 32, parameter ADDR_width = 32 ) (
	input wire clk,
	input wire rst,
	input wire MemWrite,
	input wire [ADDR_width-1:0] addr,
	input wire [DATA_width-1:0] WriteData,
	output wire [DATA_width-1:0] ReadData
);

reg [DATA_width-1:0] MEMORY [0:63];
integer i;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		for (i = 0; i < 64; i = i + 1) begin
			MEMORY[i] <= 0;
		end
	end 
	else if (MemWrite) begin
		MEMORY[addr[7:2]] <= WriteData;
	end
end
	assign ReadData = MEMORY[addr[7:2]];

endmodule
