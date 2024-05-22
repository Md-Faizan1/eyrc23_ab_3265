/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan, Sudhanshu Ranjan, Sumit Saroj
▪ * Filename:  mux2 
▪ * Theme: Astro Tinker Bot 
▪ * Functions:  mux2
▪ * Global Variables: None
▪ */

// mux2.v - logic for 2-to-1 multiplexer

module mux2 #(parameter WIDTH = 8) (
    input       [WIDTH-1:0] d0, d1,
    input       sel,
    output      [WIDTH-1:0] y
);

assign y = sel ? d1 : d0;

endmodule
