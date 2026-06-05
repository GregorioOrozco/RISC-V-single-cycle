module top (
    input clk,
    input reset
);

    wire [31:0] PC_in;
    wire [31:0] PC_out;
    wire [31:0] instr;
    wire [31:0] RD1;
    wire [31:0] RD2;
    wire [31:0] imm_ext;
    wire [31:0] SrcB;
    wire [31:0] Result_ALU;
    wire zero;
    wire [31:0] ReadData;
    wire [31:0] Result_WB;
    wire [31:0] PCPlus4;
    wire [31:0] PCTarget;
    wire TakeBranch;
    wire PCSrc;

    wire [1:0] ALUOp;
    wire ALUSrc;
    wire MemToReg;
    wire RegWrite;
    wire MemWrite;
    wire Branch;
    wire Jump;
    wire [2:0] ALUControl_wire;

    assign PCSrc = (Branch & TakeBranch) | Jump;

    ProgramCounter #(32) pc_reg (
        .clk(clk),
        .rst(reset),
        .PC_in(PC_in),
        .PC_out(PC_out)
    );

    InstructionMemory #(32, 32) inst_mem (
        .addr(PC_out),
        .instr(instr)
    );

    ControlUnit control (
        .opcode(instr[6:0]),
        .funct3(instr[14:12]),
        .op5(instr[5]),
        .funct7_5(instr[30]),
        .ALUOp(ALUOp),
        .ALUSrc(ALUSrc),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .Jump(Jump),
        .ALUControl(ALUControl_wire)
    );

    RegisterFile reg_file (
        .clk(clk),
        .WE3(RegWrite),
        .A1(instr[19:15]),
        .A2(instr[24:20]),
        .A3(instr[11:7]),
        .WD3(Result_WB),
        .RD1(RD1),
        .RD2(RD2)
    );

    ImmediateGenerator imm_gen (
        .instruction(instr),
        .imm_ext(imm_ext)
    );

    Mux #(2) mux_srcb (
        .mux_in({imm_ext, RD2}),
        .mux_sel(ALUSrc),
        .mux_out(SrcB)
    );

    ALU #(32) alu_core (
        .A(RD1),
        .B(SrcB),
        .ALUControl(ALUControl_wire),
        .Result(Result_ALU),
        .zero(zero)
    );

    BranchComparator #(32) branch_comp (
        .A(RD1),
        .B(RD2),
        .funct3(instr[14:12]),
        .TakeBranch(TakeBranch)
    );

    DataMemory #(32, 32) data_mem (
        .clk(clk),
        .rst(reset),
        .MemWrite(MemWrite),
        .addr(Result_ALU),
        .WriteData(RD2),
        .ReadData(ReadData)
    );

    Mux #(2) mux_wb (
        .mux_in({ReadData, Result_ALU}),
        .mux_sel(MemToReg),
        .mux_out(Result_WB)
    );

    Adder #(32) adder_pc4 (
        .A(PC_out),
        .B(32'd4),          
        .Result(PCPlus4)
    );

    Adder #(32) adder_target (
        .A(PC_out),
        .B(imm_ext),        
        .Result(PCTarget)
    );

    Mux #(2) mux_pc_next (
        .mux_in({PCTarget, PCPlus4}),
        .mux_sel(PCSrc),
        .mux_out(PC_in)
    );

endmodule
