## Demos
Demo codes are stored in `Demos` folder a makefile based on the bootloader makefile was added to each projects, the way to build the respective binaries are the same as openBLT for example:

- Compile General Timer demo.    
    1. Go to demo path.   
    ```bash
       cd Demos/BluepillDemo_GeneralTimer    
    ```    
    2. Build the project.
    ```bash
       make all
    ```    
    3. The output is available on  `Demos/BluepillDemo_GeneralTimer/bin/` to flash.
    ```
       DemoTimer_stm32f103.elf
       DemoTimer_stm32f103.srec
    ```   
   
- Compile GPIO demo.
    1. Go to demo path.   
    ```bash
       cd Demos/BluepillDemo_GPIO
    ```    
    2. Build the project.
    ```bash
       make all
    ```    
    3. The output is available on  `Demos/BluepillDemo_GPIO/bin` to flash.  
    ```
       DemoGPIO_stm32f103.elf
       DemoGPIO_stm32f103.srec
    ```   