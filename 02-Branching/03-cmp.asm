.MODEL SMALL 
.STACK 100H 
.DATA

.CODE 
MAIN PROC 
    
    MOV CX, 0 ;; Initialize CX to 0
    
    MOV AX, 2 ;; Load AX with 2
    CMP AX, 2 ;; Compare AX with 2
    JE EQUAL ;; Jump to EQUAL if equal
    
    MOV CX, 1 ;; Set CX to 1 if not equal
    
    EQUAL:
    
        MOV AX, 4 ;; Load AX with 4
        MOV BX, 3 ;; Load BX with 3
        CMP AX, BX ;; Compare AX with BX
        JG GREATER ;; Jump to GREATER if AX is greater than BX
        
        MOV CX, 1 ;; Set CX to 1 if AX is not greater than BX
    
    GREATER:
    
        MOV AX, 4 ;; Load AX with 4 again
        MOV BX, 3 ;; Load BX with 3 again
        CMP AX, BX  ;; Compare AX with BX again
        JL LOWER ;; Jump to LOWER if AX is less than BX
        
        MOV CX, 1 ;; Set CX to 1 if AX is not less than BX
    
    LOWER:
        MOV CX, 2 ;; Set CX to 2 if AX is less than BX
	
	; interrupt to exit
    MOV AH, 4CH
    INT 21H
    
  
MAIN ENDP 
END MAIN 


