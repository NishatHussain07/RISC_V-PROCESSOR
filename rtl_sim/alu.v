module ALU(input clk, rest, input[5:0] control_out, input[11:0] immediate, input[4:0] rs1, rs2, rd, output reg[31:0] result, input[31:0] pc/* output reg beq, bneq, blt, bgt, bltu, bgeu*/);

reg[31:0] memory[0:31];
integer i;
always@(posedge clk)
if(rest) begin
for(i = 0; i <= 31; i = i + 1) begin
    memory[i] <= i;
   /* beq <= 0;
    bneq <=0;
    blt <= 0;
     bgt <= 0;
      bltu <= 0; bgeu <= 0;*/
      result <= 0;



    end
end
/*always@(clk)*/
 else begin
 case(control_out)
6'b000000: memory[rd] = memory[rs1] + memory[rs2];  // ADD
6'b000001: memory[rd] = memory[rs1] - memory[rs2];  // SUB
6'b000010: memory[rd] = memory[rs1] << memory[rs2][4:0]; // SLL
6'b000011: memory[rd] = ($signed(memory[rs1]) < $signed(memory[rs2])) ? 1 : 0; // SLT
6'b000100: memory[rd] = (memory[rs1] < memory[rs2]) ? 1 : 0; // SLTU
6'b000101: memory[rd] = memory[rs1] ^ memory[rs2];  // XOR
6'b000110: memory[rd] = memory[rs1] >> memory[rs2][4:0]; // SRL
6'b000111: memory[rd] = $signed(memory[rs1]) >>> memory[rs2][4:0]; // SRA
6'b001000: memory[rd] = memory[rs1] | memory[rs2];  // OR
6'b001001: memory[rd] = memory[rs1] & memory[rs2];  // AND

//========================================================
// I-TYPE
//========================================================

6'b001010: memory[rd] = memory[rs1] + immediate; // ADDI

6'b001011: memory[rd] =
             ($signed(memory[rs1]) < $signed(immediate)) ? 1 : 0; // SLTI

6'b001100: memory[rd] =
             (memory[rs1] < immediate) ? 1 : 0; // SLTIU

6'b001101: memory[rd] = memory[rs1] ^ immediate; // XORI

6'b001110: memory[rd] = memory[rs1] | immediate; // ORI

6'b001111: memory[rd] = memory[rs1] & immediate; // ANDI

6'b010000: memory[rd] = memory[rs1] << immediate[4:0]; // SLLI

6'b010001: memory[rd] = memory[rs1] >> immediate[4:0]; // SRLI

6'b010010: memory[rd] = $signed(memory[rs1]) >>> immediate[4:0]; // SRAI


 6'b011011: begin
   if(memory[rs1] == memory[rs2])
  result = 1'b1;
    else
    result = 1'b0;
 end
6'b011100: begin
   if(memory[rs1] != memory[rs2])
    result = 1'b1;
    else
     result = 1'b0;
  end
6'b011101:  begin
   if($signed(memory[rs1]) < $signed(memory[rs2]))
    result = 1'b1;
    else
    result = 1'b0;

 end
6'b011110: begin
if($signed(memory[rs1])  > $signed(memory[rs2]))
   result = 1'b1;
     else
    result = 1'b0;
end
6'b011111: begin
if (memory[rs1] < memory[rs2])
    result = 1'b1;
     else
    result = 1'b0;
end
6'b100000: begin
    if (memory[rs1] >= memory[rs2])
        result = 1'b1;
         else
   result = 1'b0;
end

/* 6'b100011;
            parameter JALR  = 6'b100100;*/

 6'b100011: begin
  memory[rd] <= pc + 4;

  end

6'b100100: begin

    memory[rd] <= pc + 4;
end

 endcase
 end

always@(*)
  result = memory[rd];

endmodule
