/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan, Sudhanshu Ranjan, Sumit Saroj
▪ * Filename: alu 
▪ * Theme: Astro Tinker Bot 
▪ * Functions:  alu 
▪ * Global Variables: None
▪ */

// alu.v - ALU module

module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // operands
    input       [3:0] alu_ctrl,         // ALU control //was 2-bit
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output      zero,   
    output  [31:0] ac , ab                // zero flag
);

always @(a, b, alu_ctrl) begin
    case (alu_ctrl)
        4'b0000: alu_out <= a + b;       // add
        4'b0001: alu_out <= (a + ~b) + 1;  // sub
        4'b0010: alu_out <= a & b;       // and
        4'b0011: alu_out <= a | b;       // or
      4'b1101: alu_out <= ((a >= b) ? 1 : 0);
      // or
        4'b0100: alu_out <= a << b[4:0]; // sll
        4'b0101: begin                   // slt
                    if (a[31] != b[31]) alu_out <= (a[31] ? 0 : 1);
                    else alu_out <= (a < b ? 1 : 0);
                end
        4'b0110: alu_out <= a ^ b;         // xor
        4'b0111: alu_out <= a >> b[4:0];   // srl
     
        4'b1000: alu_out <= a >>> b[4:0];  // sra
//        4'b1001: alu_out <= (a+b);  // sb and sw
        default: alu_out = 0;
    endcase
end
assign ac = a;
assign ab = b;
assign zero = ((alu_out == 0) ? 1'b1 : 1'b0);

endmodule
