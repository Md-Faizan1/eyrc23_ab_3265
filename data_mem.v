/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan
▪ * Filename:  data_mem 
▪ * Theme: Astro Tinker Bot 
▪ * Functions: data_mem 
▪ * Global Variables: None
▪ */


// data_mem.v - data memory for single-cycle RISC-V CPU

module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
    input       adc_sck, wr_en,reset,
    input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
    output      [DATA_WIDTH-1:0] rd_data_mem,
    input       [2:0] funct,
    input       [6:0] funct7,
    // path planned array is stored in path ;
    output  reg [7:0] path0,
    output  reg [7:0] path1, 
    output  reg [7:0] path2,
    output  reg [7:0] path3,
    output  reg [7:0] path4,
    output  reg [7:0] path5,
    output  reg [7:0] path6,
    output  reg [7:0] path7,
    output  reg [7:0] path8,
    output  reg [7:0] path9,
    output  reg [7:0] path10,
    output  reg [7:0] path11,
    output  reg [7:0] path12,
   
    output  reg [7:0] index,
    output reg cpu_done,
	 input cpu_reset
);


integer i;
// array of 64 32-bit words or data
reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];


 initial begin
     for (i = 0; i < 64; i = i + 1) begin
        data_ram[i] = 32'h00000000;               // initializing data ram to zero
    end
end


assign rd_data_mem[31:0] =((funct == 3'b010) ? (data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE]) : (((wr_addr%4 == 0) ? (data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] & {{24{1'b0}},{8{1'b1}}}) : ((wr_addr%4 == 1) ? (data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] & {{16{1'b0}},{8{1'b1}},{8{1'b0}}})>> 8 : ((wr_addr%4 == 2) ? (data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] & {{8{1'b0}},{8{1'b1}},{16{1'b0}}}) >> 16 : (data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] & {{8{1'b1}},{24{1'b0}}}) >> 24)))));

// synchronous write logic
always @(posedge adc_sck) begin
    if(data_ram[3]==1) begin        // cpu done
        
        path0 <= (data_ram[52] & {{24{1'b0}},{8{1'b1}}});
        path1 <= ((data_ram[52] & {{16{1'b0}},{8{1'b1}},{8{1'b0}}})>> 8);    // path planned array
        path2 <= ((data_ram[52] & {{8{1'b0}},{8{1'b1}},{16{1'b0}}}) >>16);
        path3 <= ((data_ram[52]  & {{8{1'b1}},{24{1'b0}}})>>24);
        path4 <= (data_ram[53] & {{24{1'b0}},{8{1'b1}}});
        path5 <= ((data_ram[53] & {{16{1'b0}},{8{1'b1}},{8{1'b0}}})>> 8);
        path6 <= ((data_ram[53] & {{8{1'b0}},{8{1'b1}},{16{1'b0}}}) >>16);
        path7 <= ((data_ram[53]  & {{8{1'b1}},{24{1'b0}}})>>24);
		  path8 <= (data_ram[54] & {{24{1'b0}},{8{1'b1}}});
		  path9 <= ((data_ram[54] & {{16{1'b0}},{8{1'b1}},{8{1'b0}}})>> 8);
		  path10 <= ((data_ram[54] & {{8{1'b0}},{8{1'b1}},{16{1'b0}}}) >>16);
		  path11 <= ((data_ram[54]  & {{8{1'b1}},{24{1'b0}}})>>24);
		  path12 <= (data_ram[55] & {{24{1'b0}},{8{1'b1}}});
		  
  
        index <= ((data_ram[59] & {{8{1'b0}},{8{1'b1}},{16{1'b0}}}) >>16);      // size of path
        cpu_done <= 1;      // indicate when path planning is done 
    end
	 
        if(reset == 1 & cpu_done==1) begin                   // path reset logic 
                cpu_done <= 0;
				path0 <= 0;
				path1 <= 0;
				path2 <= 0;
				path3 <= 0;
				path4 <= 0;
				path5 <= 0;
				path6 <= 0;
				path7 <= 0;
				path8 <= 0;
				path9 <= 0;
				path10 <= 0;
				path11 <= 0;
				path12 <= 0;
            index <= 0;
			end	
end
always @(posedge adc_sck) begin


   if(reset == 1 & cpu_done==1) begin           // reset data ram when rest is high
                     for (i = 0; i < 64; i = i + 1) begin
        data_ram[i] = 32'h00000000;
    end
    end
	 else begin
    if(wr_en) begin
     


        if(funct == 000) begin
   //////     Using Bit Masking logic for writing 4 bytes in a 32 bit block of memory   
        if (wr_addr%4 == 0)
            data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] <= ((data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] & {{24{1'b1}},{8{1'b0}}}) | (wr_data[31:0]));             
        else if (wr_addr%4 == 1)
            data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] <= ((data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] & {{16{1'b1}},{8{1'b0}},{8{1'b1}}}) | (wr_data[31:0] << 8));
        else if (wr_addr%4 ==2)
            data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] <= ((data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] & {{8{1'b1}},{8{1'b0}},{16{1'b1}}}) | (wr_data[31:0] << 16));
        else
            data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] <= ((data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] & {{8{1'b0}},{24{1'b1}}}) | (wr_data[31:0] << 24));
      
        end

        else begin

            data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] <= wr_data;   // for sw instruction
      
        end   

end
end
end

endmodule


