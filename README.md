# OpenBLT running on Bluepill Plus and Blackpill boards.
This project enables the use of the **OpenBLT** **bootloader** on **Bluepill** **Plus** and Blackpill development boards, providing a lightweight and flexible solution for firmware updates on STM32-based systems.    

## Introduction
At this moment, the bootloader is ready to be used with RS232 and CAN buses.
I’m developing this project because I want to use the CAN protocol to flash a network of microcontrollers for future applications — such as an aquaponic system designed to raise fish, crustaceans, and plants. These microcontrollers will be used to control irrigation, lighting, and humidity, enabling automated and efficient system management.

## Compile bootloader
Follow next steps to compile the bootloader.
1. Clone the repo.    
   - Using ssh:    
   `$git clone  -b main git@github.com:razielgdn/black-and-blue-pill-plus-with-openBLT.git`
   - Using https:    
   `$ git clone https://github.com/razielgdn/black-and-blue-pill-plus-with-openBLT.git -b main`  
2. Go to path *OpenBLT_STM32F103_Bluepill_plus_GCC*:    
   `cd cd black-and-blue-pill-plus-with-openBLT/` 
3. Use make to compile the   


    
## Resources used in this project
### Blue Pill Plus board
The documentation for the device is available in its [GitHub repository](https://github.com/WeActStudio/BluePill-Plus), and a good summary can also be found on [stm32-base.org](https://stm32-base.org/boards/STM32F103C8T6-WeAct-Blue-Pill-Plus-Clone).    

### OpenBLT Bootloader
**OpenBLT** is open source and licensed under the GNU General Public License v3 (GPLv3). It was created and is maintained by **Feaser**. You can visit their [official website](https://www.feaser.com/openblt/doku.php?id=homepage) for more information and documentation.     

### Test applications
The test applications were obtained from **John Blaiklock’s** [GitHub repository](https://github.com/miniwinwm/BluePillDemo), and the original source code was adapted for this project.    


