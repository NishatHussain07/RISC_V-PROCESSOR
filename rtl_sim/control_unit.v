module control_unit(input clk,input[6:0] func7, input[2:0] func3, input[6:0] opcode, output reg[5:0] control_out,
         input result, output reg beq, bneq, blt, bgt, bltu, bgeu, jal, jalr, input[31:0] instruction, output reg[31:0] jump_inst  );

        reg beq_control,  bneq_control, blt_control, bgt_control, bltu_control, bgeu_control;
            // ---------------- R-TYPE ----------------
            parameter ADD   = 6'b000000;
            parameter SUB   = 6'b000001;
            parameter SLL   = 6'b000010;
            parameter SLTU  = 6'b000100;
            parameter XOR   = 6'b000101;
            parameter SRL   = 6'b000110;
            parameter SRA   = 6'b000111;
            parameter OR    = 6'b001000;
            parameter AND   = 6'b001001;

            // ---------------- I-TYPE ----------------
            parameter ADDI  = 6'b001010;
            parameter SLTI  = 6'b001011;
            parameter SLTIU = 6'b001100;
            parameter XORI  = 6'b001101;
            parameter ORI   = 6'b001110;
            parameter ANDI  = 6'b001111;
            parameter SLLI  = 6'b010000;
            parameter SRLI  = 6'b010001;
            parameter SRAI  = 6'b010010;

            // ---------------- LOAD ----------------
            parameter LB    = 6'b010011;
            parameter LH    = 6'b010100;
            parameter LW    = 6'b010101;
            parameter LBU   = 6'b010110;
            parameter LHU   = 6'b010111;

            // ---------------- STORE ----------------
            parameter SB    = 6'b011000;
            parameter SH    = 6'b011001;
            parameter SW    = 6'b011010;

            // ---------------- BRANCH ----------------
            parameter BEQ   = 6'b011011;
            parameter BNE   = 6'b011100;
            parameter BLT   = 6'b011101;
            parameter BGE   = 6'b011110;
            parameter BLTU  = 6'b011111;
            parameter BGEU  = 6'b100000;

            // ---------------- U-TYPE ----------------
            parameter LUI   = 6'b100001;
            parameter AUIPC = 6'b100010;

            // ---------------- J-TYPE ----------------
            parameter JAL   = 6'b100011;
            parameter JALR  = 6'b100100;

            // ---------------- SYSTEM ----------------
            parameter ECALL = 6'b100101;
            parameter EBREAK= 6'b100110;

        always@(posedge clk)
         begin
          case({func7, func3, opcode})
         17'b0000000_000_0110011: control_out <= ADD;
        17'b0100000_000_0110011: control_out <= SUB;
        17'b0000000_001_0110011: control_out <= SLL;
        17'b0000000_011_0110011: control_out <= SLTU;
        17'b0000000_100_0110011: control_out <= XOR;
        17'b0000000_101_0110011: control_out <= SRL;
        17'b0100000_101_0110011: control_out <= SRA;
        17'b0000000_110_0110011: control_out <= OR;
        17'b0000000_111_0110011: control_out <= AND;

        // I-Type instructions

        endcase

         end

  always@(posedge clk)
  begin
  case({func3, opcode})

10'b000_0010011: control_out <= ADDI;
10'b010_0010011: control_out <= SLTI;
10'b011_0010011: control_out <= SLTIU;
10'b100_0010011: control_out <= XORI;
10'b110_0010011: control_out <= ORI;
10'b111_0010011: control_out <= ANDI;
10'b001_0010011: control_out <= SLLI;
10'b101_0010011: control_out <= SRLI;


  endcase
  end

  always@(posedge  clk) begin
  case({func3, opcode})

  10'b000_1100011: begin control_out <= BEQ;
                         beq_control <= 1'b1;
  end

    10'b001_1100011: begin control_out <= BNE;
                        bneq_control <= 1'b1;
                        beq_control <= 1'b0;

     end
    10'b100_1100011: begin control_out <= BLT;
                blt_control <= 1'b1;
                bneq_control <= 1'b0;
    end
    10'b101_1100011: begin control_out <= BGE;
                    bgt_control <= 1'b1;
                    blt_control <= 1'b0;
    end
    10'b110_1100011:  begin control_out <= BLTU;
                           bltu_control <= 1'b1;
                           bgt_control <= 1'b0;
    end
    10'b111_1100011: begin control_out <= BGEU;
                 bgeu_control <= 1'b1;
                 bltu_control <= 1'b0;
                 end
  endcase
  end
  always@(posedge clk) begin
  if(opcode == 17'b1100011) begin
  if(result && beq_control)
    beq <= 1'b1;
    else
    beq <= 1'b0;

  if(result && bneq_control)
    bneq <= 1'b1;
    else
    bneq <= 1'b0;

    if(result && blt_control)
    blt <= 1'b1;
    else
    blt <= 1'b0;

  if(result && bgt_control)
    bgt <= 1'b1;
    else
    bgt <= 1'b0;



  if(result && bltu_control)
    bltu <= 1'b1;
    else
    bltu <= 1'b0;

if(result && bgeu_control)
    bgeu <= 1'b1;
    else
    bgeu <= 1'b0;
end
end
//J_ TYPE
always@(posedge clk) begin
case({opcode})
7'b1101111:begin control_out <= JAL;
  jal <= 1'b1;
  jalr <= 1'b0;
  jump_inst <= {{11{instruction[31]}}, instruction[31],instruction[19:12],instruction[20], instruction[30:21], 1'b0};

 end
7'b1100111: begin  control_out <= JALR;
    jal <= 1'b0;
    jalr <= 1'b1;
   jump_inst <=  {{20{instruction[31]}},
    instruction[31:20]};
end


endcase

end
endmodule
