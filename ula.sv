
// ula.sv
module ula (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [1:0] OP,
    output logic [7:0] Result
);

    always_comb begin
        case (OP)
            2'b00: Result = A + B;       // Soma
            2'b01: Result = A - B;       // Subtra??o
            2'b10: Result = A & B;       // AND bit a bit
            2'b11: Result = A | B;       // OR bit a bit
            default: Result = 8'b0;
        endcase
    end

endmodule
