// AstroTinker Bot : Task 1A : PWM Generator


/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan, Sudhanshu Ranjan, Sumit Saroj
▪ * Filename: controller
▪ * Theme: Astro Tinker Bot 
▪ * Functions: controller
▪ * Global Variables: None
▪ */



//PWM Generator
//Inputs : clk_3125KHz, duty_cycle
//Output : clk_195KHz, pwm_signal,pwm1,pwm2




module pwm_generator(   
    input clk_3125KHz,
    input [3:0] duty_cycle,
	  input [3:0] no,
    output reg clk_195KHz, pwm_signal,
	 output reg pwm1,pwm2
	 
);

initial begin
    clk_195KHz = 0; pwm_signal = 1;
  
end

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////


  reg [2:0] counter_A = 0;
  reg [3:0] counter_B = 0; 
        
//     initial begin  
// #0 clk_195KHz = 1;
// end
// sensitivity list -> trigger at positive edge of 50MHz clock
always @ (posedge clk_3125KHz) begin
    if (!counter_A ) clk_195KHz <= ~clk_195KHz; // toggles clock signal
    counter_A <= counter_A + 1'b1; // increment counter // after 7 it resets to 0
 

//pwm generation
  if(duty_cycle==3 && counter_B<3) begin
  pwm_signal<=1;
  end
    // PWM Generation
   else if(counter_B <duty_cycle)begin
       pwm_signal <= 1;
    end 
    
    else begin
    pwm_signal<=0;
    end

  counter_B<=counter_B+1;


////      NOTE :    4 is set to run thev motor backward    /////

if( (no !=4) ) begin 
pwm2 <= 0;            //  2 means backward 
pwm1 <= pwm_signal;    // 1 means forward
end
else if(no == 4) begin // for node detect and go backward for few seconds
pwm1 <= 0;
pwm2 <= pwm_signal;
end
else begin
pwm2 <= 0;
pwm1 <= 0;
end
  




end
//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule





