.MODEL SMALL

.STACK 100h

.DATA 
    ARR DB 1,2,3,4,5
    CNT DB 3
    NEWLINE DB 13,10,'$'
    I DB 4

.CODE
    MOV AX, @DATA
    MOV DS,AX

    MOV SI, OFFSET ARR
    ADD SI, 4
    MOV DI, SI

    MOV SI, OFFSET ARR
    ; SI HAS START AND DI HAS END VALUE

    MOV CL,CNT
    XOR CH, CH

    LOP:
        MOV AL, [SI]
        MOV BL, [DI]
        MOV [DI], AL
        MOV [SI], BL
        INC SI
        DEC DI
        LOOP LOP

    ; MOV CX,4
    MOV SI, OFFSET ARR
    LOP_:
        MOV AL, [SI]
        XOR AH, AH
        CALL PRINT_NUMBER
        INC SI
        CMP I,0
        JZ END__
        ; LOOP LOP_
        DEC I
        JMP LOP_
    END__:
        CALL END_PROGRAM
        
        
    
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

    ; INPUT_CHAR PROC
    ;     MOV AH, 1
    ;     INT 21H
    ;     RET
    ; INPUT_CHAR ENDP

    ; OUTPUT_CHAR PROC
    ;     MOV AH, 2
    ;     MOV DL, '#'
    ;     INT 21H
    ;     RET
    ; OUTPUT_CHAR ENDP

    ; DISPLAY_STRING PROC
    ;     MOV AH, 9
    ;     MOV DX, OFFSET STRING
    ;     INT 21H
    ;     RET
    ; DISPLAY_STRING ENDP

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