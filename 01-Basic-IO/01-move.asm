.MODEL SMALL 
.STACK 100H 
.DATA

.CODE 
MAIN PROC 
 MOV AX, 1 ;; set AX to 1
 MOV BX, 2H ;; set BX to 2H      
 MOV AX, BX ;; move the value in BX to AX
  
 ; interrupt to exit
 MOV AH, 4CH ;; set AH to 4CH=76 (terminate program)
 INT 21H ;; call DOS interrupt 21H to terminate the program
  
MAIN ENDP 
END MAIN 


