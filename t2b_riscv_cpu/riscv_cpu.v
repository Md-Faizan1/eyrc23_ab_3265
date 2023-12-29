
// riscv_cpu.v - single-cycle RISC-V CPU Processor

module riscv_cpu (
    input         clk, reset,
    output [31:0] PC,
    input  [31:0] Instr,
    output        MemWrite,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData
);

wire       ALUSrc, RegWrite, Zero, ALUR31, ALUR0;
wire       PCSrc, Jalr, Jump, Op5;
wire [1:0] ResultSrc, ImmSrc, Store;
wire [3:0] ALUControl;
wire [2:0] Load;

controller  c  (Instr[6:0], Instr[14:12], Instr[30], Zero, ALUR31, ALUR0,
                ResultSrc, MemWrite, PCSrc, Jalr, ALUSrc, RegWrite,
                Op5, ImmSrc, Store, Load, ALUControl);

datapath    dp (clk, reset, ResultSrc, PCSrc, Jalr, ALUSrc, RegWrite,
                Op5, ImmSrc, Store, Load, ALUControl, Zero, ALUR31, ALUR0, PC,
                Instr, Mem_WrAddr, Mem_WrData, ReadData);

endmodule
