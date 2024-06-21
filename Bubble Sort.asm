INCLUDE Irvine32.inc

.data
    numbers DWORD 6 DUP(?)       ; Array to store the numbers
    resultMsg BYTE "The sorted numbers are: ",0
    strPrompt BYTE "Enter a number: ", 0

.code
main PROC
    call Clrscr
    
    ; Input numbers
    mov esi, OFFSET numbers
    mov ecx, 6                   ; Number of elements to read
    call InputNumbers
    
    ; Sort the numbers
    mov esi, OFFSET numbers
    mov ecx, 6                   ; Number of elements in the array
    call SortNumbers
    
    ; Display the sorted numbers
    mov edx, OFFSET resultMsg
    call WriteString
    mov esi, OFFSET numbers
    mov ecx, 6                   ; Number of elements in the array
    call DisplayNumbers
    
    call Crlf
    exit
main ENDP

InputNumbers PROC
    ; Inputs: esi = pointer to the array
    ; ecx = number of elements to read
    
input_loop:
    mov edx, OFFSET strPrompt
    call WriteString
    call ReadInt
    mov [esi], eax
    add esi, 4
    loop input_loop
    ret
InputNumbers ENDP

SortNumbers PROC
            ; Sorts the numbers in ascending order
            ; Inputs: esi = pointer to the array
            ; ecx = number of elements in the array

    mov ebx, ecx                ; Set up the outer loop counter

outerloop:
    mov esi, OFFSET numbers    ; Reset array pointer for each pass
    mov ecx, ebx                        ; Set inner loop counter to outer loop counter
    
    dec ecx                   ; Decrement inner loop counter for comparison
    jz done                    ; If only one element left, sorting complete

innerloop:
    mov edx, [esi]               ; Load current number
    mov eax, [esi + 4]         ; Load next number

    cmp edx, eax              ; Compare current and next number
    jle no_swap                 ; If current <= next, no swap needed

    ; Swap current and next numbers
    mov [esi], eax                ; Move next number to current position
    mov [esi + 4], edx         ; Move current number to next position

no_swap:
    add esi, 4                    ; Move to next element
    loop innerloop             ; Repeat inner loop until all elements compared

    dec ebx                         ; Decrement outer loop counter
    jnz outerloop                 ; Repeat outer loop until all elements sorted

done:
    ret
SortNumbers ENDP


DisplayNumbers PROC
    ; Displays the numbers
    ; Inputs: esi = pointer to the array
    ;         ecx = number of elements in the array
    
display_loop:
    mov eax, [esi]
    call WriteInt
    call Crlf
    add esi, 4
    loop display_loop
    
    ret
DisplayNumbers ENDP


END main