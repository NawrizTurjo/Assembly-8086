.MODEL SMALL

.STACK 100H

.DATA

    ARR DB 4, 2, 7, 15, 1, 9, 3, 6, 10, 13
    NEWLINE DB 13,10,'$'
    MAXVAL DB ?
    SECMAX DB ?
    


.CODE

    MAIN:
    
    MOV AX,@DATA
    MOV DS,AX

    MOV SI, OFFSET ARR
    MOV CX,10
    MOV BH, [SI]
    MOV MAXVAL, BH

    FIRST:
        MOV AL,[SI]
        CMP AL, MAXVAL
        JLE ELSE1
        MOV MAXVAL,AL

        ELSE1:
            INC SI
        LOOP FIRST
    
    MOV SI, OFFSET ARR
    MOV CX, 10
    MOV BH, [SI]
    MOV SECMAX, BH

    SECOND:
        MOV AL,[SI]
        CMP AL, MAXVAL
        JE ELSE2              ; Skip if element equals maximum
        CMP AL, SECMAX
        JLE ELSE2             ; Skip if not greater than current SECMAX
        MOV SECMAX, AL        ; Update SECMAX with larger value
        ELSE2:
            INC SI
        LOOP SECOND
    
    MOV AL, SECMAX
    XOR AH,AH
    CALL PRINT_NUMBER

    MOV AH, 4CH
    INT 21H
    
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




    END MAIN