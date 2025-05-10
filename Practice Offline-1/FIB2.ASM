GETFIB PROC
    PUSH BP
    MOV BP, SP

    CMP WORD PTR [BP+4],1
    JG ENDIF

    MOV AX, WORD PTR[BP+4] ;BASE CASE
    JMP RETURN

ENDIF:
    ; F(n-1)
    MOV CX, [BP+4]
    DEC CX
    PUSH CX
    CALL GETFIB
    PUSH AX           ; save F(n-1) result in stack

    ; F(n-2)
    MOV CX, [BP+4]    ; load original n again
    SUB CX, 2         ; now CX = n-2
    PUSH CX
    CALL GETFIB       ; result in AX = F(n-2)

    POP DX            ; get F(n-1)
    ADD AX, DX        ; AX = F(n-1) + F(n-2)

RETURN:
    POP BP
    RET 2
GETFIB ENDP