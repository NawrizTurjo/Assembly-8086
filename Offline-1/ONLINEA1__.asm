.MODEL SMALL

.STACK 100H

.DATA
    IN_NUM DW ?
    HASH_CNT DW ?
    NUM_CNT DW ?
    NEWLINE DW 13,10,'$'
    TEMP DW ?

.CODE

    MAIN:

    MOV AX,@DATA
    MOV DS,AX

    CALL INPUT

    SUB AL,'0'
    XOR AH,AH

    MOV IN_NUM,AX
    MOV HASH_CNT,AX
    MOV NUM_CNT,1

    CALL PRINT

    MOV AX,04CH
    INT 21H

    INPUT PROC

        MOV AH,1
        INT 21H

        RET

    INPUT ENDP

    PRINT PROC

        PR:
            CALL PRINT_NEWLINE
            CALL PRINT_HASH
            CALL PRINT_NUMS
            INC NUM_CNT
            DEC HASH_CNT

            CMP HASH_CNT,0
            JG PR

            RET

    PRINT ENDP

    PRINT_NEWLINE PROC

        MOV DX, OFFSET NEWLINE
        MOV AH,9
        INT 21H

        RET

    PRINT_NEWLINE ENDP

    PRINT_HASH PROC

        MOV TEMP,0

        PH:
            MOV AH,2
            MOV DL,'#'
            INT 21H

            INC TEMP
            MOV AX, HASH_CNT
            CMP TEMP,AX
            JL PH
            RET

    PRINT_HASH ENDP

    PRINT_NUMS PROC

        MOV TEMP,'1'

        PN:
            MOV AH,2
            MOV DX,TEMP
            INT 21H
            
            INC TEMP
            MOV BX,NUM_CNT
            ADD BX,'0'
            CMP TEMP,BX
            JLE PN
            RET

    PRINT_NUMS ENDP

    END MAIN
