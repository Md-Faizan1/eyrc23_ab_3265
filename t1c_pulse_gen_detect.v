/* 
▪ * Team Id: 3265
▪ * Author List: Md Faizan, Sudhanshu Ranjan, Sumit Saroj
▪ * Filename: controller
▪ * Theme: Astro Tinker Bot 
▪ * Functions: controller
▪ * Global Variables: None
▪ */

module t1c_pulse_gen_detect (
    input wire clk_50M, // 50MHz clock
    input wire reset,
    input wire echo_rx,
	 output reg fault,
    output reg trigger,
	 output reg [31:0] echo_duration
);

    localparam CLOCK_FREQUENCY = 50_000_000; // 50MHz
    localparam TRIGGER_PERIOD = 10; // 10us
    localparam TRIGGER_INTERVAL = 1_000; // 1ms
		initial begin
			fault = 0;
			end
    reg [31:0] counter;
    reg [31:0] trigger_counter;
    reg [31:0] echo_start;
    reg [31:0] echo_end;
	  reg echo_rx_prev = 0;
   
	 reg [31:0] time_counter =0;

    always @(posedge clk_50M or posedge reset) begin
        if (reset) begin
            counter <= 0;
            trigger_counter <= 0;
            trigger <= 0;
        end else begin
            counter <= counter + 1;
            if (counter >= CLOCK_FREQUENCY * TRIGGER_PERIOD / 1_000_000) begin
                counter <= 0;
                trigger <= ~trigger;
                trigger_counter <= trigger_counter + 1;
                if (trigger_counter >= CLOCK_FREQUENCY * TRIGGER_INTERVAL / 1_000_000) begin
                    trigger_counter <= 0;
                end
            end
        end
    end



 always @(posedge clk_50M) begin
        if(echo_rx != 0) begin
            time_counter <= time_counter + 1;
        end else if (echo_rx == 0 && echo_rx_prev != 0) begin
            echo_duration <= time_counter;
            time_counter <= 0;
        end
        echo_rx_prev <= echo_rx;
		  
		  
		  
		  if(echo_duration<20000) begin
		  fault <= 1'b1;
		  end
		  else 
		  fault<= 1'b0;
    end
	
					
		
		
					

endmodule
