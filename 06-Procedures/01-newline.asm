.MODEL SMALL 
.STACK 100H 
.DATA

MSG DB 'HELLO', '$'
CR EQU 13 ; CR means carriage return, it is a constant
LF EQU 10 ; EQU means equate, it is a constant and LF means line feed 

.CODE 
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG
    MOV AH, 9 ; function to write a string to the standard output
    INT 21H
    
    CALL NEWLINE
    
    
    LEA DX, MSG
    MOV AH, 9
    INT 21H
    
    ; interrupt to exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP


NEWLINE PROC
    MOV AH, 2 ; function to write a character to the standard output
    MOV DL, CR
    INT 21H
    MOV DL, LF
    INT 21H
    RET
NEWLINE ENDP

END MAIN 

; CR -> Carriage Return (moves the cursor to the beginning of the line)
; LF -> Line Feed (moves the cursor down to the next line, doesn't effect its horizontal position)

; So, The combination of CR and LF moves the cursor to the beginning of the next line
