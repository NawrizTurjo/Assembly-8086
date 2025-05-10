.MODEL SMALL
.DATA
      
      
MSG DB 'ACTIVATION RECORD  $'
.CODE

MAIN PROC 
    
   MOV AX,@DATA
   MOV DS,AX
    
   MOV AH,1
   INT 21H
;    AND AL,0FH ; AL=0-15 -> VUULLL
    SUB AL,'0' ; AL=0-9
;    MOV AH,0 ; CLEAR AH
    XOR AH,AH
   MOV BX,AX   ;N 
           
   CALL NEWLINE
   
   MOV AH,1
   INT 21H
;    AND AL,0FH ; AL=0-15
    SUB AL,'0' ; AL=0-9
;    MOV AH,0  ; CLEAR AH
    XOR AH,AH             
   MOV CX,AX    ;R      
   
   CALL NEWLINE
   
   
   PUSH BX ;N
   PUSH CX ;R
   
   XOR DX,DX ; CLEAR  
   CALL NCR     
   MOV DX,AX

    CALL PRINT_NUMBER

   MOV AH,4CH
   INT 21H
   
   
 
   
MAIN ENDP   




NCR PROC  
   PUSH BP
   MOV BP,SP 
    
    
;    PUSH AX 
   
   ; PRINT THE MESSAGES
   LEA DX,MSG
   MOV AH,09H
   INT 21H
    
    ;PRINT N
   MOV AH,2
   MOV DL ,[BP+6] ; +6 is the FIRST argument N
   ADD DL,'0'
   INT 21H 
   
   ;PRINT C
   MOV DL ,067
   INT 21H 
     
   ; PRINT R
   MOV DL ,[BP+4] ; +4 is the SECOND argument R
   ADD DL,'0'
   INT 21H
   

;    POP AX ; CLEAR AX
    
   CALL NEWLINE

   ;;;;....MAIN CONDITIONING STARTS HERE....;;;;

   
    
   CMP [BP+4],0 ; R==0
   JE BASE 
   
   MOV AX,[BP+4] ; AX=R
   CMP AX,[BP+6] ; N==R
   JE BASE

   
RECURSIVE:
   MOV AX,[BP+6] ; AX=N
   DEC AX ; N-1
   PUSH AX ; PUSH FOR (N-1)C(R-1)
   
   
   MOV AX,[BP+4] ; AX=R
   DEC AX ; R-1
   PUSH AX ; PUSH FOR (N-1)C(R-1)
   
   CALL NCR ; RECURSIVE CALL
   
   MOV DX,AX ; DX = (N-1)C(R-1)
   PUSH DX ; PUSH FOR ADDING WITH (N-1)C(R)
   
   MOV AX,[BP+6] ; AX = N
   DEC AX ; N-1
   PUSH AX ; PUSH FOR (N-1)C(R)
   
   
   MOV AX,[BP+4]  ;; AX = R
   PUSH AX ;; PUSH FOR (N-1)C(R)
   
   CALL NCR   
   POP DX ;; POP FOR (N-1)C(R)
   ADD AX,DX ; VALUE WILL STORE IN AX

   JMP RETURN
      
      
    


BASE: MOV AX,1
      JMP RETURN



RETURN: POP BP
        RET 4
NCR ENDP


NEWLINE PROC 
    PUSH AX
    PUSH DX  
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV AH,2
    MOV DL,10
    INT 21H 
    POP DX
    POP AX 
    RET
NEWLINE ENDP 

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