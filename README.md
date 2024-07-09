# Astro Tinker Bot under e-Yantra Robotics Competition IIT-B 2023-24

This project involves designing and implementing a Line Follower Robot using FPGA. The robot is designed to follow the shortest path between two points calculated by the RISC-V CPU. The Robot follows the path based on the values from the sensors.
# Bot Image


![WhatsApp Image 2024-05-23 at 8 05 11 PM](https://github.com/Md-Faizan1/eyrc23_ab_3265/assets/132780190/bc5a022d-dc98-4adc-a057-3e24241d220e)

## Introduction

The Line Follower Robot is made to traverse a space station and fix faults. The whole robot is programmed using verilog and the path calculation algorithm using C.

## Technology Used

FPGA board, RISC-V microprocessor, UART Protocol 

## Hardware Requirements

- De0-Nano FPGA Board
- Line Follower Sensor
- Buck Converter
- L9110S DC Motor Driver
- N20 Motors
- N20 Wheels
- 7.4V 2S Li-ion battery 2000mAh
- Bluetooth Module (HC-05)

## Software Requirements

- Intel Quartus
- Modelsim Altera(for simulation)

### Working 

1. The Robot recieves message through bluetooth to reach a desired location.
2. The path is calculated using the RISC-V basssed CPU using Dijkstra algorithm.
3. The path calculated is extracted from the ram memory.
4. The line follower verilog module then controls both the motor's speed .
5. If any object is detected then then it sends a message and glows the LED on it.
6. The robot can pick and drop the object(made up of metal) to some other desired location.

### About The CPU

1. The whole CPU is based on RISC-V ISA.
2. The cpu and the memory is built using verilog on the FPGA.
3. The The path calculation program is written in C language.
4. The program is executed on the CPU using start and end points as arguments.

### Difiiculty Faced 

1. The ram memory size was a constraint so we have to use bitmasking techniques to store data efficiently.
2. The debugging procedure was taime taking as we have to observe the individual signals using signal tap.
3. The data which was recievd on the bot was corrupted till it reached, so we have to use handshaking between the reciever and the modules. 

## Contributors 

- [Md Faizan](https://github.com/Md-Faizan1)
- [Sudhanshu Ranjan](https://github.com/sudhanshur555)
- [Sumit Saroj](https://github.com/Sumit20215155)





