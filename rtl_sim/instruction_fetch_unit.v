module instruction_fetch_unit (
    input wire clk,
    input wire rest,
    input wire [31:0] imm_address,
    input wire [31:0] imm_address_jump,
    input wire branch_taken,
    input wire jal,
    input wire jalr,
    output reg [31:0] pc,
    output reg [31:0] current_pc
);

    always @(posedge clk or posedge rest) begin
        if (rest) begin
            pc <= 32'b0;
            current_pc <= 32'b0;
        end else begin
            if (branch_taken)
                pc <= pc + imm_address;
            else if (jal || jalr)
                pc <= pc + imm_address_jump;
            else
                pc <= pc + 4;

            current_pc <= pc + 4;
        end
    end

endmodule
