/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan
▪ * Filename: controller
▪ * Theme: Astro Tinker Bot 
▪ * Functions: controller
▪ * Global Variables: None
▪ */

//  this module writes start and end points to the CPU memory address

module write_points(
    input adc_sck,
    input [7:0] SP,
    input [7:0] EP,
    output reg reset,
    output reg [31:0] Ext_WriteData,
    output reg [31:0] Ext_DataAdr,
    output reg Ext_MemWrite,
   
    output reg [7:0] point_sp,
    output reg [7:0] point_ep,
    input [31:0] WriteData, DataAdr,

    output reg [4:0] states,
    input  cpu_reset



);

    localparam prepare = 5'b00000;
	localparam write_start = 5'b00001;
	localparam  write_end = 5'b00010;


reg [31:0] counter;


initial begin
    counter = 0;
    states = 0;
    reset = 1;
	
 end

 always @(posedge adc_sck) begin

    reset <= cpu_reset;
    case (states)
        
        prepare : begin            // idle state 
                 
            reset <= 0;
            Ext_MemWrite <= 0;               
			Ext_WriteData <= 0;
            Ext_DataAdr <= 32'h0; 
                if(cpu_reset == 1 ) begin
                    states <= write_start;
                end
                else
                states <= prepare;
        end

        
     

        write_start : begin                // write start point
              Ext_MemWrite <= 1;               
				  Ext_WriteData <= SP;
              Ext_DataAdr <= 32'h02000000; 

            states <= write_end;


        end

        write_end : begin                  // write end point
       
              
              Ext_MemWrite <= 1;               
				  Ext_WriteData <= EP;
              Ext_DataAdr <= 32'h02000004; 

                   states <= prepare;
                    
            end


    endcase

    end
endmodule




