# FPGA Based Line Follower Robot

This project involves designing and implementing a Line Follower Robot using FPGA. The robot is designed to follow the shortest path between two points calculated by the RISC-V CPU. The Robot follows the path based on the values from the sensors.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Hardware Requirements](#hardware-requirements)
- [Software Requirements](#software-requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Code Overview](#code-overview)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Introduction

The Line Follower Robot is an autonomous robot capable of following a line drawn on the floor. This project is ideal for understanding basic robotics, sensor integration, and control systems.

## Features

- **Quick Path Calculation** The robot calculates the shortest path in 
- **:** The robot begins operation upon receiving a START message.
- **Real-time Adjustment:** The robot can adjust its path in real-time based on sensor input.

## Hardware Requirements

- Microcontroller (e.g., Arduino, Raspberry Pi)
- Line sensors (e.g., IR sensors)
- Motor driver (e.g., L298N)
- DC motors
- Chassis for the robot
- Wheels
- Battery pack
- Bluetooth or WiFi module (for receiving the START message)

## Software Requirements

- Arduino IDE or other suitable development environment
- Python (if using Raspberry Pi)
- Libraries:
  - Motor driver library
  - Sensor reading library
  - Communication protocol library (e.g., `pySerial` for Python)

## Installation

### Hardware Setup

1. Assemble the robot chassis.
2. Attach the motors to the chassis and connect them to the motor driver.
3. Attach the line sensors to the front of the robot.
4. Connect the motor driver and sensors to the microcontroller.
5. Connect the Bluetooth/WiFi module to the microcontroller.

### Software Setup

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/line-follower-robot.git
    cd line-follower-robot
    ```

2. Open the project in your development environment.
3. Upload the provided code to your microcontroller.

## Usage

1. Power on the robot.
2. Send the START message via the communication module.
3. The robot will start following the line.

## Code Overview

### Main Code

The main code is responsible for:

- Initializing the sensors and motor driver
- Continuously reading sensor data
- Adjusting motor speeds based on sensor input to follow the line
- Handling the START message to initiate line following

### Example Code Snippet

```cpp
#include <MotorDriver.h>
#include <LineSensor.h>
#include <CommunicationModule.h>

void setup() {
    // Initialize components
    MotorDriver.init();
    LineSensor.init();
    CommunicationModule.init();
}

void loop() {
    // Check for START message
    if (CommunicationModule.receivedStartMessage()) {
        while (true) {
            // Read sensor values
            int sensorValue = LineSensor.read();
            
            // Adjust motor speeds
            MotorDriver.adjustMotors(sensorValue);
        }
    }
}
