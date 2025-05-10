.MODEL SMALL                    ; Defines the memory model for the program

.STACK 100H                     ; Allocates 256 bytes for the stack

.DATA                           ; Data segment begins here
    ARRAY DB 10, 20, 30, 25, 40 ; Defines an array of 5 bytes to check for sorting pattern
    SIZE DW 4                   ; Size represents number of comparisons (array length - 1)
    SORT_A DB 'Ascending$'      ; Message to display if array is in ascending order
    SORT_D DB 'Descending$'     ; Message to display if array is in descending order
    SORT_U DB 'Not sorted$'     ; Message to display if array is not sorted

.CODE                           ; Code segment begins here

MAIN:
    MOV AX, @DATA               ; Load the address of data segment into AX
    MOV DS, AX                  ; Set DS register to point to our data segment

    MOV CX, SIZE                ; CX will be our loop counter - set to number of comparisons to make
    MOV SI, OFFSET ARRAY        ; SI holds the address of the first element of the array
    MOV BX, 0                   ; BX will track the pattern: 0=initial, 1=ascending, 2=descending

    ITERATE:
        CMP CX, 0               ; Check if we've done all comparisons
        JE WHICH_SORT           ; If counter is zero, we're done, check result
        MOV AL, [SI]            ; Load current element into AL
        INC SI                  ; Move SI to point to the next element
        CMP AL, [SI]            ; Compare current element with next element
        JL ASCENDING            ; If current < next, might be ascending
        CMP AL, [SI]            ; Compare again (could combine with above, but kept for clarity)
        JG DESCENDING           ; If current > next, might be descending
        LOOP ITERATE            ; If current = next, just continue to next pair

    WHICH_SORT:                 ; Determine the sorting pattern based on BX value
        CMP BX, 0               ; If BX=0, no pattern detected (all elements were equal)
        JE ASC                  ; Treat equal elements as ascending
        CMP BX, 1               ; If BX=1, pattern was ascending
        JE ASC                  ; Jump to ascending result
        CMP BX, 2               ; If BX=2, pattern was descending
        JE DESC                 ; Jump to descending result

    ASC:                        ; Array is in ascending order
        MOV DX, OFFSET SORT_A   ; Load address of ascending message
        JMP PRINT_RESULT        ; Jump to print routine

    DESC:                       ; Array is in descending order
        MOV DX, OFFSET SORT_D   ; Load address of descending message
        JMP PRINT_RESULT        ; Jump to print routine

    ASCENDING:                  ; Handle a pair in ascending order (current < next)
        CMP BX, 0               ; Check if this is our first pattern detection
        JE NEXT_A               ; If yes, set to ascending pattern
        CMP BX, 1               ; Check if we already detected ascending pattern
        JNE NOT_SORTED          ; If we previously detected descending, pattern is broken
        DEC CX                  ; Decrement comparison counter
        JMP ITERATE             ; Continue checking next pair

    NEXT_A:                     ; First pattern detected is ascending
        MOV BX, 1               ; Set BX=1 to indicate ascending pattern
        DEC CX                  ; Decrement comparison counter
        JMP ITERATE             ; Continue checking next pair

    DESCENDING:                 ; Handle a pair in descending order (current > next)
        CMP BX, 0               ; Check if this is our first pattern detection
        JE NEXT_D               ; If yes, set to descending pattern
        CMP BX, 2               ; Check if we already detected descending pattern
        JNE NOT_SORTED          ; If we previously detected ascending, pattern is broken
        DEC CX                  ; Decrement comparison counter
        JMP ITERATE             ; Continue checking next pair

    NEXT_D:                     ; First pattern detected is descending
        MOV BX, 2               ; Set BX=2 to indicate descending pattern
        DEC CX                  ; Decrement comparison counter
        JMP ITERATE             ; Continue checking next pair

    NOT_SORTED:                 ; Array doesn't follow a consistent pattern
        MOV DX, OFFSET SORT_U   ; Load address of not sorted message
        JMP PRINT_RESULT        ; Jump to print routine

    PRINT_RESULT:               ; Display the appropriate message
        MOV AH, 9               ; DOS function 9: print string
        INT 21H                 ; Call DOS interrupt
        JMP END_PROGRAM         ; Jump to program end

    END_PROGRAM:                ; Clean termination of program
        MOV AX, 4CH             ; DOS function 4Ch: terminate program
        INT 21H                 ; Call DOS interrupt to exit

END MAIN                        ; End of the main procedure