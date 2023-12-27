
// data_mem.v - data memory for single-cycle RISC-V CPU

// module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
//     input       clk, wr_en,
//     input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
//     output      [DATA_WIDTH-1:0] rd_data_mem
// );

// // array of 64 32-bit words or data
// reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];

// // combinational read logic
// // word-aligned memory access
// assign rd_data_mem = data_ram[wr_addr[DATA_WIDTH-1:0] % 64];

// // synchronous write logic
// always @(posedge clk) begin
//     if (wr_en) data_ram[wr_addr[DATA_WIDTH-25:0] % 64] <= wr_data[7:0];
//      if (wr_en) data_ram[wr_addr[DATA_WIDTH-17:8] % 64] <= wr_data[15:8];
//       if (wr_en) data_ram[wr_addr[DATA_WIDTH-9:16] % 64] <= wr_data[23:16];
//        if (wr_en) data_ram[wr_addr[DATA_WIDTH-1:24] % 64] <= wr_data[31:24];
// end

// endmodule

// 2 ---------------------------------------------------------------------------------------


// data_mem.v - data memory for single-cycle RISC-V CPU

module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
    input       clk, wr_en,
    input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
    output      [DATA_WIDTH-1:0] rd_data_mem
);

// array of 64 32-bit words or data
reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];


 initial begin
    data_ram[0]  = 32'b0;
    data_ram[1]  = 32'b0;
    data_ram[2]  = 32'b0;
    data_ram[3]  = 32'b0;
    data_ram[4]  = 32'b0;
    data_ram[5]  = 32'b0;
    data_ram[6]  = 32'b0;
    data_ram[7]  = 32'b0;
    data_ram[8]  = 32'b0;
    data_ram[9]  = 32'b0;
    data_ram[10] = 32'b0;
    data_ram[11] = 32'b0;
    data_ram[12] = 32'b0;
    data_ram[13] = 32'b0;
    data_ram[14] = 32'b0;
    data_ram[15] = 32'b0;
    data_ram[16] = 32'b0;
    data_ram[17] = 32'b0;
    data_ram[18] = 32'b0;
    data_ram[19] = 32'b0;
    data_ram[20] = 32'b0;
    data_ram[21] = 32'b0;
    data_ram[22] = 32'b0;
    data_ram[23] = 32'b0;
    data_ram[24] = 32'b0;
    data_ram[25] = 32'b0;
    data_ram[26] = 32'b0;
    data_ram[27] = 32'b0;
    data_ram[28] = 32'b0;
    data_ram[29] = 32'b0;
    data_ram[30] = 32'b0;
    data_ram[31] = 32'b0;
    data_ram[32] = 32'b0;
    data_ram[33] = 32'b0;
    data_ram[34] = 32'b0;
    data_ram[35] = 32'b0;
    data_ram[36] = 32'b0;
    data_ram[37] = 32'b0;
    data_ram[38] = 32'b0;
    data_ram[39] = 32'b0;
    data_ram[40] = 32'b0;
    data_ram[41] = 32'b0;
    data_ram[42] = 32'b0;
    data_ram[43] = 32'b0;
    data_ram[44] = 32'b0;
    data_ram[45] = 32'b0;
    data_ram[46] = 32'b0;
    data_ram[47] = 32'b0;
    data_ram[48] = 32'b0;
    data_ram[49] = 32'b0;
    data_ram[50] = 32'b0;
    data_ram[51] = 32'b0;
    data_ram[52] = 32'b0;
    data_ram[53] = 32'b0;
    data_ram[54] = 32'b0;
    data_ram[55] = 32'b0;
    data_ram[56] = 32'b0;
    data_ram[57] = 32'b0;
    data_ram[58] = 32'b0;
    data_ram[59] = 32'b0;
    data_ram[60] = 32'b0;
    data_ram[61] = 32'b0;
    data_ram[62] = 32'b0;
    data_ram[63] = 32'b0;
end
// combinational read logic
// word-aligned memory access
assign rd_data_mem[31:0] = data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE];


// synchronous write logic
always @(posedge clk) begin
    if(wr_en) begin
        if (wr_addr%4 == 0)
            data_ram[wr_addr[DATA_WIDTH-1:2] % 64] <= (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] | (wr_data[31:0]));
        else if (wr_addr%4 == 1)
            data_ram[wr_addr[DATA_WIDTH-1:2] % 64] <= (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] | (wr_data[31:0] << 8));
        else if (wr_addr%4 ==2)
            data_ram[wr_addr[DATA_WIDTH-1:2] % 64] <= (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] | (wr_data[31:0] << 16));
        else
            data_ram[wr_addr[DATA_WIDTH-1:2] % 64] <= (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] | (wr_data[31:0] << 24));
        // data_ram[wr_addr[DATA_WIDTH-1:2] % 64] <= wr_data[31:0];
        

end
end

endmodule

