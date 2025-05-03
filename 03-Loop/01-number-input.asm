.MODEL SMALL 

.STACK 100H 

.DATA
    N DW ?              ; Declare a word variable 'N' to store the result
    CR EQU 0DH          ; Define constant 'CR' (carriage return, 0x0D)
    LF EQU 0AH          ; Define constant 'LF' (line feed, 0x0A)


.CODE 

MAIN PROC 

    MOV AX, @DATA
    MOV DS, AX
    
    ; fast BX = 0, faster than {MOV BX, 0}
    XOR BX, BX
    
    INPUT_LOOP:
        ; char input 
        MOV AH, 1
        INT 21H
        
        ; if \n\r, stop taking input
        CMP AL, CR  ; CR means carriage return (Enter key)  
        JE END_INPUT_LOOP
        CMP AL, LF ; LF means line feed (Enter key)
        JE END_INPUT_LOOP
        
        ; fast char to digit
        ; also clears AH
        AND AX, 000FH
        
        ; save AX 
        MOV CX, AX
        
        ; BX = BX * 10 + AX 
        MOV AX, 10
        MUL BX
        ADD AX, CX
        MOV BX, AX
        JMP INPUT_LOOP
        
    END_INPUT_LOOP:

    MOV N, BX
    
    ; printing CR and LF
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV DL, LF
    INT 21H  

	; interrupt to exit
    MOV AH, 4CH
    INT 21H
    
  
MAIN ENDP 
END MAIN 


