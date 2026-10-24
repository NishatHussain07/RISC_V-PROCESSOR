module top (
    input wire clk,
    input wire rest
);

    wire [31:0] imm_address;
    wire [31:0] imm_address_jump;
    wire branch_taken;
    wire jal;
    wire jalr;
    wire [31:0] pc;
    wire [31:0] current_pc;
    wire [31:0] instruction;
    wire [5:0] alu_op;
    wire [31:0] operand_a;
    wire [31:0] operand_b;
    wire [31:0] alu_result;

    instruction_fetch_unit ifu (
        .clk(clk),
        .rest(rest),
        .imm_address(imm_address),
        .imm_address_jump(imm_address_jump),
        .branch_taken(branch_taken),
        .jal(jal),
        .jalr(jalr),
        .pc(pc),
        .current_pc(current_pc)
    );

    instruction_memory im (
        .clk(clk),
        .rest(rest),
        .pc(pc),
        .instruction(instruction)
    );

    control_unit cu (
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .instruction(instruction),
        .alu_op(alu_op),
        .branch_taken(branch_taken),
        .jal(jal),
        .jalr(jalr),
        .imm_address(imm_address),
        .inst_jump(imm_address_jump)
    );

    assign operand_a = pc;
    assign operand_b = 32'd4;

    alu u_alu (
        .clk(clk),
        .reset(rest),
        .alu_op(alu_op),
        .operand_a(operand_a),
        .operand_b(operand_b),
        .result(alu_result)
    );

endmodule
