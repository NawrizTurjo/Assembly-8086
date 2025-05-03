.MODEL SMALL

.STACK 100H

.DATA 

N DW ?   
CX1 DW ? 
M DW ?  
NEWLINE DB 13,10,'$'

.CODE

MAIN PROC  
     
    ; TO INITIALIZE DATA SEGMENT    
    MOV AX, @DATA
    MOV DS, AX

    

    MOV AH, 1
    INT 21H
    SUB AL, '0'
    XOR AH, AH
    MOV CX, AX
    ; MOV N, AX
    MOV BX, 1  

    PRINT:

    MOV DX, OFFSET NEWLINE 
    MOV AH, 9
    INT 21H
    CALL PRINTH
    CALL PRINTN 
    INC BX
    DEC CX 

    JNZ PRINT


    ; TO EXIT
    MOV AH, 4CH
    INT 21H
    
    
MAIN ENDP

PRINTH PROC
    MOV CX1, CX

    HEREH:
    MOV AH, 2
    MOV DL, '#'  
    INT 21H
    DEC CX1
    CMP CX1, 0
    JG HEREH
    RET  

    
PRINTH ENDP   


PRINTN PROC    
          
    MOV  DL, 49 
    MOV  CX1, 1

    HEREN: 
    MOV AH, 2
    INT 21H  
    INC CX1
    INC DL
    CMP BX, CX1
    JGE HEREN 
    RET

       
PRINTN ENDP

END MAIN