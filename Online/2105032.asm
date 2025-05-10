.MODEL SMALL

.STACK 100H

.DATA
    SIZE DB ?
    ;ARR DB DUP(5)
    ; ARR DB ?
    KEY DB ?
    ANS DB 0
    NEWLINE DB 13,10,'$'
    I DB ?

.CODE

    MOV AH,1
    INT 21H
    XOR AH,AH
    SUB AL,'0'
    
    MOV SIZE, AL
    MOV I,AL
    ; MOV SI, OFFSET ARR
    
    LOP1:
        MOV AH,1
        INT 21H
        SUB AL,'0'
        ; MOV [SI], AL
        XOR AH,AH
        PUSH AX
        
        CMP I, 1
        JE OUT1
        DEC I
        ; INC SI
        JMP LOP1
    
    OUT1:
        ; KEY INPUT
        MOV AH,1
        INT 21H
        
        SUB AL,'0'
        XOR AH,AH
        
        MOV KEY,AL
        
    ; MOV SI, OFFSET ARR
    
    MOV CL,SIZE
    XOR CH,CH
    
    MOV I, AL
    MOV BL,KEY
    XOR BH,BH
    
    COMP:
        ; MOV AL, [SI]
        ; CMP BL,AL
        
        POP AX
        CMP BX,AX
        JNE NOT_EQUAL
        ADD ANS,1
        
        NOT_EQUAL:
            INC SI
        LOOP COMP
    
    ;MOV BL,ANS
    ;XOR BH,BH
    
    MOV DL,ANS
    XOR DH,DH
    MOV AH,9
    INT 21H
    
    RETURN_:
        MOV AH, 4CH                                                                           
        INT 21H
    

