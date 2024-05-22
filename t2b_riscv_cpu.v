// AstroTinker Bot : Task 2B : RISC-V CPU


/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan, Sudhanshu Ranjan, Sumit Saroj
▪ * Filename: t2b_riscv_cpu 
▪ * Theme: Astro Tinker Bot 
▪ * Functions: t2b_riscv_cpu 
▪ * Global Variables: None
▪ */


// t2b_riscv_cpu module declaration
module t2b_riscv_cpu (
    input adc_sck,reset,
    input Ext_MemWrite,
    input [31:0] Ext_WriteData, Ext_DataAdr,
    output MemWrite,
    output [31:0] WriteData, DataAdr, ReadData, Instr,
    output [31:0] WriteData_rv32,
    output [31:0] rdata2,
    output [31:0] write,
	 output [31:0] PC,
    output [31:0] DataAdr_rv32,
    output  [7:0] path0, 
    output  [7:0] path1, 
    output  [7:0] path2,
    output  [7:0] path3,
    output  [7:0] path4,
    output  [7:0] path5,
    output  [7:0] path6,
    output  [7:0] path7,
    output  [7:0] path8,
    output  [7:0] path9,
    output  [7:0] path10,
    output  [7:0] path11,
    output  [7:0] path12,
    output  [7:0] index,
    output cpu_done,
	 input cpu_reset // for resettign start and end points 
 

);


wire MemWrite_rv32;


wire [2:0] funct;
wire [6:0] funct7;
assign funct = Instr[14:12];
assign funct7 = Instr[31:25];

// instantiate processor and memories
riscv_cpu rvsingle (adc_sck, reset, PC, Instr, MemWrite_rv32, DataAdr_rv32, WriteData_rv32, ReadData,rdata2);
instr_mem imem (reset,PC, Instr);
data_mem dmem (adc_sck, MemWrite,reset, DataAdr, WriteData, ReadData, funct, funct7,path0,path1,path2,path3,path4,path5,path6,path7,path8,path9,path10,path11,path12,index,cpu_done,cpu_reset);

// output assignments
assign MemWrite = (Ext_MemWrite && reset) ? 1 : MemWrite_rv32;
assign WriteData = (Ext_MemWrite && reset) ? Ext_WriteData : WriteData_rv32;
assign DataAdr = (reset) ? Ext_DataAdr : DataAdr_rv32;

endmodule

