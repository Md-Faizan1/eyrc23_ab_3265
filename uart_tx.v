/* 
▪ * Team Id: 3265
▪ * Author List:Sudhanshu Ranjan
▪ * Filename: controller
▪ * Theme: Astro Tinker Bot 
▪ * Functions: controller
▪ * Global Variables: None
▪ */


/*
Input:  clk_50M - 50 MHz clock
        data    - 8-bit data line to transmit
Output: tx      - UART Transmission Line
*/

// module declaration
module uart_tx(
    input  clk_50M,
    input  [7:0] data,
    output reg tx,
    output reg data_sent,          // used for handshaking with the identify fault module
    input  start_rcv              // used for handshaking with the identify fault module
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////


		
	 localparam CLKS_PER_BIT	  = 434;
	 
    localparam IDLE_STATE       = 2'b00;
    localparam START_STATE      = 2'b01;
    localparam SEND_BIT_STATE   = 2'b10;
    localparam STOP_STATE       = 2'b11;

    reg [1:0] state             = 0;
    reg [15:0] counter          = 0;
    reg [2:0] bit_index         = 0;
    reg [7:0] data_byte         = 0;
    

 
	initial begin
	 tx = 0;
    data_sent =0;
	 
   end 

	 
	 always @(posedge clk_50M)
		begin
			case (state)
			
				IDLE_STATE :
					begin

                     data_sent <= 0;
						if (start_rcv == 0)        // only recive data when start_rcv signal is high
							begin
								
										tx 		<= 1;
										counter	<= 0;
										bit_index<= 0;
										state		<= IDLE_STATE;
									
							end
						else
							begin
							tx 		<= 0;
							counter	<= 0;
							bit_index<= 0;
							state		<= START_STATE;
							end
					end
					
				START_STATE :            // send start bit
					begin
						tx 		<= 0;
									if (counter < (CLKS_PER_BIT-2))
										begin
										counter <= counter + 16'b1;
										state <= START_STATE;
										end
									else
										begin
										counter <= 0;
										state <= SEND_BIT_STATE;
										end
                end
					
					
				SEND_BIT_STATE :             // send the data
               begin
                  tx <= data[bit_index];

                  if (counter < CLKS_PER_BIT-1)
                     begin
                     counter <= counter + 16'b1;
                     state   <= SEND_BIT_STATE;
                     end
                  else
                     begin
                        counter <= 0;
                        //Check if we have sent out all bits
                        if (bit_index < 7)
                           begin
                           bit_index   <= bit_index + 3'b1;
                           state       <= SEND_BIT_STATE;
                           end
                        else
                           begin
                           bit_index <= 0;
                           state     <= STOP_STATE;
                           end
                     end
               end
						
						
					// Send Stop bit
               STOP_STATE :
                  begin
						
                  tx <= 1;
                  // Wait CLKS_PER_BIT-1 clock cycles for Stop bit to finish
                  if (counter < (CLKS_PER_BIT-1))
							begin
							counter <= counter + 16'b1;
							state   <= STOP_STATE;
							end
						
                  else
                     begin
                        data_sent <= 1;
                     state   <= IDLE_STATE;
                     end
                  end

                  default :
                     state <= IDLE_STATE;

          endcase

           if(data==0) begin                //  make sure tx is high hen the data is zero
               tx<= 1;
           end
           
		
          
         end

////////// Add your code here ///////////////////

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule