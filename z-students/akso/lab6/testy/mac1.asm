global mac1

; arg rdi - a.lo, rsi - a.hi, rdx - x, rcx - y
; do rax, rdx wynik

mac1:
    mov rax, rdx
    mul rcx
    add rax, rdi
    adc rdx, rsi
    ret
    