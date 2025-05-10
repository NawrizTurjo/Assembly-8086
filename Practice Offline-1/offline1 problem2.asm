.MODEL SMALL                        ; Memory model definition

.STACK 100H                         ; Define 256 bytes for stack

.DATA                               ; Data segment begins
    INPUT DB 3 DUP(?)               ; Allocate 3 uninitialized bytes for storing input characters
    NEWLINE DB 13,10,'$'            ; Carriage return and line feed characters for new line
    MSG DB 'All letters are equal$' ; Message to display if all inputs are equal

.CODE                               ; Code segment begins

MAIN:
    MOV AX, @DATA                   ; Set up data segment
    MOV DS, AX                      ; DS register points to our data segment

    LEA SI, INPUT                   ; Load Effective Address - SI register points to INPUT buffer
    MOV CX, 3                       ; Set counter to 3 for reading three characters
    
    TAKE_INPUT:                     ; Loop label for character input
        MOV AH, 1                   ; Function 1: read character with echo
        INT 21H                     ; Call DOS interrupt to read character (stored in AL)
        MOV [SI], AL                ; Store input character at address pointed to by SI
        INC SI                      ; Increment pointer to point to next position in buffer
        LOOP TAKE_INPUT             ; Decrement CX and jump to TAKE_INPUT if CX not zero

    MOV DX, OFFSET NEWLINE          ; Get address of newline string
    MOV AH, 9                       ; Function 9: display string
    INT 21H                         ; Call DOS interrupt to display newline

                                    ; Check if all three characters are the same
    MOV AL, INPUT[0]                ; Load first character into AL
    CMP AL, INPUT[1]                ; Compare with second character
    JNE NOT_EQUAL                   ; Jump if not equal
    CMP AL, INPUT[2]                ; Compare with third character
    JNE NOT_EQUAL                   ; Jump if not equal
    MOV DX, OFFSET MSG              ; If we get here, all characters are equal - load message address
    MOV AH, 9                       ; Function 9: display string
    INT 21H                         ; Display the message
    JMP END_PROGRAM                 ; Skip to end if all characters are equal

    NOT_EQUAL:                      ; If characters are not all equal
        MOV AL, INPUT[0]            ; Load first character
        MOV BL, INPUT[1]            ; Load second character
        MOV CL, INPUT[2]            ; Load third character
        
                                    ; Start sorting the characters (descending order)
        CMP AL, BL                  ; Compare first and second characters
        JG FIRST_GREATER            ; If first > second, no need to swap
        XCHG AL, BL                 ; Otherwise, exchange AL and BL
        MOV INPUT[0], AL            ; Update the first character in memory
        MOV INPUT[1], BL            ; Update the second character in memory

    FIRST_GREATER:                  ; First character is greater than second
        CMP AL, CL                  ; Compare first and third characters
        JG SECOND_GREATER           ; If first > third, no need to swap
        XCHG AL, CL                 ; Otherwise, exchange AL and CL
        MOV INPUT[0], AL            ; Update the first character in memory
        MOV INPUT[2], CL            ; Update the third character in memory
    
    SECOND_GREATER:                 ; First character is now the largest
        CMP BL, CL                  ; Compare second and third characters
        JG THIRD_GREATER            ; If second > third, no need to swap
        XCHG BL, CL                 ; Otherwise, exchange BL and CL
        MOV INPUT[1], BL            ; Update the second character in memory
        MOV INPUT[2], CL            ; Update the third character in memory

    THIRD_GREATER:                  ; Characters are now sorted in descending order
        MOV AL, INPUT[0]            ; Reload first character (largest)
        MOV BL, INPUT[1]            ; Reload second character (middle)
        MOV CL, INPUT[2]            ; Reload third character (smallest)

        CMP AL, BL                  ; Check if first and second characters are equal
        JE EQUAL                    ; If equal, jump to EQUAL
        MOV DL, BL                  ; If not equal, prepare to display the middle character
        MOV AH, 2                   ; Function 2: display character
        INT 21H                     ; Display the middle character
        JMP END_PROGRAM             ; Jump to end

    EQUAL:                          ; First and second characters are equal
        MOV DL, CL                  ; Prepare to display the third (smallest) character
        MOV AH, 2                   ; Function 2: display character
        INT 21H                     ; Display the third character

    END_PROGRAM:                    ; Program termination
        MOV AH, 4CH                 ; Function 4Ch: terminate program
        INT 21H                     ; Return to DOS

END MAIN                            ; End of the main procedure

; so first e 3 ta input nilo, then oigular moddhe a er sathe b and c compare korlo

; jeta boro seta a te nilam, so ekhn a largest carry kortese

; then b and c compare korlam, jeta boro seta b and c choto ta

; so now sorted as a>b>c

; then chk korlam je a anb b eql kina

; jodi hoy taile c ans otherwise b