# 8086 Assembly Language Learning Repository

## What is Assembly Language?

Assembly language is a low-level programming language that has a strong correspondence between the language's instructions and the architecture's machine code instructions. The 8086 assembly language is specific to the Intel 8086/8088 microprocessor, which was the foundation for the x86 architecture used in most personal computers today.

## Why Learn Assembly?

1. **Understand Computer Architecture**: Assembly provides direct insight into how computers work at the hardware level.
2. **Optimization**: When performance is critical, assembly allows fine-grained control over program execution.
3. **System Programming**: Operating systems, device drivers, and embedded systems often require assembly.
4. **Security**: Understanding assembly helps in analyzing malware, performing reverse engineering, and identifying vulnerabilities.
5. **Academic Foundation**: Assembly bridges the gap between hardware and high-level languages.

## Setting Up emu8086

The code examples in this repository are designed to run with emu8086, a popular emulator for 8086 assembly.

### Installation

1. Download emu8086 from [emu8086.com](https://emu8086.com/) or another trusted source
2. Install the software following the on-screen instructions
3. Register the software or use it in evaluation mode

### Configuration

1. Open emu8086
2. Go to "Options" → "Settings" to customize your environment
3. Set your preferred editor options and emulation speed

## Running the Code Examples

1. **Open a file**:

   - Launch emu8086
   - Click "File" → "Open"
   - Navigate to the code file (\*.asm)

2. **Compile**:

   - Click "Compile" or press F9
   - Fix any errors if they appear

3. **Run**:

   - Click "Emulate" or press F5 to run the program
   - Watch the execution in the emulator window

4. **Debug**:
   - Use single-step (F8) to execute one instruction at a time
   - Watch registers and memory change in real-time

## Code Organization

This repository contains various assembly examples demonstrating key concepts:

- **Basic I/O**: Reading from keyboard and displaying output
- **Arithmetic Operations**: Addition, subtraction, multiplication, division
- **Logical Operations**: AND, OR, XOR, NOT
- **Control Flow**: Loops, conditional jumps, procedures
- **String Operations**: String manipulation using assembly
- **Data Structures**: Arrays, records, and simple data structures
- **Sorting Algorithms**: Implementation of basic sorting techniques

## Common Assembly Structures

### Program Template

```assembly
.MODEL SMALL
.STACK 100H

.DATA
    ; Data declarations go here

.CODE
MAIN PROC
    MOV AX, @DATA   ; Initialize data segment
    MOV DS, AX

    ; Your code goes here

    MOV AH, 4CH     ; DOS exit function
    INT 21H         ; Return to DOS
MAIN ENDP

; Other procedures
END MAIN
```

### Data Types

- `DB` - Define Byte (8 bits)
- `DW` - Define Word (16 bits)
- `DD` - Define Doubleword (32 bits)

## Common Pitfalls and Debugging Tips

1. **Register Preservation**: Always save registers you modify in procedures using PUSH/POP
2. **Stack Management**: Ensure balanced PUSH/POP operations
3. **Segment Registers**: Don't forget to initialize DS, ES when needed
4. **Procedure Returns**: Always include RET at the end of procedures
5. **Input Validation**: Check range of user inputs
6. **Output Formatting**: Plan your output display carefully

## For Juniors and New Users

1. **Start Simple**: Begin with basic programs and progress gradually
2. **Understand Instructions**: Keep the 8086 instruction reference handy
3. **Draw Memory Maps**: Sketch how your data is organized in memory
4. **Trace Execution**: Follow your program's execution step by step
5. **Compare Solutions**: Look at multiple approaches to the same problem

## Additional Resources

- [8086 Instruction Set Reference](https://www.gabrielececchetti.it/Teaching/CalcolatoriElettronici/Docs/i8086_instruction_set.pdf)
- [Art of Assembly Language](https://www.plantation-productions.com/Webster/www.artofasm.com/DOS/AoA.html)
- [Assembly Language Tutorial](https://www.tutorialspoint.com/assembly_programming/index.htm)
- [Cheatsheet](https://www.cheatography.com/davechild/cheat-sheets/assembly-language/) - A quick reference for common assembly instructions
- [Shorter Cheatsheet](cheatsheet.md)- A more concise version of the cheatsheet

## Contributing

Feel free to contribute by:

1. Adding new examples
2. Improving existing code
3. Enhancing documentation
4. Fixing bugs

## License

This repository is provided for educational purposes. Please respect any included license terms.

---

_Happy coding in Assembly! Remember that mastering the fundamentals of computing architecture will make you a stronger programmer regardless of what higher-level languages you work with in the future._
