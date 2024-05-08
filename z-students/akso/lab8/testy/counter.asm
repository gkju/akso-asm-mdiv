global counter

section .bss

align 4
count: resd 1

section .text

align 16
counter:
    sub    rsp, 8
    mov eax, [rel count]
    inc eax
    mov [rel count], eax
    add rsp, 8
    ret