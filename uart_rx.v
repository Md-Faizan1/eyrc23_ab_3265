/* 
▪ * Team Id: 3265
▪ * Author List: Md Faizan, Sudhanshu Ranjan, Sumit Saroj
▪ * Filename: controller
▪ * Theme: Astro Tinker Bot 
▪ * Functions: controller
▪ * Global Variables: None
▪ */


module uart_rx (
  input clk_50M, i_rx,
  output reg [7:0] o_data_byte,
  

output [7:0] data0,
output [7:0] data1,
output [7:0] data2,
output [7:0] data3,
output [7:0] data4,
output [7:0] data5,
output [7:0] data6,
output [7:0] data7,
output [7:0] data8,
output [7:0] data9,
output [7:0] data10,
output [7:0] data11,
output [7:0] data12,
output [7:0] data13,
output  data_avail_w,
output  start_bot_w
 
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////


localparam CLKS_PER_BIT  = 434;
localparam IDLE_STATE    = 3'b00;
localparam START_STATE   = 3'b01;
localparam GET_BIT_STATE = 3'b10;
localparam STOP_STATE    = 3'b11;


localparam STORING    = 3'b001;
localparam WAITING    = 3'b000;
localparam RESET_STATE   = 3'b010;


reg [111:0] rx_string=0;
reg [2:0] state2 =3'b000;
reg [31:0] counter2=0;



reg rx_buffer            = 1'b1;
reg rxt                  = 1'b1;

reg [1:0]  state         = 0;
reg [15:0] counter       = 0;
reg [2:0]  bit_index     = 0; //where to place the next bit (0...7)
reg [7:0]  data_byte     = 0;
reg [7:0]  str_reg = 0;
reg [79:0] str_register = 0;
 // Can hold a string of 10 characters
 reg [15:0] uartcount;
 reg [15:0] count = 0;

 reg  hash_found_change_index = 0;

 reg data_avail;
 reg start_bot;
 reg skip=0;
 

initial begin
  o_data_byte = 0; 
  str_register = 0;
  data_avail = 0;
  uartcount=0;
  start_bot=0;
end
 
always @(posedge clk_50M)
begin
  rx_buffer <= i_rx;
  rxt <= rx_buffer;
end

always @(posedge clk_50M) 
begin
  case (state)
    IDLE_STATE :
      begin
        
        data_avail <= 0;
        counter <= 0;
        bit_index <= 0;
        if (rxt == 0)        // Start bit detected
          state <= START_STATE;
        else
          state <= IDLE_STATE;
      end

    START_STATE :
      begin
        if (counter == (CLKS_PER_BIT-1)/2)
        begin
          if (rxt == 0) // If still low at the middle of the start bit
          begin
            counter  <= 0;
            state  <= GET_BIT_STATE;
          end
          else
          begin
            state <= IDLE_STATE;
          end
        end
        else
        begin
          counter <= counter+16'b1;
          state   <= START_STATE;
        end
      end

    GET_BIT_STATE :
      begin
        if (counter < CLKS_PER_BIT-1)
        begin
          counter <= counter+16'b1;
          state   <= GET_BIT_STATE;
        end
        else
        begin
          counter                <= 0;
          data_byte[7-bit_index] <= rxt;

          if(bit_index < 7)
          begin
            bit_index <= bit_index+3'b1;
            state <= GET_BIT_STATE;
          end
          else
          begin
            bit_index <= 0;
            state <= STOP_STATE;
          end
        end
      end

		STOP_STATE:
			begin 
				if (counter<(CLKS_PER_BIT-1))
					begin
						counter <= counter+16'b1;
						state   <= STOP_STATE;
					end
				else
					begin
						// if(rxt == 0)
							// begin

								data_avail <= 1;
								counter		<=	0;
								state			<=	IDLE_STATE;
								// data_byte   <= 0;
								// o_data_byte	<=	0;
							// end
						// else
						// 	begin

						// 		counter		<=	0;
						// 		state			<=	IDLE_STATE;
								o_data_byte	<=	data_byte;
            //     	data_avail	<=	1;

								
						// 	end
					end
				end
				
			default:
			state	<=	IDLE_STATE;
			
		endcase

  
end





always @(posedge clk_50M) begin 


  if(data0=="S" & data1=="T" & data2=="A" & data3=="R" & data4=="T") begin
    start_bot <= 1;
  end


	if(data_avail==1)
	begin
	state2<=STORING;
	
	end
	else if(data_avail==0)
	begin
	state2<=RESET_STATE;
		
  if(skip==0)
  begin
    // o_data_byte[0:7]<=8'b00100011;
    //  o_data_byte[7:0]<=8'b11000100;
    hash_found_change_index<=1;
    // state2<=STORING;
    skip<=1;
  end
	end

          case(state2)

           WAITING : begin                           // wait for the messsage 

		  if(hash_found_change_index==1)
            begin
              uartcount<=0;
              hash_found_change_index<=0;               // reset the messge when hash is found 
            end

          end         

          STORING : begin                     //  for storing the data while recieving
          
          if(uartcount==0)begin
                        rx_string[111:104] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[111:104]==8'b00100011 | rx_string[111:104]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100 )  
                        begin
                          hash_found_change_index<=1;
                        end

            end
           else if(uartcount==1)begin
                        rx_string[103:96] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[103:96]==8'b00100011 | rx_string[103:96]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100 )
                        begin
                          hash_found_change_index<=1;
                        end

            end
				 else if(uartcount==2)begin
                        rx_string[95:88] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[95:88]==8'b00100011 | rx_string[95:88]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100 )
                        begin
                          hash_found_change_index<=1;
                        end
								end
								 else if(uartcount==3)begin
                        rx_string[87:80] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[87:80] ==8'b00100011 | rx_string[87:80] =="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100 )
                        begin
                          hash_found_change_index<=1;
                        end
end
								 else if(uartcount==4)begin
                        rx_string[79:72] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if( rx_string[79:72] ==8'b00100011 |  rx_string[79:72] =="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100 )
                        begin
                          hash_found_change_index<=1;
                        end
								end


								 else if(uartcount==5)begin
                        rx_string[71:64] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[71:64]==8'b00100011 | rx_string[71:64]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100 )
                        begin
                          hash_found_change_index<=1;
                        end
end

             else if(uartcount==6)begin
                        rx_string[63:56] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[63:56]==8'b00100011 | rx_string[63:56]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100 )
                        begin
                          hash_found_change_index<=1;
                        end

            end
             else if(uartcount==7)begin
                        rx_string[55:48] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[55:48]==8'b00100011 | rx_string[55:48]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100)
                        begin
                          hash_found_change_index<=1;
                        end

            end
             else if(uartcount==8)begin
                        rx_string[47:40] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[47:40]==8'b00100011 | rx_string[47:40]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100 )
                        begin
                          hash_found_change_index<=1;
                        end
            end
             else if(uartcount==9)begin
                        rx_string[39:32] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[39:32]==8'b00100011 | rx_string[39:32]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100)
                        begin
                          hash_found_change_index<=1;
                        end


            end
             else if(uartcount==10)begin
                        rx_string[31:24] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[31:24]==8'b00100011  | rx_string[31:24]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100)
                        begin
                          hash_found_change_index<=1;
                        end

            end
             else if(uartcount==11)begin
                        rx_string[23:16] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[23:16]==8'b00100011  | rx_string[23:16]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100)
                        begin
                          hash_found_change_index<=1;
                        end


            end
             else if(uartcount==12)begin
                        rx_string[15:8] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                        uartcount<=uartcount+1;
                        if(rx_string[15:8]==8'b00100011  | rx_string[15:8]=="#" | o_data_byte== 8'b00100011 | o_data_byte== 8'b11000100)   
                        begin
                          hash_found_change_index<=1;
                        end

            end
             else if(uartcount==13)begin
                        rx_string[7:0] <= {o_data_byte[0],o_data_byte[1],o_data_byte[2],o_data_byte[3],o_data_byte[4],o_data_byte[5],o_data_byte[6],o_data_byte[7]};
                uartcount <= 0;
            end
          
           
          end
			 
			 RESET_STATE: begin                //  for erasing the data recieved after 1 second
			 if(counter2<50000000) begin
			 counter2<=counter2+1;
			 end
			 else begin
  		counter2 <=0;
			 
      rx_string[111:0]<=0;      
      state2<= WAITING;
      end

       end 

			 default:
			state	<=	WAITING;

          
          endcase
          end


assign data0[7:0] = rx_string[111:104];
assign data1[7:0] = rx_string[103:96];
assign data2[7:0] = rx_string[95:88];
assign data3[7:0] = rx_string[87:80];
assign data4[7:0] = rx_string[79:72];
assign data5[7:0] = rx_string[71:64];
assign data6[7:0] = rx_string[63:56];
assign data7[7:0] = rx_string[55:48];
assign data8[7:0] = rx_string[47:40];
assign data9[7:0] = rx_string[39:32];
assign data10[7:0] = rx_string[31:24];
assign data11[7:0] = rx_string[23:16];
assign data12[7:0] = rx_string[15:8];
assign data13[7:0] = rx_string[7:0];


assign data_avail_w = data_avail;
assign start_bot_w =start_bot;




endmodule