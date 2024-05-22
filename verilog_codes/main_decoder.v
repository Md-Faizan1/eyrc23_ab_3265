/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan, Sumit Saroj
▪ * Filename: main_decoder
▪ * Theme: Astro Tinker Bot 
▪ * Functions: main_decoder
▪ * Global Variables: None
▪ */

// main_decoder.v - logic for main decoder

module main_decoder (
    input  [6:0] op,
    input  [2:0] funct3,
    output [1:0] ResultSrc,
    output       MemWrite, Branch,
    input        ALUR0,
    output       ALUSrc,
    output       RegWrite,
    input         Zero,
    output        Jump, Jalr,
    output reg   Take_Branch,
    output [1:0] ImmSrc,
    output [1:0] ALUOp, Store,
    output [2:0] Load
);

reg [16:0] controls;

always @(*) begin
    case (op)
        // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump_Store_Load_Jalr
        7'b0000011: begin
                        case (funct3)
                        3'b000: controls = 17'b1_00_1_0_01_0_00_0_00_000_0; // lb
                        3'b001: controls = 17'b1_00_1_0_01_0_00_0_00_001_0; // lh
                        3'b010: controls = 17'b1_00_1_0_01_0_00_0_00_010_0; // lw
                        3'b100: controls = 17'b1_00_1_0_01_0_00_0_00_011_0; // lbu
                        3'b101: controls = 17'b1_00_1_0_01_0_00_0_00_100_0; // lhu
                        endcase
                    end
        7'b0100011: begin
                        case (funct3)
                        3'b000: controls = 17'b0_01_1_1_00_0_00_0_00_000_0; // sb
                        3'b001: controls = 17'b0_01_1_1_00_0_00_0_01_000_0; // sh
                        3'b010: controls = 17'b0_01_1_1_00_0_00_0_10_000_0; // sw
                        endcase
                    end
        7'b0110011: controls = 17'b1_xx_0_0_00_0_10_0_00_010_0; // R–type
        7'b1100011: controls = 17'b0_10_0_0_00_1_01_0_00_010_0; // B-type
        7'b0010011: controls = 17'b1_00_1_0_00_0_10_0_00_010_0; // I–type ALU
        7'b1100111: controls = 17'b1_00_1_0_10_0_00_0_00_010_1; // jalr
        7'b1101111: controls = 17'b1_11_0_0_10_0_00_1_00_010_0; // jal
        7'b0010111: controls = 17'b1_xx_1_0_11_0_00_0_00_010_0; // auipc
        7'b0110111: controls = 17'b1_xx_x_0_11_0_00_0_00_010_0; // lui
        default:    controls = 17'bx_xx_x_x_xx_x_xx_x_xx_xxx_x; // ???
    endcase

    Take_Branch = 0;
    if (Branch) begin               //  For Branch and jump instructions
        case (funct3)
            3'b000:  Take_Branch = Zero;
            3'b001:  Take_Branch = !Zero;
            3'b100:  Take_Branch = Zero;
            3'b101:  Take_Branch = !Zero;
			3'b110:  Take_Branch = ALUR0;
			3'b111:  Take_Branch = !ALUR0;
            default: Take_Branch = 0;
        endcase
    end

end

assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump, Store, Load, Jalr} = controls;

endmodule
