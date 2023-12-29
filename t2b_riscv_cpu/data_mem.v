
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
// reg [5:0] s_b = 6'b0;
// reg [31:0] bits = {24'b0,8'b1};
// always @(posedge clk) begin


//  s_b = ( (wr_addr % 4) * 1'd8); 

//  bits = bits << s_b;
// end

// assign rd_data_mem[31:0] = (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] & bits) >> s_b;

//  reg [31:0] temp_data;

// always @(posedge clk) begin
//     case (wr_addr % 4)
//         0: temp_data = (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] & {24'b0, 8'b1});
//         1: temp_data = (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] & {16'b0, 8'b1, 8'b0}) >> 8;
//         2: temp_data = (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] & {8'b0, 8'b1, 16'b0}) >> 16;
//         3: temp_data = (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] & {8'b1, 24'b0}) >> 24;
//     endcase
// end

// always @(posedge clk) begin
//     case (wr_addr % 4)
//         0: temp_data[31:0] <= (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] & 127);
//         1: temp_data[31:0] <= ((data_ram[wr_addr[DATA_WIDTH-1:2] % 64] >> 8) & 65280);
//         2: temp_data[31:0] <= ((data_ram[wr_addr[DATA_WIDTH-1:2] % 64] >> 16) & 16711680);
//         3: temp_data[31:0] <= ((data_ram[wr_addr[DATA_WIDTH-1:2] % 64] >> 24) & 4278190080);
//     endcase
// end

// assign rd_data_mem[31:0] = temp_data[31:0];





assign rd_data_mem[31:0] = (((wr_addr%4 == 0) ? (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] & 127) : ((wr_addr%4 == 1) ? (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] & 65280)>> 8 : ((wr_addr%4 == 2) ? (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] & 16711680) >> 16 : (data_ram[wr_addr[DATA_WIDTH-1:2] % 64] & 4278190080) >> 24))));




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

