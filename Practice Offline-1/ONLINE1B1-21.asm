.MODEL SMALL

.STACK 100H

.DATA 

N DW ?   
CX1 DW ? 
M DW ?  
NEWLINE DB 13,10,'$'  
ARR DB 4, 2, 7, 15, 1, 9, 3, 6, 10, 13

.CODE

MAIN PROC  
     
; TO INITIALIZE DATA SEGMENT    
MOV AX, @DATA
MOV DS, AX   
 
LEA SI, ARR 
MOV CX, 10   
MOV BH, 0
    
ACCESS1:
   MOV  AL, [SI]
   CMP BH, AL
   JG ELSE1   
   THEN1:
   MOV BH, AL 
   ELSE1:
   INC SI
   LOOP ACCESS1

;MOV AL, BH
;XOR AH, AH
;CALL PRINT_NUMBER 

LEA SI, ARR 
MOV CX, 10   
MOV BL, [SI] ; load first element into BL

ACCESS2:  
   MOV  AL, [SI]
   CMP AL, BH
   JE ELSE2 
   CMP BL, AL
   JG ELSE2 
   MOV BL, AL
   ELSE2:
   INC SI
   LOOP ACCESS2 
   
MOV AL, BL
XOR AH, AH
CALL PRINT_NUMBER
    

; TO EXIT
MOV AH, 4CH
INT 21H
    

MAIN ENDP

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