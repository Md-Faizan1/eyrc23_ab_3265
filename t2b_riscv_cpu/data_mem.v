
// data_mem.v - data memory for single-cycle RISC-V CPU

module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
    input       clk, wr_en,
    input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
    output      [DATA_WIDTH-1:0] rd_data_mem
);

// array of 64 32-bit words or data
reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];

// combinational read logic
// word-aligned memory access
assign rd_data_mem = data_ram[wr_addr[DATA_WIDTH-1:0] % 64];

// synchronous write logic
always @(posedge clk) begin
    if (wr_en) data_ram[wr_addr[DATA_WIDTH-25:0] % 64] <= wr_data[7:0];
     if (wr_en) data_ram[wr_addr[DATA_WIDTH-17:8] % 64] <= wr_data[15:8];
      if (wr_en) data_ram[wr_addr[DATA_WIDTH-9:16] % 64] <= wr_data[23:16];
       if (wr_en) data_ram[wr_addr[DATA_WIDTH-1:24] % 64] <= wr_data[31:24];
end

endmodule
