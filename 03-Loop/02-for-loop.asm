.MODEL SMALL 
.STACK 100H 
.DATA
.CODE 
MAIN PROC 
    MOV AX, 1  ; initialize AX to 1
    
    MOV CX, 10 ; loop 10 times
    TOP:
        SHL AX, 1   ; shift left
        LOOP TOP  ; each time CX is decremented by 1, and if CX != 0, jump to TOP
    ; at the end of the loop, AX = 2^10 = 1024 (or 0400H)
	; interrupt to exit
    MOV AH, 4CH
    INT 21H
    
  
MAIN ENDP 
END MAIN 


