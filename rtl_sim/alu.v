module alu (
    input wire clk,
    input wire reset,
    input wire [5:0] alu_op,
    input wire [31:0] operand_a,
    input wire [31:0] operand_b,
    output reg [31:0] result
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result <= 32'b0;
        end else begin
            case (alu_op)
                6'd0: result <= operand_a + operand_b;
                6'd1: result <= operand_a + operand_b;
                6'd2: result <= operand_a + operand_b;
                6'd3: result <= operand_a + operand_b;
                6'd4: result <= (operand_a == operand_b) ? 32'd1 : 32'd0;
                6'd5: result <= operand_a + operand_b;
                6'd6: result <= operand_a + operand_b;
                6'd7: result <= operand_b;
                default: result <= 32'b0;
            endcase
        end
    end

endmodule
