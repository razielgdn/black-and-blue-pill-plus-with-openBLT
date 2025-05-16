# Required Tools to work with this project
Required Tools on Ubuntu

To compile and interact with the hardware in this project, make sure the following tools are installed on your Ubuntu system:

- **dfu-util** – Used for Device Firmware Upgrade (DFU) over USB.
- **stm32flash** – Open source cross platform flash program for the STM32 ARM microcontrollers using the built-in ST serial bootloader over UART or I2C.
- **can-utils** – This package contains some userspace utilities for Linux SocketCAN subsystem.   
You can install them with:
  ```bash
  sudo apt update
  sudo apt install dfu-util can-utils stm32flash
  ```
- **The PL2303 driver** is in the mainline Linux kernel.
  
- [GNU Arm Embedded Toolchain:](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads): he GNU Toolchain for the Arm Architecture releases produced by Arm (referred to as “Arm GNU Toolchain”) enable partners, developers and the community to use new features from recent Arm Architecture and from open-source projects GCC, Binutils, glibc, Newlib, and GDB.    
The latest recommended version at the time of writing is [Arm GNU Toolchain Downloads](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads). The indicated package is: `arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi`.  
  **Installation Steps**    
  You can download and configure the toolchain with the following steps:You can download tools and use it following next steps.     
  - Create a directory and download the toolchain package:
    ```bash
    mkdir arm-toolchain
    wget -c https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
    ```
  - Extract the archive:
    ```bash  
    tar xfv arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
    ```
  - Update Makefiles to point to the correct arm-none-eabi-gcc path if needed.
    ```diff
    #TOOL_PATH=C:/PROGRA~2/GNUTOO~1/82018-~1/bin/ 
    -#TOOL_PATH=/opt/gcc-arm-none-eabi-10.3-2021.10/bin/
    +TOOL_PATH=~/arm-tools/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/
    ```
  - Update the linked archives to ensure compatibility with the new toolchain by modifying the linker script sections to use read-only attributes where appropriate.    
    ```diff    
    *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
       . = ALIGN(4);
    } >FLASH

    -.ARM.extab: 
    +.ARM.extab (READONLY) : /* The "READONLY" keyword is only supported in GCC11 and later, remove it if using GCC10 or earlier. */
    {
     . = ALIGN(4);
     *(.ARM.extab* .gnu.linkonce.armextab.*)
     . = ALIGN(4);
    } >FLASH
    -.ARM :
    +.ARM (READONLY) : /* The "READONLY" keyword is only supported in GCC11 and later, remove it if using GCC10 or earlier. */
    {
     . = ALIGN(4);
     __exidx_start = .;
     *(.ARM.exidx*)
     __exidx_end = .;
     . = ALIGN(4);
     } >FLASH
    -.preinit_array : 
    +.preinit_array (READONLY) : /* The "READONLY" keyword is only supported in  GCC11 and later, remove it if using GCC10 or earlier. */
    {
     . = ALIGN(4); 
    ```
- You can download and configure the older toolchain version[gcc-arm-none-eabi-10.3-2021.10](https://developer.arm.com/downloads/-/gnu-rm) by following the same procedure described above. 
  1. Download the toolchain  
     ```bash 
     cd ~/arm-toolchain 
     wget -c https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
     ```
  2. Extract the archive:
    ```bash  
    tar xvjf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 
    ```  
  3. Update Makefiles to point to the correct arm-none-eabi-gcc path if needed.
   
- You can use [STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html#st-get-software) and [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html#st-get-software) to develop your applications and even to work with OpenBLT.
Both tools are available on the STMicroelectronics website. You must create an account to download the software.

 