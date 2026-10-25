module instruction_fetch_unit (
    input wire clk,
    input wire rest,
    input wire [31:0] imm_address,
    input wire [31:0] imm_address_jump,
    input wire beq,
    input wire bneq,
    input wire blt,
    input wire bgt,
    input wire bltu,
    input wire bgeu,
    input wire JAL,
    input wire JALR,
    output reg [31:0] pc,
    output reg [31:0] current_pc
);

    always @(posedge clk) begin
        if (rest) begin
            pc <= 32'b0;
            current_pc <= 32'b0;
        end else begin
            if (beq || bneq || blt || bgt || bltu || bgeu)
                pc <= pc + imm_address;
            else if (JAL || JALR)
                pc <= pc + imm_address_jump;
            else
                pc <= pc + 4;

            if (!JAL && !JALR)
                current_pc <= pc + 4;
        end
    end

endmodule
