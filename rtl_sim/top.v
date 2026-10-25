module top(input clk, rest);

    wire [31:0] imm_address;
    wire [31:0] imm_address_jump;
    wire beq, bneq, blt, bgt, bltu, bgeu, JAL, JALR;
    wire [31:0] pc, current_pc;
    wire [31:0] instruction;
    wire [5:0] control_out;
    wire [4:0] rs1, rs2, rs3;
    wire [31:0] result;
    wire [31:0] inst_jump;

    assign imm_address = {{19{instruction[31]}}, instruction[31],
                          instruction[7], instruction[30:25],
                          instruction[11:8], 1'b0};

    instruction_fetch_unit IFU_UTT(
        clk,
        rest,
        imm_address,
        inst_jump,
        beq,
        bneq,
        blt,
        bgt,
        bltu,
        bgeu,
        JAL,
        JALR,
        pc,
        current_pc
    );

    instruction_memory IM_UTT(
        clk,
        rest,
        pc,
        instruction
    );

    control_unit CU_UTT(
        clk,
        instruction[31:25],
        instruction[14:12],
        instruction[6:0],
        control_out,
        result[0],
        beq,
        bneq,
        blt,
        bgt,
        bltu,
        bgeu,
        JAL,
        JALR,
        instruction,
        inst_jump
    );

    ALU alu_utt(
        clk,
        rest,
        control_out,
        instruction[31:20],
        instruction[19:15],
        instruction[24:20],
        instruction[11:7],
        result,
        pc
    );

endmodule
