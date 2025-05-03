.MODEL SMALL 
.STACK 100H 
.DATA

NUMBER_STRING DB '00000$'

.CODE 
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    
    MOV AX, 12345
    CALL PRINT
    
    ; interrupt to exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP


PRINT PROC
    
    LEA SI, NUMBER_STRING ; SI points to the string
    ADD SI, 5 ; SI points to the end of the string (5 characters + '$')
    
    PRINT_LOOP:
        DEC SI ; move SI to the previous character
        
        MOV DX, 0 ; clear DX before dividing AX by 10
        ; DX:AX = 0000:AX
        
        MOV CX, 10 ; divide by 10
        DIV CX ; DX = AX mod 10, AX = AX / 10
        
        ADD DL, '0' ; convert the remainder to ASCII
        MOV [SI], DL ; store the ASCII character of remainder in the string
        
        CMP AX, 0 ; check if AX is 0
        JNE PRINT_LOOP ; if not, continue the loop
        ; if AX is 0, we have finished converting the number
        ; SI points to the first character of the string
    
    MOV DX, SI ; DX points to the first character of the string
    MOV AH, 9 ; function to write a string to the standard output
    INT 21H
    
    RET

PRINT ENDP

END MAIN 


