.MODEL SMALL
.STACK 100H

.DATA
    PROMPT DB 'Enter n (1-9): $'
    NEWLINE DB 13, 10, '$'
    DIGIT DB 0

.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    ; Print prompt
    LEA DX, PROMPT
    MOV AH, 9
    INT 21H

    ; Take input character
    MOV AH, 1
    INT 21H
    SUB AL, '0'         ; Convert ASCII to number
    MOV DIGIT, AL

    XOR CH, CH          ; Clear CH for loop

    ; Outer loop: for i = 1 to n
    MOV CL, 1

OUTER_LOOP:
    ; Print n - i '#' characters
    MOV AL, DIGIT
    SUB AL, CL          ; AL = n - i
    MOV BL, AL          ; BL = count of '#'

PRINT_HASH:
    CMP BL, 0
    JE PRINT_NUMS
    MOV DL, '#'
    MOV AH, 2
    INT 21H
    DEC BL
    JMP PRINT_HASH

PRINT_NUMS:
    MOV BH, 1           ; BH = number to print from 1 to i

NUM_LOOP:
    MOV DL, BH
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    INC BH
    CMP BH, CL
    JG NEW_LINE
    JMP NUM_LOOP

NEW_LINE:
    ; Print newline
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H

    ; Increment row counter
    INC CL
    CMP CL, DIGIT
    JA END_PROGRAM
    JMP OUTER_LOOP

END_PROGRAM:
    MOV AH, 4CH
    INT 21H

END MAIN
