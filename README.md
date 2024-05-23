# FPGA Based Robot

This project involves designing and implementing a Line Follower Robot using FPGA. The robot is designed to follow the shortest path between two points calculated by the RISC-V CPU. The Robot follows the path based on the values from the sensors.
# Bot Image

![WhatsApp Image 2024-05-23 at 8 05 11 PM](https://github.com/Md-Faizan1/eyrc23_ab_3265/assets/132780190/9cde914c-7dff-44f1-aa02-77b3599f6d75

## Introduction

The Line Follower Robot is an autonomous robot capable of following a graph. The whole robot is programmed using verilog and the path calculation algorithm using C.

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

2. The whole CPU is based on RISC-V ISA.
3. The cpu and the memory is built using verilog on the FPGA.
4. The The path calculation program is written in C language.
5. The program is executed on the CPU using start and end points as arguments.


- Initializing the sensors and motor driver
- Continuously reading sensor data
- Adjusting motor speeds based on sensor input to follow the line
- Handling the START message to initiate line following


