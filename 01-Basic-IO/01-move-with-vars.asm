.MODEL SMALL ;small memory model
.STACK 100H ;;100H=256 bytes of stack space

.DATA ;; data segment
FOO DB 10 ; define a byte variable FOO with value 10
BAR DW 200 ; define a word variable BAR with value 200

.CODE ;; code segment
MAIN PROC ;; main procedure
    ; load data segment address
    MOV AX, @DATA ;; load address of data segment into AX
    MOV DS, AX ;; move address from AX to DS
     
    MOV AX, BAR ; load BAR into AX
    
    MOV BL, 1 ; set BL to 1
    MOV BH, 2 ; set BH to 2
    MOV BAR, BX ; move the value in BX to BAR
  
    MOV AH,2;
    MOV DX,BAR;
    INT 21H ; call DOS interrupt 21H to display the value in DL (BAR)

    MOV AH,2;
    MOV DL, FOO ; load FOO into AL
    INT 21H ; call DOS interrupt 21H to display the value in AL (FOO)
  
    ; interrupt to exit
    MOV AH, 4CH ;; set AH to 4CH=76 (terminate program)
    INT 21H ;; call DOS interrupt 21H to terminate the program
  
MAIN ENDP 
END MAIN 


