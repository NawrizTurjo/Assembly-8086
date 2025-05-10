.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter n (1 to 9): $'
    MSG2 DB 'Fibonacci number is: $'
    NEWLINE DB 13, 10, '$'
    DIGIT DB 0

.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt for input
    LEA DX, MSG1
    MOV AH, 9
    INT 21H

    ; Read character input
    MOV AH, 1
    INT 21H
    SUB AL, '0'           ; Convert ASCII to integer
    MOV DIGIT, AL

    ; Call recursive Fibonacci function
    MOV AL, DIGIT
    CALL FIB              ; Result in AX

    ; Print newline
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H

    ; Print message
    LEA DX, MSG2
    MOV AH, 9
    INT 21H

    ; Print result in AX
    CALL PRINT_NUM

    ; Exit
    MOV AH, 4CH
    INT 21H

;----------------------------------
; Recursive Fibonacci: input in AL
; Output: AX = fib(n)
;----------------------------------
FIB:
    PUSH CX        ; Save registers
    PUSH BX
    
    CMP AL, 0      ; Check base cases
    JE FIB_ZERO
    CMP AL, 1
    JE FIB_ONE

    MOV BL, AL     ; Save n in BL for later use
    
    ; Compute fib(n-1)
    DEC AL
    CALL FIB
    MOV CX, AX     ; Save fib(n-1) in CX
    
    ; Compute fib(n-2)
    MOV AL, BL     ; Restore original n
    SUB AL, 2      ; Compute n-2
    CALL FIB
    
    ; AX = fib(n-2), CX = fib(n-1)
    ADD AX, CX     ; fib(n) = fib(n-1) + fib(n-2)
    JMP FIB_DONE

FIB_ZERO:
    MOV AX, 0
    JMP FIB_DONE

FIB_ONE:
    MOV AX, 1

FIB_DONE:
    POP BX         ; Restore registers
    POP CX
    RET

;----------------------------------
; Print AX as decimal
;----------------------------------
PRINT_NUM:
    ; Use a more general approach for printing
    MOV BX, 10     ; Divisor
    XOR CX, CX     ; Counter for digits
    
    ; First, break AX into individual digits
DIGIT_LOOP:
    XOR DX, DX     ; Clear DX for division
    DIV BX         ; AX/10: Quotient in AX, Remainder in DX
    PUSH DX        ; Save remainder (digit)
    INC CX         ; Count digits
    TEST AX, AX    ; Check if quotient is 0
    JNZ DIGIT_LOOP ; Continue if more digits
    
    ; Now print digits in reverse order (from stack)
PRINT_LOOP:
    POP DX         ; Get digit
    ADD DL, '0'    ; Convert to ASCII
    MOV AH, 2      ; DOS print character function
    INT 21H
    LOOP PRINT_LOOP
    
    RET

END MAIN