module InstructionMemory #( parameter DATA_width = 32, parameter ADDR_width = 32) (
	input wire [ADDR_width-1:0] addr,
	output wire [DATA_width-1:0] instr
);

reg [DATA_width-1:0] ROM [0:63];

initial begin
	$readmemh("program.hex", ROM);
end

assign instr = ROM[addr[7:2]];

endmodule
