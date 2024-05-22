/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan
▪ * Filename: alu_decoder 
▪ * Theme: Astro Tinker Bot 
▪ * Functions:alu_decoder 
▪ * Global Variables: None
▪ */

// alu_decoder.v - logic for ALU decoder

module alu_decoder (
    input            opb5,
    input [2:0]      funct3,
    input            funct7b5,
    input [1:0]      ALUOp,
    output reg [3:0] ALUControl
);

always @(*) begin
    case (ALUOp)
        2'b00: begin
            if(funct3==010 | funct3== 000) begin
                ALUControl = 4'b1001; // sb and sw
					 end
                 ALUControl = 4'b0000;    // addition
					  end
        2'b01: begin 
            case (funct3) 
            3'b110: ALUControl = 4'b0101; 
            3'b101: ALUControl = 4'b1101;
            3'b100: ALUControl = 4'b1101;
             //  B-Type
             3'b000: ALUControl = 4'b0001; 
             3'b001: ALUControl = 4'b0001;
            endcase
        end          // subtraction
			default:
            case (funct3) // R-type or I-type ALU
                3'b000: begin
                    // True for R-type subtract
                    if   (funct7b5 & opb5) ALUControl = 4'b0001; //sub  
                    else ALUControl = 4'b0000; // add, addi
                end
                3'b001:  ALUControl = 4'b0100; //sll, slli
                3'b010:  ALUControl = 4'b0101; // slt, slti
                3'b011:  ALUControl = 4'b0101; // sltu, sltiu (doubtful)
                3'b100:  ALUControl = 4'b0110; // xor, xori
                3'b101: begin
                    if (funct7b5) ALUControl = 4'b1000; // srl, srli (we have exchanged both alucontrol bits)
                    else ALUControl = 4'b0111;          // sra, srai
                end
                3'b110:  ALUControl = 4'b0011; // or, ori
                3'b111:  ALUControl = 4'b0010; // and, andi
                default: ALUControl = 4'bxxxx; // ???

            endcase
    endcase
end

endmodule
