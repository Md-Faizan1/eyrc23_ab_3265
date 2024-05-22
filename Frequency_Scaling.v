// AstroTinker Bot : Task 1A : Frequency Scaling

/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan, Saurabh Kumar, Sudhanshu Ranjan, Sumit Saroj
▪ * Filename: Frequency_Scaling 
▪ * Theme: Astro Tinker Bot 
▪ * Functions:Frequency_Scaling 
▪ * Global Variables: None
▪ */


//Frequency Scaling
//Inputs : clk_50M
//Output : clk_3125KHz


module Frequency_Scaling (
    input clk_50M,
    output reg clk_3125KHz
);

initial begin
    clk_3125KHz = 0;
end

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////

/*
Add your logic here
*/
reg [2:0] counter =0;
//initial begin  
//#0 clk_3125KHz = 1;
//end
// sensitivity list -> trigger at positive edge of 50MHz clock
always @ (posedge clk_50M) begin
    if (!counter) clk_3125KHz = ~clk_3125KHz; // toggles clock signal
    counter = counter + 1'b1; // increment counter // after 7 it resets to 0
end



//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////

endmodule
