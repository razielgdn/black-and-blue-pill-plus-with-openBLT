# OpenBLT running on Bluepill Plus and Blackpill boards.
This project enables the use of the **OpenBLT** **bootloader** on **Bluepill** **Plus** and Blackpill development boards, providing a lightweight and flexible solution for firmware updates on STM32-based systems.    

## Introduction
At this moment, the bootloader is ready to be used with RS232 and CAN buses.
I’m developing this project because I want to use the CAN protocol to flash a network of microcontrollers for future applications — such as an aquaponic system designed to raise fish, crustaceans, and plants. These microcontrollers will be used to control irrigation, lighting, and humidity, enabling automated and efficient system management.

## Compile the bootloader
Follow next steps to compile the bootloader maybe you will need install some prerequire packages.    
1. Clone the repo. 
   - Using https:    
   ```bash  
   git clone https://github.com/razielgdn/black-and-blue-pill-plus-with-openBLT.git -b main
   ```      
   - Using ssh:    
   ```bash   
   git clone  -b main git@github.com:razielgdn/black-and-blue-pill-plus-with-openBLT.git
   ```   
2. Navigate to the bootloader directory *OpenBLT_STM32F103_Bluepill_plus_GCC*:    
   ```bash  
   cd black-and-blue-pill-plus-with-openBLT/openBLT_STM32F103_Bluepill_plus_GCC
   ``` 
3. Make sure the path to your ARM GCC toolchain(e.g. `arm-none-eabi-gcc`) is correctly set in the **makefile**.   
After updating the path, compile the bootloader with:         
   ```bash 
   make clean all
   ``` 
4. If everything compiles successfully, the output files will be located in the **bin/** directory. You can use any of the generated binaries as needed.
   ``` 
   openblt_stm32f103.elf
   openblt_stm32f103.map
   openblt_stm32f103.srec
   ```

## Flash the bootloader
To enter boot mode on a **Blue Pill Plus (STM32F103C8T6)**, follow these steps:
   1. Hold down the **BOOT0** button.
   2. While holding **BOOT0**, press and release the **NRST** (reset) button.
   3. Then release the **BOOT0** button.

You can Flash the bootloader with any tool available for you.
For example:    
   - [**stm32flash**](https://sourceforge.net/p/stm32flash/wiki/Home/). Open source cross platform flash program for the STM32 ARM microcontrollers using the built-in ST serial bootloader over UART or I$^{2}$C
   - [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html) (STM32CubeProg) is an all-in-one multi-OS software tool for programming STM32 products. You can use UART, STLINK or J-link. 

In my own case I use UART with stm32flash. 
```bash
stm32flash -b 57600 -w openblt_stm32f103.elf -v 

```
    
## Resources used in this project
### Blue Pill Plus board
The documentation for the device is available in its [GitHub repository](https://github.com/WeActStudio/BluePill-Plus), and a good summary can also be found on [stm32-base.org](https://stm32-base.org/boards/STM32F103C8T6-WeAct-Blue-Pill-Plus-Clone).    

### OpenBLT Bootloader
**OpenBLT** is open source and licensed under the GNU General Public License v3 (GPLv3). It was created and is maintained by **Feaser**. You can visit their [official website](https://www.feaser.com/openblt/doku.php?id=homepage) for more information and documentation.     

### Test applications
The test applications were obtained from **John Blaiklock’s** [GitHub repository](https://github.com/miniwinwm/BluePillDemo), and the original source code was adapted for this project.    


