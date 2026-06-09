# Work Log
<!--
Since my last work involving rising embedded image to RPI4, I decided to include a log describing the day-by-day activities in my projects. 
This file is created with the purpose to document the objectives of the project and how it will be completed along the time.
-->

## Activities

- [ ] Migrate openBLT support to the BlackPill V3 board.
    - [ ] Find a template compatible with the STM32F401CE MCU (the Black Pill V3 microcontroller) from Open openBLTdemo resources.
    - [ ] Configure the clock and peripherals for the project.
    - [ ] Migrate the HAL drivers for the STM32F401CE device.
    - [ ] Configure the offset in the linker file.
    - [ ] Configure a makefile to build the project.
- [ ] Test and debug the project to verify functionality.
- [ ] Find or develop a demo to test the openBLT features.

## Progress

### June 08, 2026
I quickly use Meld to compare the files in ARMCM4_STM32F4 and ARMCM3_STM32F1 to check if the structure of the code is different and understand how the code works. 
Also I am reading and checking what I need to modify in the HAL drivers files.

### June 06, 2026
The first modifications were performed. The demo initially had support for UART, CAN, and Ethernet. Since the Black Pill V3 board doesn't have Ethernet and the CAN bus is not used in this project, CAN and Ethernet support was disabled.
I recently updated my Fedora distribution to version 44, which required me to upgrade my tools. I upgraded STM32CubeIDE and noticed that the wizard to configure MCU resources and clock systems has been removed, so I need to use the standalone STM32CubeMX tool.
Right now, I am ready to start the next step: configuring the HAL drivers for the STM32F401CE device.

### June 05, 2026

I started working on this project by researching the best option to implement OpenBLT on a Black Pill V3 board. In the demos of the Feaser project, support for this specific MCU is not included. 
The first step was to copy the files from a demo that includes another Cortex-M4 MCU with similar resources. The selected one was the STM32F429Z demo from the Feaser project.