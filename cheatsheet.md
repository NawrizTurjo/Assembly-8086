# 8086 Assembly Language Cheatsheet

## Registers

### General Purpose Registers (16-bit)
- **AX** (Accumulator): Primary for arithmetic, I/O operations
  - **AH**: High byte (8-bit)
  - **AL**: Low byte (8-bit)
- **BX** (Base): Memory addressing, pointer to data
  - **BH**: High byte
  - **BL**: Low byte
- **CX** (Counter): Loop and string operations
  - **CH**: High byte
  - **CL**: Low byte
- **DX** (Data): I/O ports, multiply/divide operations
  - **DH**: High byte
  - **DL**: Low byte

### Index and Pointer Registers
- **SI** (Source Index): String operations source
- **DI** (Destination Index): String operations destination
- **BP** (Base Pointer): Accessing parameters and local variables
- **SP** (Stack Pointer): Points to top of stack

### Segment Registers
- **CS** (Code Segment): Location of code
- **DS** (Data Segment): Location of data
- **SS** (Stack Segment): Location of stack
- **ES** (Extra Segment): Additional data segment

### Special Registers
- **IP** (Instruction Pointer): Next instruction to execute
- **FLAGS**: Status and control flags
  - **ZF** (Zero Flag): Set if result is zero
  - **CF** (Carry Flag): Set if operation produces a carry
  - **SF** (Sign Flag): Set if result is negative
  - **OF** (Overflow Flag): Set if arithmetic overflow

## Data Declaration

### Basic Data Types
```assembly
variable_name DB value    ; Define Byte (8-bit)
variable_name DW value    ; Define Word (16-bit)
variable_name DD value    ; Define Doubleword (32-bit)
```

### Examples
```assembly
number DB 42              ; Single byte with value 42
count DW 1000             ; Word (2 bytes) with value 1000
message DB 'Hello$'       ; String ($ marks end for DOS display)
array DB 10, 20, 30, 40   ; Array of bytes
buffer DB 100 DUP(?)      ; 100 uninitialized bytes
matrix DW 3 DUP(3 DUP(0)) ; 3x3 word matrix initialized to 0
```

## Memory Addressing Modes

### Direct
```assembly
MOV AL, [1234H]           ; Load AL from memory address 1234H
```

### Register
```assembly
MOV AX, BX                ; Copy BX to AX
```

### Immediate
```assembly
MOV CX, 25                ; Set CX to 25
```

### Register Indirect
```assembly
MOV AL, [BX]              ; Load AL from address in BX
```

### Based
```assembly
MOV CL, [BP+2]            ; Load CL from BP+2 (often for stack access)
```

### Indexed
```assembly
MOV DL, [SI+4]            ; Load DL from SI+4
```

### Based-Indexed
```assembly
MOV AH, [BX+DI+6]         ; Load AH from BX+DI+6
```

## Common Instructions

### Data Movement
```assembly
MOV dest, src             ; Move data from source to destination
PUSH reg/mem              ; Push onto stack
POP reg/mem               ; Pop from stack
XCHG reg, reg/mem         ; Exchange data
LEA reg, mem              ; Load Effective Address
```

### Arithmetic
```assembly
ADD dest, src             ; Addition
SUB dest, src             ; Subtraction
MUL reg/mem               ; Unsigned multiply
DIV reg/mem               ; Unsigned divide
INC reg/mem               ; Increment
DEC reg/mem               ; Decrement
NEG reg/mem               ; Negate (two's complement)
```

### Logical
```assembly
AND dest, src             ; Logical AND
OR dest, src              ; Logical OR
XOR dest, src             ; Logical XOR
NOT reg/mem               ; Logical NOT
SHL/SAL reg/mem, count    ; Shift left
SHR reg/mem, count        ; Shift right (logical)
SAR reg/mem, count        ; Shift right (arithmetic)
```

### Control Flow
```assembly
JMP label                 ; Unconditional jump
JZ/JE label               ; Jump if zero/equal
JNZ/JNE label             ; Jump if not zero/not equal
JG/JNLE label             ; Jump if greater (signed)
JL/JNGE label             ; Jump if less (signed)
CALL procedure            ; Call procedure
RET                       ; Return from procedure
LOOP label                ; Decrement CX and jump if CX≠0
```

## Procedures

### Basic Procedure
```assembly
PROCEDURE_NAME PROC
    ; Procedure body
    RET
PROCEDURE_NAME ENDP
```

### With Parameters (Stack Based)
```assembly
; Call site
PUSH param2               ; Parameters pushed in reverse order
PUSH param1
CALL MY_PROC
ADD SP, 4                 ; Clean up stack (caller's responsibility)

; Procedure definition
MY_PROC PROC
    PUSH BP               ; Save base pointer
    MOV BP, SP            ; Set new base pointer
    
    ; Access parameters
    ; [BP+4] is param1, [BP+6] is param2
    
    POP BP                ; Restore base pointer
    RET
MY_PROC ENDP
```

## Recursive Procedure Template

```assembly
RECURSIVE_PROC PROC
    ; 1. Setup stack frame
    PUSH BP
    MOV BP, SP
    
    ; 2. Save registers that will be modified
    PUSH AX
    PUSH BX
    PUSH CX
    
    ; 3. Check base case
    CMP parameter, base_case_value
    JE BASE_CASE
    
    ; 4. Prepare for recursive call
    ; Modify parameters for next call
    PUSH new_parameter
    CALL RECURSIVE_PROC
    ADD SP, 2             ; Clean up parameter
    
    ; 5. Process result of recursive call
    ; (Result often in AX)
    
    JMP DONE
    
BASE_CASE:
    ; Handle base case
    
DONE:
    ; 6. Restore registers in reverse order
    POP CX
    POP BX
    POP AX
    
    ; 7. Restore stack frame
    POP BP
    RET
RECURSIVE_PROC ENDP
```

## I/O Operations (INT 21H)

### Input
```assembly
; Read single character (echoed)
MOV AH, 1
INT 21H                   ; Character returned in AL

; Read single character (not echoed)
MOV AH, 8
INT 21H                   ; Character returned in AL

; Read string
MOV AH, 0AH
LEA DX, buffer            ; Buffer format: max-size, actual-size, string
INT 21H
```

### Output
```assembly
; Display character
MOV AH, 2
MOV DL, 'A'               ; Character to display
INT 21H

; Display string (ending with $)
MOV AH, 9
LEA DX, message           ; Message must end with $
INT 21H
```

## Number Conversion

### Display a Number (in decimal)
```assembly
DISPLAY_NUM PROC
    ; Input: AX = number to display
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR CX, CX            ; Initialize digit counter
    MOV BX, 10            ; Divisor
    
DIVIDE_LOOP:
    XOR DX, DX            ; Clear remainder
    DIV BX                ; AX/10: Quotient in AX, Remainder in DX
    PUSH DX               ; Save digit
    INC CX                ; Count digit
    TEST AX, AX           ; Check if quotient is zero
    JNZ DIVIDE_LOOP       ; Continue if more digits
    
DISPLAY_LOOP:
    POP DX                ; Get digit
    ADD DL, '0'           ; Convert to ASCII
    MOV AH, 2             ; Display function
    INT 21H
    LOOP DISPLAY_LOOP     ; Repeat for all digits
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_NUM ENDP
```

## Common Debugging Tips

1. **Check Register Values**: Monitor register values after each operation
2. **Validate Stack**: Ensure balanced PUSH/POP operations
3. **Verify Memory Accesses**: Double-check memory addressing calculations
4. **Use Step-By-Step**: Trace execution one instruction at a time
5. **Watch Flag Register**: Observe how flags change after comparisons

## Recursion Tips

1. **Always Check Base Case First**: Handle termination condition before recursion
2. **Save All Modified Registers**: Push/pop any registers you change
3. **Manage Stack Properly**: Track parameters and return addresses
4. **Keep Track of Stack Space**: Deep recursion can cause stack overflow
5. **Use BP for Parameter Access**: Create stack frames with BP for reliable parameter access

## Common DOS INT 21H Functions

| AH Value | Function |
|----------|----------|
| 01H      | Character Input with Echo |
| 02H      | Character Output |
| 08H      | Character Input without Echo |
| 09H      | Display String |
| 0AH      | Buffered String Input |
| 3CH      | Create File |
| 3DH      | Open File |
| 3EH      | Close File |
| 3FH      | Read from File |
| 40H      | Write to File |
| 4CH      | Terminate Program |

---

*This cheatsheet is meant as a quick reference. Always refer to comprehensive documentation for detailed information.*