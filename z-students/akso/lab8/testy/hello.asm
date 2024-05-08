global hello
extern putchar

section .rodata

hello_text: db `Hello World!\n\0`

section .text

hello:
  sub rsp, 8
  push rbx
  lea rax, [rel hello_text]
  jmp .loop

.loop:
  mov bl, BYTE [rax]
  test bl, bl
  jz .exit
  movzx edi, bl
  call putchar wrt ..plt
  inc rax
  jmp .loop

.exit:
  pop rbx
  add rsp, 8
  ret