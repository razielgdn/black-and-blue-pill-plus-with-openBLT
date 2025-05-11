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

## Flashing the bootloader
To enter boot mode on a **Blue Pill Plus (STM32F103C8T6)**, follow these steps:
   1. Hold down the **BOOT0** button.
   2. While holding **BOOT0**, press and release the **NRST** (reset) button.
   3. Then release the **BOOT0** button.

You can flash the bootloader using any tool available to you. Below are two  methods:
   - [**stm32flash**](https://sourceforge.net/p/stm32flash/wiki/Home/). An open-source cross-platform flash tool for STM32 ARM microcontrollers, using the built-in ST serial bootloader over UART or I²C.     
     - **To generate the binary file (openblt_stm32f103.bin) run:**   
       ```bash
       cd openBLT_STM32F103_Bluepill_plus_GCC/     
       ```     
       ```bash  
       make bin/openblt_stm32f103.bin 
       ```
     - **To flash the bootloader using ```stm32flash```, run the following command:**    
       ```bash 
       stm32flash -b 115200 -w bin/openblt_stm32f103.bin -g 0x0 /dev/ttyUSB0
       ```       
  
   - [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html) (STM32CubeProg) is an all-in-one multi-OS software tool for programming STM32 products. You can use UART, STLINK or J-link.    
   The programmer supports multiple output formats, including **srec**, **bin**, and **elf**.   
      - Open STMCubeProgrammer and connect with the microcontroller in STM boot mode      
      ![Fig 1. STM32CubeProgrammer connected](doc/images/program01.png)    
      - Load the desired output file, for example: ```bin/openblt_stm32f103.bin```    
      ![Fig 2. File loaded](doc/images/program02.png)    
      - Click the Download button to flash the binary onto the microcontroller.  
      ![Fig 3. Downloading firmware](doc/images/program03.png)    
   Once completed, **OpenBLT** is now running on the **Bluepill Plus** board.    
## Adapting an application to use with openBLT.
Your embedded application must meet certain integration requirements. The bootloader expects the user application to be located at a specific memory address.    
1. Update the Linker Script. Modify your application’s linker script to relocate the vector table and code start address to match the end of the bootloader. To the Bluepill plus the file `STM32F103C8TX_FLASH.ld`.
   ```diff
   /* Entry Point */
   ENTRY(Reset_Handler)

   /* Highest address of the user mode stack */
   _estack = ORIGIN(RAM) + LENGTH(RAM);	/* end of "RAM" Ram type memory */

   _Min_Heap_Size = 0x200 ;	/* required amount of heap  */
   _Min_Stack_Size = 0x400 ;	/* required amount of stack */

   /* Memories definition */
   MEMORY
   {
      RAM	(xrw)	: ORIGIN = 0x20000000,	LENGTH = 20K
   -  FLASH	(rx)	: ORIGIN = 0x8000000,	LENGTH = 64K-8K /*1000 0000 0000 0010 0000 0000 0000 */
   +  FLASH	(rx)	: ORIGIN = 0x8002000,	LENGTH = 64K-8K /*1000 0000 0000 0010 0000 0000 0000 */
   }
   ```
2. Configure Vector Offset. 
   - Set the vector table base address in your application startup code `main.c`, typically using:
     ```diff 
     /* Private function prototypes -----------------------------------------------*/
     +static void VectorBase_Config(void);
     void SystemClock_Config(void);
     static void MX_GPIO_Init(void);
     static void MX_TIM2_Init(void);
     
     ...
     
     int main(void)
        {
        /* USER CODE BEGIN 1 */
       
       /* USER CODE END 1 */  
 
       /* MCU Configuration--------------------------------------------------------*/
     + VectorBase_Config();
       /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
       HAL_Init();
 
       /* USER CODE BEGIN Init */

       /* USER CODE END Init */

       /* Configure the system clock */
       SystemClock_Config();

     ...     

     +static void VectorBase_Config(void)
     +{
     +/* The constant array with vectors of the vector table is declared externally in the
     +   * c-startup code.
     +   */
     +extern const unsigned long g_pfnVectors[];
     +
     +/* Remap the vector table to where the vector table is located for this program. */
     +SCB->VTOR = (unsigned long)&g_pfnVectors[0];
     +} /*** end of VectorBase_Config ***/
     ```
   - Another Solution is change  VECT_TAB_OFFSET  macro value in `system/system_stm32f1xx.c` and application initialization don't need to be updated.
     ```diff
     /*!< Uncomment the following line if you need to use external SRAM  */ 
     #if defined(STM32F100xE) || defined(STM32F101xE) || defined(STM32F101xG) || defined(STM32F103xE) ||   defined(STM32F103xG)
     /* #define DATA_IN_ExtSRAM */
     #endif /* STM32F100xE || STM32F101xE || STM32F101xG || STM32F103xE || STM32F103xG */ 
     /*!< Uncomment the following line if you need to relocate your vector Table in
         Internal SRAM. */ 
     /* #define VECT_TAB_SRAM */
     -#define VECT_TAB_OFFSET  0x00000000U /*!< Vector Table base offset field.
     +#define VECT_TAB_OFFSET  0x00002000U /*!< Vector Table base offset field.
                                        This value must be a multiple of 0x200. */
     ``` 


## Using OpenBLT  
Once the bootloader has been successfully flashed onto the microcontroller, you can begin using OpenBLT to perform firmware updates over supported communication interfaces such as UART, and CAN, <!-- USB, or TCP/IP,--> depending on your configuration.
Feaser provides several tools to interface with the bootloader and flash application binaries:   
- [BootCommander](https://www.feaser.com/openblt/doku.php?id=manual:bootcommander)  – a command-line utility.
- **MicroBoot** – a GUI-based utility.
- **OpenBLT Library** – for integrating firmware updates into custom host applications 
- **OpenBLT Embedded Library (LibMicroBLT)** - The LibMicroBLT library encompasses all the functionality needed to perform a firmware update on another microcontroller, running the OpenBLT bootloader.
  
### Using BootCommander to flash to openBLT Bootloader

You can flash firmware binaries to the target platform using the BootCommander utility.
This project includes example demos to test the flashing process. Refer to the [demo documentation](doc/demos/compile-demos.md) for instructions on how to compile them.


## Resources used in this project
### Blue Pill Plus board
The documentation for the device is available in its [GitHub repository](https://github.com/WeActStudio/BluePill-Plus), and a good summary can also be found on [stm32-base.org](https://stm32-base.org/boards/STM32F103C8T6-WeAct-Blue-Pill-Plus-Clone).    

### OpenBLT Bootloader
**OpenBLT** is open source and licensed under the GNU General Public License v3 (GPLv3). It was created and is maintained by **Feaser**. You can visit their [official website](https://www.feaser.com/openblt/doku.php?id=homepage) for more information and documentation.     

### Test applications
The test applications were obtained from **John Blaiklock’s** [GitHub repository](https://github.com/miniwinwm/BluePillDemo), and the original source code was adapted for this project.    
<!-- …
Comments
 2032  stm32flash -b 115200 -w bin/openblt_stm32f103.bin /dev/ttyUSB0 
 2033  stm32flash -b 115200 -w Source-openBLT/bin/openblt_stm32f103.bin /dev/ttyUSB0 
 2034  stm32flash -b 115200 -w openBLT_STM32F103_Bluepill_plus_GCC/bin/openblt_stm32f103.bin /dev/ttyUSB0 
 2035  ./BootCommander -s=xcp -t=xcp_rs232 -d=/dev/ttyUSB0 -b=57600 ../test-applications/BluepillDemo_GPIO/bin/demoGPIO_stm32f103.srec 
 2036  BootCommander/BootCommander -s=xcp -t=xcp_rs232 -d=/dev/ttyUSB0 -b=57600 test-applications/BluepillDemo_GPIO/bin/demoGPIO_stm32f103.srec 
 2037  BootCommander/BootCommander -s=xcp -t=xcp_rs232 -d=/dev/ttyUSB0 -b=57600 test-applications/BluepillDemo_GeneralTimer/bin/demoTimer_stm32f103.srec 
 2038  history 

Note: To generate the binary file openblt_stm32f103.bin, run:

cd openBLT_STM32F103_Bluepill_plus_GCC/
make bin/openblt_stm32f103.bin 

 --> 