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
    mov rcx, 0
    mov r10, -1
    js .convert_2compl
    jmp .mdiv_after_first_abs

.convert_2compl:
    inc r10
    cmp r10, rsi
    jg .convert_2_compl_callback
    mov rax, [ rdi + r10*8 ]
    test rax, rax
    jz .convert_2compl
    mov r9, r10

.negate_loop:
    not qword [ rdi + r10*8 ]
    inc r10
    cmp r10, rsi
    jle .negate_loop
    inc qword [ rdi + r9*8]

.convert_2_compl_callback:
    test rcx, rcx
    jnz .exit

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
    ; Dla ujemnego wyniku mamy gwarancje, że wynik się zmieści.
    test r8, r8
    js .mdiv_after_divide_nooverflow
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
    mov rcx, 1
    js .convert_2compl
    jmp .exit

.exit:
    mov rax, rdx
    ret

.raise_zero:
    mov rcx, 0
    div rcx
    ret