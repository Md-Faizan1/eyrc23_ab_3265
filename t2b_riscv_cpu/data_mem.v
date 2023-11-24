
// data_mem.v - data memory for single-cycle RISC-V CPU

 module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
     input       clk, wr_en,
     input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
     output [DATA_WIDTH-1:0] rd_data_mem,
	  input			[2:0] funct
 );

 // array of 64 32-bit words or data
 
 reg [31:0] data_ram [0:63] ;
 
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
 assign rd_data_mem = data_ram[wr_addr[31:2] % 64];







//assign y = (a == b) ? 1'b1 : 1'b0;


//	assign rd_data_mem = (funct == 3'b000) ?  ( ((wr_addr % 4) == 0) ? ((data_ram[wr_addr[31:2] % 64] & {24'b0, 8'b1})): (  ((wr_addr%4)==1) ?(  ((data_ram[wr_addr[31:2] % 64] & {16'b0,8'b1,8'b0})>>8)   ): ( ((wr_addr%4)==2)? (((data_ram[wr_addr[31:2] % 64] & {8'b0,8'b1,16'b0}))>>16):((data_ram[wr_addr[31:2] % 64] & {8'b1, 24'b0})>>24)   )   )    )  :  ((funct == 3'b100) ?  ( ((wr_addr % 4) == 0) ? ((data_ram[wr_addr[31:2] % 64] & {24'b0, 8'b1})): (  ((wr_addr%4)==1) ?(  ((data_ram[wr_addr[31:2] % 64] & {16'b0,8'b1,8'b0})>>8)   ): ( ((wr_addr%4)==2)? (((data_ram[wr_addr[31:2] % 64] & {8'b0,8'b1,16'b0}))>>16):((data_ram[wr_addr[31:2] % 64] & {8'b1, 24'b0})>>24)   )   )    ) :  ((data_ram[wr_addr[31:2] % 64]) ))  ;

//   assign rd_data_mem =(funct == 3'b010) ?  ((data_ram[wr_addr[31:2] % 64]) ) :  ((rd_data_mem) & (32'b1) )  ;

//   assign rd_data_mem =(funct == 3'b100) ?  ( ((wr_addr % 4) == 0) ? ((data_ram[wr_addr[31:2] % 64] & {24'b0, 8'b1})): (  ((wr_addr%4)==1) ?(  ((data_ram[wr_addr[31:2] % 64] & {16'b0,8'b1,8'b0})>>8)   ): ( ((wr_addr%4)==2)? (((data_ram[wr_addr[31:2] % 64] & {8'b0,8'b1,16'b0}))>>16):((data_ram[wr_addr[31:2] % 64] & {8'b1, 24'b0})>>24)   )   )    ) :  ((rd_data_mem) & (32'b1) )  ;




//	   assign rd_data_mem[7:0] = data_ram[wr_addr[31:0] % 64][7:0];
//		assign rd_data_mem[15:8] = data_ram[wr_addr[31:0] % 64][15:8];
//		assign rd_data_mem[23:16] = data_ram[wr_addr[31:0] % 64][23:16];
//		assign rd_data_mem[31:24] = data_ram[wr_addr[31:0] % 64][31:24];
//	
// always @(*) begin
//     if (funct == 3'b000) begin
//         if ((wr_addr % 4) == 0)
//             rd_data_mem = (data_ram[wr_addr[31:2] % 64] & {24'b0, wr_data[7:0]});
//         else if ((wr_addr % 4) == 1)
//             rd_data_mem = ((data_ram[wr_addr[31:2] % 64] & {16'b0, wr_data[7:0], 8'b0})>>8);
//         else if ((wr_addr % 4) == 2)
//             rd_data_mem = ((data_ram[wr_addr[31:2] % 64] & {8'b0, wr_data[7:0], 16'b0})>>16);
//         else if ((wr_addr % 4) == 3)
//             rd_data_mem = ((data_ram[wr_addr[31:2] % 64] & {wr_data[7:0], 24'b0})>>24);
//     end
//     else begin
//         rd_data_mem = data_ram[wr_addr[31:2] % 64];
//     end
// end

	
	
 // synchronous write logic
 always @(posedge clk) begin
	if(funct==3'b000) begin
		
		if((wr_addr%4)==0)
			     if (wr_en) data_ram[wr_addr[31:2] % 64] <= (data_ram[wr_addr[31:2] % 64] | {24'b0,wr_data[7:0]});
		if((wr_addr%4)==1)
			     if (wr_en) data_ram[wr_addr[31:2] % 64] <= (data_ram[wr_addr[31:2] % 64] | {16'b0,wr_data[7:0],8'b0});
		if((wr_addr%4)==2)
			     if (wr_en) data_ram[wr_addr[31:2] % 64] <= (data_ram[wr_addr[31:2] % 64] | {8'b0,wr_data[7:0],16'b0});
		if((wr_addr%4)==3)
			     if (wr_en) data_ram[wr_addr[31:2] % 64] <= (data_ram[wr_addr[31:2] % 64] | {wr_data[7:0],24'b0});
		
end
		
	  else begin
	     if (wr_en) data_ram[wr_addr[31:2] % 64] <= wr_data[31:0]; 
    end
 end

 endmodule




// data_mem.v - data memory for single-cycle RISC-V CPU

// data_mem.v - data memory for single-cycle RISC-V CPU

// data_mem.v - data memory for single-cycle RISC-V CPU

// data_mem.v - data memory for single-cycle RISC-V CPU

 // data_mem.v - data memory for single-cycle RISC-V CPU

//module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
//    input       clk, wr_en,
//    input       [ADDR_WIDTH-1:0] wr_addr,
//    input       [DATA_WIDTH-1:0] wr_data,
//    output reg  [DATA_WIDTH-1:0] rd_data_mem
//);
//
//// array of 64 32-bit words or data
//reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];
//
//// wire for combinational read logic
//// word-aligned memory access
//wire [DATA_WIDTH-1:0] rd_data_wire;
//assign rd_data_wire = data_ram[wr_addr[DATA_WIDTH-1:0] % MEM_SIZE];
//
//// synchronous write logic
//always @(posedge clk) begin
//    if (wr_en) data_ram[wr_addr[DATA_WIDTH-1:0] % MEM_SIZE] <= wr_data;
//end
//
//// reg for storing the wire value
//always @* begin
//    rd_data_mem = rd_data_wire;
//end
//
//endmodule

// data_mem.v - data memory for single-cycle RISC-V CPU












