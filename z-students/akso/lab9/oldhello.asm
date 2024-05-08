global _start

SYS_WRITE equ 1
SYS_EXIT equ 60
STDOUT equ 1

section .rodata

hello: db `Hello world!\n`
HELLO_LEN equ $ - hello

section .text

_start:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, hello
    mov rdx, HELLO_LEN
    syscall
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall