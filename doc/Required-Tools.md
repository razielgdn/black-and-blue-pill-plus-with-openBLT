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
- **The PL2303 driver** is in the mainline Linux kernel.
  
- [GNU Arm Embedded Toolchain:](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads): he GNU Toolchain for the Arm Architecture releases produced by Arm (referred to as “Arm GNU Toolchain”) enable partners, developers and the community to use new features from recent Arm Architecture and from open-source projects GCC, Binutils, glibc, Newlib, and GDB. Download availeble on: [Arm GNU Toolchain Downloads](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads). The indicated package is: `arm-gnu-toolchain-14.2.rel1-aarch64-arm-none-eabi.tar.xz` latest when this manual is writed. 
  
You can download tools and use it following next steps. 
  - Download package: 
    ```bash
    mkdir arm-toolchain
    wget -c https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-aarch64-arm-none-eabi.tar.xz
    ```
  - Uncompress 
  - Reference it in makefiles or environmental variables.