// AstroTinker Bot : Task 2B : RISC-V CPU
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is the top-level verilog design for RISC-V CPU Implementation

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

// t2b_riscv_cpu module declaration
module t2b_riscv_cpu (
    input clk, reset,
    input Ext_MemWrite,
    input [31:0] Ext_WriteData, Ext_DataAdr,
    output MemWrite,
    output [31:0] WriteData, DataAdr, ReadData
);

// wire lines from other modules
wire [31:0] PC, Instr;
wire MemWrite_rv32;
wire [31:0] DataAdr_rv32, WriteData_rv32;

// instantiate processor and memories
riscv_cpu rvsingle (clk, reset, PC, Instr, MemWrite_rv32, DataAdr_rv32, WriteData_rv32, ReadData);
instr_mem imem (PC, Instr);
data_mem dmem (clk, MemWrite, DataAdr, WriteData, ReadData);

// output assignments
assign MemWrite = (Ext_MemWrite && reset) ? 1 : MemWrite_rv32;
assign WriteData = (Ext_MemWrite && reset) ? Ext_WriteData : WriteData_rv32;
assign DataAdr = (reset) ? Ext_DataAdr : DataAdr_rv32;

endmodule

