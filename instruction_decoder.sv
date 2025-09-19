// instruction_decoder.sv - Decodificador básico de instruções RISC-V RV32I

module instruction_decoder (
    input  logic [31:0] instruction,
    output logic [6:0]  opcode,
    output logic [4:0]  rd,
    output logic [4:0]  rs1,
    output logic [4:0]  rs2,
    output logic [2:0]  funct3,
    output logic [6:0]  funct7,
    output logic [31:0] imm,          // Immediato estendido com sinal
    output logic        is_alu_imm,   // Instrução do tipo I (ADDI, XORI, etc.)
    output logic        is_alu_reg,   // Instrução do tipo R (ADD, SUB, AND, etc.)
    output logic        is_load,      // LW, LH, LB, etc.
    output logic        is_store,     // SW, SH, SB
    output logic        is_branch,    // BEQ, BNE, etc.
    output logic        is_jal,       // JAL
    output logic        is_jalr,      // JALR
    output logic        is_lui_auipc, // LUI ou AUIPC
    output logic [3:0]  alu_op        // Código da operação ALU: 0=ADD, 1=SUB, 2=AND, 3=OR, 4=XOR, 5=SLT, 6=SLL, 7=SRL, 8=SRA
);

// Decodifica campos básicos
assign opcode = instruction[6:0];
assign rd     = instruction[11:7];
assign rs1    = instruction[19:15];
assign rs2    = instruction[24:20];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];

// Decodifica imediato (depende do tipo)
always_comb begin
    imm = 32'b0;
    case (opcode)
        7'b0010011: // I-type (ADDI, XORI, etc.)
            imm = {{20{instruction[31]}}, instruction[31:20]}; // sign-extended
        7'b0000011: // Load (LW, LB, etc.)
            imm = {{20{instruction[31]}}, instruction[31:20]};
        7'b0100011: // Store (SW, SB, etc.)
            imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        7'b1100011: // Branch (BEQ, BNE, etc.)
            imm = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        7'b1101111: // JAL
            imm = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
        7'b1100111: // JALR
            imm = {{20{instruction[31]}}, instruction[31:20]};
        7'b0110111, // LUI
        7'b0010111: // AUIPC
            imm = {instruction[31:12], 12'b0};
        default:
            imm = 32'b0;
    endcase
end

// Identifica tipo de instrução
assign is_alu_imm   = (opcode == 7'b0010011); // ADDI, ANDI, ORI, XORI, SLTI, SLTIU, SLLI, SRLI, SRAI
assign is_alu_reg   = (opcode == 7'b0110011); // ADD, SUB, AND, OR, XOR, SLT, SLTU, SLL, SRL, SRA
assign is_load      = (opcode == 7'b0000011); // LW, LH, LB, LHU, LBU
assign is_store     = (opcode == 7'b0100011); // SW, SH, SB
assign is_branch    = (opcode == 7'b1100011); // BEQ, BNE, BLT, BGE, BLTU, BGEU
assign is_jal       = (opcode == 7'b1101111); // JAL
assign is_jalr      = (opcode == 7'b1100111); // JALR
assign is_lui_auipc = (opcode == 7'b0110111) || (opcode == 7'b0010111); // LUI, AUIPC

// Decodifica operação da ALU com base em funct3 e funct7
always_comb begin
    alu_op = 4'b0000; // padrão = ADD
    if (is_alu_reg) begin
        case (funct3)
            3'b000: alu_op = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000; // SUB ou ADD
            3'b111: alu_op = 4'b0010; // AND
            3'b110: alu_op = 4'b0011; // OR
            3'b100: alu_op = 4'b0100; // XOR
            3'b010: alu_op = 4'b0101; // SLT
            3'b001: alu_op = 4'b0110; // SLL
            3'b101: alu_op = (funct7 == 7'b0100000) ? 4'b1000 : 4'b0111; // SRA ou SRL
            default: alu_op = 4'b0000;
        endcase
    end else if (is_alu_imm) begin
        case (funct3)
            3'b000: alu_op = 4'b0000; // ADDI
            3'b111: alu_op = 4'b0010; // ANDI
            3'b110: alu_op = 4'b0011; // ORI
            3'b100: alu_op = 4'b0100; // XORI
            3'b010: alu_op = 4'b0101; // SLTI
            3'b001: alu_op = 4'b0110; // SLLI
            3'b101: alu_op = (instruction[30] == 1'b1) ? 4'b1000 : 4'b0111; // SRAI ou SRLI
            default: alu_op = 4'b0000;
        endcase
    end
end

endmodule