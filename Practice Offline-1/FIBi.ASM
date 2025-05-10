.MODEL SMALL

.STACK 100h

.DATA
    NEWLINE DB 13,10,'$'
    

.CODE
    MOV AX, @DATA
    MOV DS,AX

    MOV AH,1
    INT 21H
    SUB AL,'0'
    XOR AH,AH

    FIB_F PROC

        PUCH BP
        MOV BP,SP

        

    FIB_F ENDP



    
    PRINT_NUMBER PROC
        MOV BX, 10
        XOR CX, CX

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

        RET
    PRINT_NUMBER ENDP

    INPUT_CHAR PROC
        MOV AH, 1
        INT 21H
        RET
    INPUT_CHAR ENDP

    OUTPUT_CHAR PROC
        MOV AH, 2
        MOV DL, '#'
        INT 21H
        RET
    OUTPUT_CHAR ENDP

    DISPLAY_STRING PROC
        MOV AH, 9
        MOV DX, OFFSET STRING
        INT 21H
        RET
    DISPLAY_STRING ENDP

    END_PROGRAM PROC
        MOV AX, 4CH
        INT 21H
        RET
    END_PROGRAM ENDP

    PRINT_NEWLINE PROC
        MOV AH, 9
        MOV DX, OFFSET NEWLINE
        INT 21H
        RET
    PRINT_NEWLINE ENDP