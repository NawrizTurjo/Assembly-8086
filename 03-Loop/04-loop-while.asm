.MODEL SMALL

.STACK 100H

.DATA  
     
.CODE

MAIN PROC
        
    MOV 	DX, 0	; DX counts the characters
	MOV 	AH, 1	; read char function
	INT 	21h	; read a char in AL
	
	WHILE_: 

		CMP 	AL, 0DH	; CR? (carriage return)
		JE 	END_WHILE
		INC	DX ;; increment DX (counting the characters)
		INT 	21h
		JMP 	WHILE_     
		
	END_WHILE:

    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP 

END MAIN
