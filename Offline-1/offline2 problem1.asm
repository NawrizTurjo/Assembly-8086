.MODEL SMALL

.STACK 100H

.DATA
    N DW 0
    K DW 0
    T DW 0
    W DW 0
    NEWLINE DB 13,10,'$'
    
.CODE

MAIN:
    MOV AX, @DATA
    MOV DS, AX

    INPUT_N:
        MOV AH, 1
        INT 21H
        CMP AL, 32
        JZ INPUT_K
        SUB AL, '0'
        XOR AH, AH
        MOV BX, 10
        MOV CX, AX
        MOV AX, N
        MUL BX
        ADD AX, CX
        MOV N, AX
        JMP INPUT_N

    INPUT_K:
        MOV AH, 1
        INT 21H
        CMP AL, 13
        JZ CALCULATE
        SUB AL, '0'
        XOR AH, AH
        MOV BX, 10
        MOV CX, AX
        MOV AX, K
        MUL BX
        ADD AX, CX
        MOV K, AX
        JMP INPUT_K

    CALCULATE:
        MOV DX, OFFSET NEWLINE
        MOV AH, 9
        INT 21H

        XOR AX, AX
        XOR BX, BX
        XOR CX, CX
        XOR DX, DX

        MOV AX, N
        MOV BX, K
        MOV T, AX
        MOV W, AX

    TOTAL:
        MOV AX, W
        CMP AX, BX
        JL PRINT_RESULT
        XOR DX, DX
        DIV BX
        ADD T, AX
        ADD AX, DX
        MOV W, AX
        JMP TOTAL

    PRINT_RESULT:
        MOV CX, 0
        MOV BX, 10
        MOV AX, T
    
    NEXT_DIGIT:
        XOR DX, DX
        DIV BX
        PUSH DX
        INC CX
        CMP AX, 0
        JNZ NEXT_DIGIT
        
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