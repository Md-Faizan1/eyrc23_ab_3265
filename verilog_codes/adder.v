/* 
▪ * Team Id: 3eYRC#AB#3265
▪ * Author List: Md Faizan, Sudhanshu Ranjan, Sumit Saroj, Saurabh Kumar
▪ * Filename: adder 
▪ * Theme: Astro Tinker Bot 
▪ * Functions: adder 
▪ * Global Variables: None
▪ */

// adder.v - logic for adder

module adder #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,
    output      [WIDTH-1:0] sum
);

assign sum = a + b;

endmodule
