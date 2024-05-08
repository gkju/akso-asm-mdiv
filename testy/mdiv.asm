global mdiv
; rdi - x
; rsi - n
; rdx (potem rcx) - y
; r8 - trzyma xor najbardziej znaczącego bloku x i y, test r8, r8 ustawi SF=1 gdy wynik jest ujemny
mdiv:
    dec rsi
    mov r8, [ rdi + rsi*8 ]
    ; Zapiszemy w r11 najbardziej znaczący blok x, aby odpowiednio zmienić znak reszty i wyniku
    mov r11, r8
    test r8, r8
    js .convert_2compl
    jmp .mdiv_after_first_abs

; Zostanie wywołane wtw. gdy mamy do czynienia z ujemną liczbą, więc musimy znaleźć niezerowy blok
.find_first_nonzero:
    inc r10
    mov rax, [ rdi + r10*8 ]
    test rax, rax
    jz .find_first_nonzero
    jmp .convert_2compl_after_found

.negate_loop:
    not qword [ rdi + r10*8 ]
    inc r10
    cmp r10, rsi
    jle .negate_loop
    jmp .convert_2_compl_callback

.convert_2compl:
    mov r10, -1
    jmp .find_first_nonzero

.convert_2compl_after_found:
    mov r9, r10
    jmp .negate_loop

.convert_2_compl_callback:
    inc qword [ rdi + r9*8]

.mdiv_after_first_abs:
    xor r8, rdx
    ; Liczymy moduł z rdx
    mov rax, rdx
    sar rax, 63
    xor rdx, rax
    sub rdx, rax

    mov rcx, rdx
    xor rdx, rdx
    mov r10, rsi
    jmp .divide_loop

.divide_loop:
    mov rax, [ rdi + r10*8 ]
    div rcx
    mov [ rdi + r10*8 ], rax
    dec r10
    test r10, r10
    jns .divide_loop

.mdiv_after_divide:
    mov rax, [ rdi + rsi*8 ]
    test rax, rax
    js .raise_zero

.mdiv_after_divide_nooverflow:
    test r11, r11
    js .negate_remainder
    jmp .mdiv_convert_2compl

.negate_remainder:
    neg rdx

.mdiv_convert_2compl:
    mov r10, -1
    test r8, r8
    js .convert_to_2compl
    jmp .exit

.convert_to_2compl:
    inc r10
    cmp r10, rsi
    jg .exit
    mov rax, [ rdi + r10*8 ]
    test rax, rax
    jz .convert_to_2compl
    mov r9, r10

.negate_loop_2:
    not qword [ rdi + r10*8 ]
    inc r10
    cmp r10, rsi
    jle .negate_loop_2
    inc qword [ rdi + r9*8]
    jmp .exit
    
.exit:
    mov rax, rdx
    ret

.raise_zero:
    ; int 0
    mov rcx, 0
    div rcx
    ret