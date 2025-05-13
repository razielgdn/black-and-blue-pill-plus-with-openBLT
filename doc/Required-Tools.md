# Required Tools to work with this project
Required Tools on Ubuntu

To compile and interact with the hardware in this project, make sure the following tools are installed on your Ubuntu system:

- **dfu-util** – Used for Device Firmware Upgrade (DFU) over USB.
- **stm32flash** – Open source cross platform flash program for the STM32 ARM microcontrollers using the built-in ST serial bootloader over UART or I2C.
- **can-utils** – This package contains some userspace utilities for Linux SocketCAN subsystem. 
  
You can install them with:
```
sudo apt update
sudo apt install dfu-util can-utils stm32flash
```
- **The PL2303 driver** is in the mainline Linux kernel
- [GNU Arm Embedded Toolchain:](https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain#Technical-Specifications): he GNU Toolchain for the Arm Architecture releases produced by Arm (referred to as “Arm GNU Toolchain”) enable partners, developers and the community to use new features from recent Arm Architecture and from open-source projects GCC, Binutils, glibc, Newlib, and GDB.
  