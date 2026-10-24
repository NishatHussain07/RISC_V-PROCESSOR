module control_unit (
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    input wire [31:0] instruction,
    output reg [5:0] alu_op,
    output reg branch_taken,
    output reg jal,
    output reg jalr,
    output reg [31:0] imm_address,
    output reg [31:0] inst_jump
);

    always @(*) begin
        alu_op = 6'd0;
        branch_taken = 1'b0;
        jal = 1'b0;
        jalr = 1'b0;
        imm_address = 32'b0;
        inst_jump = 32'b0;

        case (opcode)
            7'b0110011: begin
                alu_op = 6'd0;
            end

            7'b0010011: begin
                alu_op = 6'd1;
                imm_address = {{20{instruction[31]}}, instruction[31:20]};
            end

            7'b0000011: begin
                alu_op = 6'd2;
                imm_address = {{20{instruction[31]}}, instruction[31:20]};
            end

            7'b0100011: begin
                alu_op = 6'd3;
                imm_address = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end

            7'b1100011: begin
                alu_op = 6'd4;
                imm_address = {{19{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
                branch_taken = 1'b1;
            end

            7'b1101111: begin
                alu_op = 6'd5;
                jal = 1'b1;
                imm_address = {{11{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
                inst_jump = imm_address;
            end

            7'b1100111: begin
                alu_op = 6'd6;
                jalr = 1'b1;
                imm_address = {{20{instruction[31]}}, instruction[31:20]};
                inst_jump = imm_address;
            end

            7'b0110111: begin
                alu_op = 6'd7;
                imm_address = {instruction[31:12], 12'b0};
            end

            default: begin
                alu_op = 6'd0;
            end
        endcase
    end

endmodule
