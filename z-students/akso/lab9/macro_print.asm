%ifndef MACRO_PRINT_ASM
%define MACRO_PRINT_ASM

%macro print 2
  jmp     %%begin
  
%%l:
  xor edx, edx
  mov edx, eax
  and edx, 15
  add edx, 48
  push ex
  shr rax, 4

%%descr: db %1
%%begin:
  push    %2              ; Wartość do wypisania będzie na stosie. To działa również dla %2 = rsp.
  lea     rsp, [rsp - 16] ; Zrób miejsce na stosie na bufor. Nie modyfikuj znaczników.
  pushf
  push    rax
  push    rcx
  push    rdx
  push    rsi
  push    rdi
  push    r11

  mov rax, 1
  mov rdi, 1
  mov rsi, %%descr
  mov rdx, %%begin - %%descr
  syscall
  lea rsp, [rsp + 68]
  mov rax, [rsp + 4]

  mov ecx, 16
  loop %%l

  lea rsp, [rsp - 52]
  mov rdx, 16
  syscall

  pop     r11
  pop     rdi
  pop     rsi
  pop     rdx
  pop     rcx
  pop     rax
  popf
  lea     rsp, [rsp + 24]
%endmacro

%endif