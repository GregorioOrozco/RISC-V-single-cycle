module RAM #(
	parameter DATA_width = 16,
	parameter ADDR_width = 8
)(
	input wire clk,
	input wire rst,
	input wire [ADDR_width-1:0] addr,
	output wire [DATA_width-1:0] data_out
);

reg [DATA_width-1:0] MEMORY [0:2**ADDR_width-1];

initial
begin
	$readmem("mem.hex", MEMORY);
end
assign data_out = MEMORY[addr];

endmodule
