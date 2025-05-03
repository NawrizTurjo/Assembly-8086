.MODEL SMALL

.STACK 100H

.DATA
    INPUT DB ?
    NEWLINE DB 13,10,'$' ; CR and LF for new line
    NOT_DIGIT_CHECK_UPPER_MSG DB 'Uppercase letter$'
    NOT_UPPER_CHECK_LOWER_MSG DB 'Lowercase letter$'
    DIGIT_MSG DB 'Number$'
    INVALID_MSG DB 'Not an alphanumeric value$'

.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 1 ; Function to read a character from standard input
    INT 21H

    MOV INPUT, AL ; Store the input character in INPUT variable
    CMP INPUT, '0'
    JB NOT_DIGIT_CHECK_UPPER ; Check if less than '0', if so, it's not a digit, go to NOT_DIGIT_CHECK_UPPER
    CMP INPUT, '9'
    JA NOT_DIGIT_CHECK_UPPER

    MOV DX, OFFSET DIGIT_MSG
    MOV AH, 9
    INT 21H
    JMP END_PROGRAM

    NOT_DIGIT_CHECK_UPPER: ; checks for NOT_DIGIT_CHECK_uppercase letters
        CMP INPUT, 'A'
        JB NOT_UPPER_CHECK_LOWER ; Check if less than 'A', if so, go to NOT_UPPER_CHECK_LOWER
        CMP INPUT, 'Z'
        JA NOT_UPPER_CHECK_LOWER ; Check if greater than 'Z', if so, go to NOT_UPPER_CHECK_LOWER

        
        CALL PRINT_NEWLINE ; Jump to print new line
        MOV DX, OFFSET NOT_DIGIT_CHECK_UPPER_MSG
        MOV AH, 9
        INT 21H
        JMP END_PROGRAM

    NOT_UPPER_CHECK_LOWER:
        CMP INPUT, 'a'
        JB INVALID
        CMP INPUT, 'z'
        JA INVALID

        
        CALL PRINT_NEWLINE ; Jump to print new line
        MOV DX, OFFSET NOT_UPPER_CHECK_LOWER_MSG
        MOV AH, 9
        INT 21H
        JMP END_PROGRAM
    
    INVALID:
        
        CALL PRINT_NEWLINE ; Jump to print new line
        MOV DX, OFFSET INVALID_MSG
        MOV AH, 9
        INT 21H
        JMP END_PROGRAM

    END_PROGRAM:
        
        CALL PRINT_NEWLINE ; Jump to print new line

        MOV AH, 4CH
        INT 21H

    PRINT_NEWLINE PROC
        MOV DX, OFFSET NEWLINE
        MOV AH, 9 
        INT 21H
        RET
    PRINT_NEWLINE ENDP

END MAIN