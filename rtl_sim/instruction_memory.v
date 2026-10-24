module instruction_memory (
    input wire clk,
    input wire rest,
    input wire [31:0] pc,
    output reg [31:0] instruction
);

    reg [31:0] rom [0:63];

    initial begin
        rom[0]  = 32'h00100093; // addi x1, x0, 1
        rom[1]  = 32'h00200113; // addi x2, x0, 2
        rom[2]  = 32'h002081b3; // add x3, x1, x2
        rom[3]  = 32'h00000013; // nop
        rom[4]  = 32'h00000013; // nop
        rom[5]  = 32'h00000013; // nop
        rom[6]  = 32'h00000013; // nop
        rom[7]  = 32'h00000013; // nop
        rom[8]  = 32'h00000013; // nop
        rom[9]  = 32'h00000013; // nop
        rom[10] = 32'h00000013; // nop
        rom[11] = 32'h00000013; // nop
        rom[12] = 32'h00000013; // nop
        rom[13] = 32'h00000013; // nop
        rom[14] = 32'h00000013; // nop
        rom[15] = 32'h00000013; // nop
    end

    always @(*) begin
        if (rest)
            instruction = 32'h00000013;
        else if (pc[31:2] < 32'd64)
            instruction = rom[pc[31:2]];
        else
            instruction = 32'h00000013;
    end

endmodule
