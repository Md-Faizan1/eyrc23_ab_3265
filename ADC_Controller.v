/*
Module ADC_Controller

This Module controls the built-in 12-bit adc of the de0 Nano board.

This ADC Module is responsible to get digital output values from the
ADC module of the board in the appropriate channels.

ADC Controller design

Input   :  adc_sck : 3.125MHz Clock (max 3.25 MHz) (from frequency scaling block)
           dout   : digital output from ADC128S022 (serial 12-bit)

Output  :  adc_cs_n : Chip Select,
           din      : Ch. address input to ADC128S022,
           left_value, center_value, right_value : 12-bit output of ch. 1, 4 & 3
*/

// Module Declaration
module ADC_Controller(
    input  dout, adc_sck, clk_50M,
    output adc_cs_n, din,
    output [11:0] left_value, center_value, right_value
);


// Declaring registers
reg[11:0] dout_chx, dout_ch1 = 0, dout_ch4 = 0, dout_ch3 = 0;
reg[4:0] data_counter = 0;
reg[3:0] din_counter = 0, sp_counter = 0;
reg[2:0] channel_select = 0, channel = 0;
reg[2:0] mem1 [0:2];
reg adc_cs = 1, din_temp = 0, init = 1;

always @(negedge adc_sck) begin
    // Initializing Channels for 1, 4, 3 to get input from the line follower sensor
    if(init == 1) begin
        // memory initialization
        init = 0; mem1[0] = 1; mem1[1] = 4; mem1[2] = 3;
    end

    // Generating digital input signal which holds the analog channel address
    if (din_counter == 0) adc_cs = ~adc_cs;
    if (channel_select > 2) channel_select = 0;
    else if((din_counter >= 2) && (din_counter <= 4)) channel = mem1[channel_select];
    else if(din_counter == 15) begin
            adc_cs = ~adc_cs;
            channel_select = channel_select + 1'b1;
    end

    case(din_counter)
        2: din_temp = channel[2];
        3: din_temp = channel[1];
        4: din_temp = channel[0];
        default: din_temp = 0;
    endcase
    din_counter = din_counter + 1'b1;
end

// Serial In Parallel Out Block
always @(posedge adc_sck) begin
    // Reading Serial Values from dout signal,
    // then shifting that values into parallel data
    if(sp_counter >= 4 && sp_counter <= 15) begin
        dout_chx = {dout_chx[10:0], dout};
    end
    sp_counter = sp_counter + 1'b1;
end

// Channel Mapping Block
always @(negedge adc_sck) begin
    if(data_counter == 16) begin
        data_counter = 0;
        // Mapping parallel data to appropriate output channels
        case(channel)
            1: dout_ch1 = dout_chx;
            4: dout_ch4 = dout_chx;
            3: dout_ch3 = dout_chx;
        endcase
    end
    data_counter = data_counter + 1'b1;
end

// Assigning Outputs to corresponding Registers
assign adc_cs_n = adc_cs;
assign din = din_temp;
assign left_value = dout_ch4;
assign center_value = dout_ch3;
assign right_value = dout_ch1;

endmodule
