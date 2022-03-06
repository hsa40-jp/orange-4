# ORANGE-4

## About ORANGE-4

[ORANGE-4](http://www.picosoft.co.jp/ORANGE-4/index.html) is a 4-bit microcontroller board sold by [PicoSoft Co.,Ltd](http://www.picosoft.co.jp/index.html).
Not only can you learn machine language with the unit alone,
but you can also debug it from a PC via USB-serial communication.

## Register

|Register  |Size     |Address  |Remarks             |
|----------|---------|---------|--------------------|
|A         |4bit     |6f       |                    |
|B         |4bit     |6c       |                    |
|Y         |4bit     |6e       |                    |
|Z         |4bit     |6d       |                    |
|A'        |4bit     |69       |Auxiliary registers |
|B'        |4bit     |67       |Auxiliary registers |
|Y'        |4bit     |68       |Auxiliary registers |
|Z'        |4bit     |66       |Auxiliary registers |
|PC        |8bit     |         |Program Counter     |
|SP        |8bit     |         |Stack Pointer       |

## Memory Map

|Address  |Description             |
|---------|------------------------|
|00-4f    |Program Area            |
|50-5f    |Data Area               |
|60-7f    |System Area             |
|80-ef    |Program Area/Stack Area |
|f0-ff    |Stack Area              |

## Instruction Set

| Opecode | Mnemonic | Operand | Execution Flag | Description                                                                                                                                |
| :------ | :------- | :------ | :------------- | :----------------------------------------------------------------------------------------------------------------------------------------- |
| 0       | ink      |         | 0,1            | Store the inputted number in the A register (no key input, execution FLG=1).                                                               |
| 1       | outn     |         | 1              | Display the A register value on the numeric LED.                                                                                           |
| 2       | abyz     |         | 1              | A⇔B、Y⇔Z.                                                                                                                                  |
| 3       | ay       |         | 1              | A⇔Y.                                                                                                                                       |
| 4       | st       |         | 1              | Store the A register value at (50+Y).                                                                                                      |
| 5       | ld       |         | 1              | Store the value at (50+Y) in the A register.                                                                                               |
| 6       | add      |         | 0,1            | Add the value at (50+Y) to the A register value (when the digit is increased, execution FLG=1).                                            |
| 7       | sub      |         | 0,1            | Subtract the A register value from the value at (50+Y), and store the result in the A register (if the result is negative, execute FLG=1). |
| 8       | ldi      | x       | 1              | Store the operand value in the A register.                                                                                                 |
| 9       | addi     | x       | 0,1            | Add the "operand" value to the A register (at the time of digit increase, execution FLG=1).                                                |
| A       | ldyi     | x       | 1              | Store "operand" value in Y register.                                                                                                       |
| B       | addyi    | x       | 0,1            | Add the "operand" value to the Y register (at the time of digit increase, execution FLG=1).                                                |
| C       | cpi      | x       | 0,1            | If A register value = operand value, execute FLG = 0.                                                                                      |
| D       | cpyi     | x       | 0,1            | If Y register value = operand value, execute FLG = 0.                                                                                      |
| E       | scall    | x       | 0,1            | service call.                                                                                                                              |
| F       | jmpf     | xx      | 0,1            | If execution FLG=1, jump to the specified address.                                                                                         |
| F60     | call     | xx      | 1              | Jump to specified address (regardless of execution FLG).                                                                                   |
| F61     | ret      |         | 1              | callBack to the original address.                                                                                                          |
| F62     | pushA    |         | 1              | Load the A register value to the top of the stack.                                                                                         |
| F63     | popA     |         | 1              | Store the stack top value in the A register.                                                                                               |
| F64     | pushB    |         | 1              | Load the B register value to the top of the stack.                                                                                         |
| F65     | popB     |         | 1              | Store the stack top value in the B register.                                                                                               |
| F66     | pushY    |         | 1              | Load the Y register value to the top of the stack.                                                                                         |
| F67     | popY     |         | 1              | Store the stack top value in the Y register.                                                                                               |
| F68     | pushZ    |         | 1              | Load the Z register value to the top of the stack.                                                                                         |
| F69     | popZ     |         | 1              | Store the stack top value in the Z register.                                                                                               |
| F70     | ioctrl   |         | 1              | Set the port specified by the Y register with the A register value (0:D output, 2:D input).                                                |
| F71     | out      |         | 1              | Outputs the A register value (0 or 1) to the port specified by the Y register.                                                             |
| F72     | in       |         | 1              | Read the status of the port specified by the Y register into the A register.                                                               |

## Service Call

| Function No. | Execution Flag | Description                                                                                                                   |
| :----------- | :------------- | :---------------------------------------------------------------------------------------------------------------------------- |
| 0            | 1              | Turn off the numeric LED.                                                                                                     |
| 1            | 1              | Turn on the LED corresponding to the Y register value.                                                                        |
| 2            | 1              | Turn off the LED corresponding to the Y register value.                                                                       |
| 3            | 1              | Not used.                                                                                                                     |
| 4            | 1              | Invert all bits of the A register.                                                                                            |
| 5            | 1              | Exchange all registers with the value of the '(dash)' auxiliary register.                                                     |
| 6            | 0,1            | Shift the value of the A register by one bit to the right (if the value before the shift is an even number, execute FLG = 1). |
| 7            | 1              | Make the end sound.                                                                                                           |
| 8            | 1              | Make an error sound.                                                                                                          |
| 9            | 1              | Make a short sound.                                                                                                           |
| A            | 1              | Make a long sound.                                                                                                            |
| B            | 1              | Play the scale (0~E) specified by the A register.                                                                             |
| C            | 1              | Wait for processing for (A register value + 1) x 0.1 second.                                                                  |
| D            | 1              | Turns on the binary LED corresponding to the value at 5E (lower 4 bits) and 5F (upper 3 bits).                                |
| E            | 1              | Decimal subtraction of the A register value from the value at (50+Y).                                                         |
| F            | 1              | Decimal addition of the value at (50+Y) and the A register value.                                                             |

## How to operate the ORANGE-4

| Switch Operation | Description                                                                                                                                                   |
| :--------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [0]～[F]         | Change the value displayed by the numeric LED.                                                                                                                |
| [INC]            | Store the value displayed by the numeric LED in the address displayed by the binary LED, and advance by one address.                                          |
| [X][X][ADR]      | Set the address displayed by the binary LED to XX.                                                                                                            |
| [RST]            | Set the address displayed by the binary LED to 00. If the program is running, the program is interrupted.                                                     |
| [1][RUN]         | Execute the program. (No address display on binary LED, no key input sound)                                                                                   |
| [2][RUN]         | Execute the program. (There is an address display on the binary LED, and no key input sound.)                                                                 |
| [5][RUN]         | Step through the program. (No address display on binary LED, no key input sound)                                                                              |
| [6][RUN]         | Step execution execution of the program. (There is an address display on the binary LED and a key input sound.)                                               |
| [A][RUN]         | Automatically executes the data stored in the memory as music data.                                                                                           |
| [B][RUN]         | Output to serial printer. (9600bps) Enter the function number (0 to 1) after the numeric LED changes to D. [0] Dump list [1] Disassembly list                 |
| [C][RUN]         | Load the preinstalled program. Enter a number after the number LED changes to L. [1] 15-second timer [6] Raccoon dog dance at Shojoji Temple [8] Knight Rider |
| [D][RUN]         | Start the monitor. (Make sure you have a 115200bps serial console connected.)                                                                                 |
| [E][RUN]         | Loads data from flash RAM into memory. Input the page number (0 to 3) after the numeric LED changes to "L".                                                   |
| [F][RUN]         | Saves the data in the memory to the flash RAM. Enter the page number (0 to 3) after the numeric LED changes to S.                                             |

## I/O Port

| Pin No. | Signal |
| :------ | :----- |
| 1       | 3.3V   |
| 2       | RXD    |
| 3       | TXD    |
| 4       | GND    |
| 5       | 5V     |
| 6       | PORT1  |
| 7       | PORT2  |
| 8       | PORT3  |

## Monitor commands

By connecting a USB serial cable to a PC, you can
You can also transfer programs (*) from a serial console (115200bps) and debug them.
It can also be used for debugging.

The signal level for USB serial is 3.3v.

If a parameter is required, there will be no space between the command and the parameter.

| Commnad | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| :------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| q       | Exit the monitor.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| 0(Zero) | Resets the program counter and stack pointer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| x       | Displays the current status.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| d       | Displays the contents of memory (00-7f). If e is specified as a parameter, the contents of memory (80-ff) will be displayed.<br/> [Example]<br/> d<br/> De                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| e       | Set values in registers and memory.<br/> <br/> (Setting memory)<br/> nn: Hexadecimal string<br/> nn is the starting address and is specified in two hexadecimal digits.<br/> [Example] e30:123abcde<br/> <br/> (Register settings)<br/> XX:n<br/> XX is the register designation<br/> n is a 1-digit hexadecimal number<br/> To specify a register<br/> ax:n(A register value)<br/> bx:n(B register value)<br/> yx:n(Y register value)<br/> zx:n(Z register value)<br/> a':n(A' register value)<br/> b':n(B' register value)<br/> y':n(Y' register value)<br/> z':n(Z' register value)<br/> [Example] sax:0 |
| r       | Loads the data of the specified page number in flash memory into memory.<br/> The page number is 0 to 3.<br/> [Example] r2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| w       | Writes the contents of the memory to the specified page number in the flash memory.<br/> The page number is 0 to 3.<br/> [Example] w2                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| l       | Displays the disassembly list. You can specify the starting address by specifying two hexadecimal digits after the command.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| t       | Executes one step. (This is used when you want to trace the call destination of the call instruction.)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| s       | Executes one step. (This is used when you do not want to trace the call destination of the call instruction.)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| g       | Run the program.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| b       | Sets a breakpoint. The breakpoints are specified in two hexadecimal digits.<br/> [Example] b1f                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| m       | Automatically plays the data in memory as music data.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |

## Assembler

A GUI version of the assembler is available at the bottom of the following page.

This is a Japanese page, but there is an assembler image, so if you don't understand Japanese, you can still download it.

[GUI version of cross assembler](http://www.picosoft.co.jp/ORANGE-4/index.html)

## Original Assembler

Under the tools/assembler directory, you will find the original assembler created by LibreOffice Calc.
When you type neamock, you can get real-time confirmation of the address number and a description of neamock.
At the same time, it can also check for incorrect neamock, incorrect Opecode, incorrect Operand, and program area overflow.
For details, please refer to README (currently under construction).
