%include "macro_print.asm"

global _start

SYS_WRITE equ 1
SYS_EXIT equ 60
STDOUT equ 1

section .rodata

hello: db `Hello world!\n`
HELLO_LEN equ $ - hello

section .text

_start:
    mov   rax, rsp
    print "rsp = ", rsp ; Te dwa użycia makra
    print "rsp = ", rax ; powinny wypisać to samo.
    mov   rax, 0x0123456789abcdef
    print "rax = ", rax
    mov   rbx, 0xfedcba9876543210
    print "rbx = ", rbx
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall