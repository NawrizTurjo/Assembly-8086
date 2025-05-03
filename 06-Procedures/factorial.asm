;-----------------------------------------------------------------------------
; FACTORIAL.ASM - Recursive factorial calculation program
;
; Description:
;   This program demonstrates recursive function implementation in 8086 assembly
;   by calculating the factorial of a number using a stack-based approach.
;   The program calculates 3! (factorial of 3) which equals 6.
;
; Algorithm:
;   - Factorial is implemented recursively with the formula:
;     factorial(n) = n * factorial(n-1)
;     factorial(0) = factorial(1) = 1  (base case)
;
; Procedures:
;   MAIN      - Entry point, sets up factorial calculation with n=3
;   FACTORIAL - Recursive procedure that calculates n!
;
; Register usage:
;   AX - Used to store factorial return value
;   BX - Used to store final result (not used further)
;   CX - Used for temporary storage of n-1
;   BP - Stack frame pointer for parameter access
;
; Stack usage:
;   - Each recursive call pushes BP and the parameter (n-1)
;   - Maximum stack depth is proportional to input value
;
; Notes:
;   - The program can calculate factorials up to a limit based on 16-bit registers
;   - The code assumes inputs are small enough to avoid overflow
;   - BYTE1 and BYTE2 are defined in data segment but not used in the program
;
; Author: Unknown
; Date: Unknown
;-----------------------------------------------------------------------------
.MODEL SMALL
.STACK 100H

.DATA
BYTE1  DB 0FAH
BYTE2  DB 0AEH

.CODE

MAIN  PROC 
    
    MOV     AX,3
    PUSH    AX          ; 1) push the argument n=3
    CALL    FACTORIAL   ; 2) call FACTORIAL(n)
    MOV     BX,AX       ; 3) optionally save result in BX
    MOV     AH,4CH
    INT     21H         ; 4) terminate program

MAIN ENDP
              
              
FACTORIAL PROC NEAR 
    
    PUSH    BP          ; 1) prologue: save old BP
    MOV     BP,SP       ;    create stack frame

    ;——— base‑case test: if n ≤ 1 return 1 ———
    CMP     WORD PTR [BP+4], 1  
    JG      RECURSE       ; if n > 1, jump to recursion case
    MOV     AX,1         ; else (n ≤ 1) set return value AX=1
    JMP     RETURN_POINT ; skip the recursive case

RECURSE:
    MOV     CX, [BP+4]   ; CX = n
    DEC     CX           ; CX = n – 1
    PUSH    CX           ; push (n–1) as the new argument
    CALL    FACTORIAL    ; AX = factorial(n–1)
    ; now multiply AX * n:
    MUL     WORD PTR [BP+4]  
        ; MUL   uses AX * operand → result in DX:AX
        ; since n<16 and factorial small, DX will stay 0,
        ; and the product ends up in AX

RETURN_POINT:
    POP     BP           ; 2) epilogue: restore old BP
    RET     2            ; 3) return, and clean up 2‑byte argument

FACTORIAL ENDP
END MAIN
