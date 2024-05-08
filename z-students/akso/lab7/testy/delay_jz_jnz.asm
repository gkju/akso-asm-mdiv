global delay

delay:
  sub    rsp, 8
  rdtsc           ; liczba cykli zegara w parze rejestrów edx, eax
  shl   rdx, 0x20
  or    rax, rdx ; liczba cykli zegara w rejestrze rax
  push rbx
  mov rbx, rax
  jmp .loop
.loop:
  test   rdi, rdi
  jz .exit
  sub rdi, 0x1
  jnz .loop
.exit:
  rdtsc           ; liczba cykli zegara w parze rejestrów edx, eax
  shl   rdx, 0x20
  or    rax, rdx ; liczba cykli zegara w rejestrze rax
  sub rax, rbx
  pop rbx
  add    rsp, 8
  ret