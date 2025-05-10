; Program: Vowel and Consonant Counter
; Description: This program counts the number of vowels and consonants in a predefined string.
; It specifically counts lowercase vowels (a,e,i,o,u) and treats all other characters as consonants.
; After counting, it displays the results on the screen.
;
; Data Segment:
; STRING - Contains the input text to be analyzed ending with '$'
; NEWLINE - String containing carriage return (13) and line feed (10) for line break
; VOWEL - String containing "Vowel Count: " for output
; CONSONANT - String containing "Consonant Count: " for output
; V - Word variable to store the vowel count
; C - Word variable to store the consonant count
;
; Code Flow:
; 1. Initialize data segment and registers
; 2. Read each character from STRING until '$' is encountered
; 3. If character is a vowel (a,e,i,o,u), increment vowel counter (DX)
; 4. If not a vowel, increment consonant counter (CX)
; 5. Store final counts in V and C variables
; 6. Display results using the PRINT_NUMBER procedure
; 7. Terminate program
;
; Procedures:
; PRINT_NUMBER - Converts a number in AX to decimal and displays it
;   Algorithm: 
;   - Repeatedly divides AX by 10
;   - Pushes remainder onto stack
;   - Pops digits from stack and displays them as ASCII characters
;
; Note: The program considers any non-vowel character as a consonant, including spaces,
; punctuation, and other special characters.
.MODEL SMALL

.STACK 100H

.DATA
    STRING DB 'eruiaaageruiaaag$'
    NEWLINE DB 13,10,'$'
    VOWEL DB 'Vowel Count: $'
    CONSONANT DB 'Consonant Count: $'
    V DW 0
    C DW 0

.CODE

MAIN:
    MOV AX, @DATA
    MOV DS, AX

    LEA BX, STRING

    MOV AX, 0
    MOV CX, 0
    MOV DX, 0

    NEXT_CHAR:
        MOV AL, [BX]
        CMP AL, '$'
        JE PRINT_RESULT
        CMP AL, 'a'
        JE VOWEL_COUNT
        CMP AL, 'e'
        JE VOWEL_COUNT
        CMP AL, 'i'
        JE VOWEL_COUNT
        CMP AL, 'o'
        JE VOWEL_COUNT
        CMP AL, 'u'
        JE VOWEL_COUNT
        INC CX
        INC BX
        JMP NEXT_CHAR

    VOWEL_COUNT:
        INC DX
        INC BX
        JMP NEXT_CHAR

    PRINT_RESULT:
        MOV V, DX
        MOV C, CX

        LEA DX, VOWEL
        MOV AH, 9
        INT 21H
        MOV AX, V
        CALL PRINT_NUMBER

        LEA DX, NEWLINE
        MOV AH, 9
        INT 21H

        LEA DX, CONSONANT
        MOV AH, 9
        INT 21H
        MOV AX, C
        CALL PRINT_NUMBER
        JMP END_PROGRAM

    PRINT_NUMBER PROC
        MOV BX, 10
        XOR CX, CX

    NEXT_DIGIT:
        XOR DX, DX
        DIV BX
        PUSH DX
        INC CX
        CMP AX, 0
        JNZ NEXT_DIGIT

    PRINT_LOOP:
        POP DX
        ADD DL, '0'
        MOV AH, 2
        INT 21H
        LOOP PRINT_LOOP

        RET

    PRINT_NUMBER ENDP

    END_PROGRAM:
        MOV AX, 4CH
        INT 21H
    
END MAIN