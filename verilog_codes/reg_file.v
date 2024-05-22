/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan
▪ * Filename: reg_file  
▪ * Theme: Astro Tinker Bot 
▪ * Functions: reg_file 
▪ * Global Variables: None
▪ */

// reg_file.v - register file for single-cycle RISC-V CPU
//              (with 32 registers, each of 32 bits)
//              having two read ports, one write port
//              write port is synchronous, read ports are combinational
//              register 0 is hardwired to 0

module reg_file #(parameter DATA_WIDTH = 32) (
    input       adc_sck,reset,
    input       wr_en,
    input       [4:0] rd_addr1, rd_addr2, wr_addr,
    input       [DATA_WIDTH-1:0] wr_data,
    output      [DATA_WIDTH-1:0] rd_data1, rd_data2,
    output      [31:0] write,      // used for testing in signal tap
    output      [4:0] write2       // used for testing in signal tap
);



reg [DATA_WIDTH-1:0] reg_file_arr [0:31];

integer i;
 initial begin
     for (i = 0; i < 32; i = i + 1) begin
         reg_file_arr[i] = 32'b0;
     end
 end

// register file write logic (synchronous)
always @(posedge adc_sck) begin
    if(reset) begin                               //   for making all register zero when reset
        for (i = 0; i < 32; i = i + 1) begin
        reg_file_arr[i] = 32'b0;
    end
    end
    
    if (wr_en && (reset==0)) begin                // only write when when enable is high
         reg_file_arr[wr_addr] <= wr_data;
  

    end
end

// register file read logic (combinational)

assign write = wr_data;                // only for testing in signal tap
assign write2 = rd_addr1;              // only for testing in signal tap

assign rd_data1 = ( rd_addr1 != 0 ) ? reg_file_arr[rd_addr1] : 0;
assign rd_data2 = ( rd_addr2 != 0 ) ? reg_file_arr[rd_addr2] : 0;

endmodule
