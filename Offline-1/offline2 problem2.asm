.MODEL SMALL

.STACK 100H

.DATA
    N DW 0
    NEWLINE DB 13,10,'$'

.CODE

MAIN:
    MOV AX, @DATA
    MOV DS, AX

    INPUT_N:
        MOV AH, 1
        INT 21H
        CMP AL, 13
        JZ CALCULATE
        SUB AL, '0'
        XOR AH, AH
        MOV BX, 10
        MOV CX, AX
        MOV AX, N
        MUL BX
        ADD AX, CX
        MOV N, AX
        JMP INPUT_N

    CALCULATE:
        MOV AX, N
        MOV BX, 10
        XOR DX, DX
        CALL DIGIT_SUM
        JMP PRINT_RESULT

    DIGIT_SUM PROC
        CMP AX, 0
        JE BASE_CASE
        DIV BX
        PUSH DX
        XOR DX, DX
        CALL DIGIT_SUM
        POP DX
        ADD AX, DX
        RET

    BASE_CASE:
        MOV AX, 0
        RET
    DIGIT_SUM ENDP

    PRINT_RESULT:
        MOV CX, 0
        MOV BX, 10

        CMP AX, 0
        JNE NEXT_DIGIT
        MOV DL, '0'
        MOV AH, 2
        INT 21H
        JMP END_PROGRAM
    
    NEXT_DIGIT:
        XOR DX, DX
        DIV BX
        PUSH DX
        INC CX
        CMP AX, 0
        JNZ NEXT_DIGIT

        CMP CX, 1
        JNE PRINT_LOOP
        POP DX
        ADD DL, '0'
        MOV AH, 2
        INT 21H
        JMP END_PROGRAM
        
    PRINT_LOOP:
        POP DX
        ADD DL, '0'
        MOV AH, 2
        INT 21H
        LOOP PRINT_LOOP

    END_PROGRAM:
        MOV AH, 4CH
        INT 21H

END MAIN