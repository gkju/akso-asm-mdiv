global delay

delay:
  sub    rsp, 8
  rdtsc           ; liczba cykli zegara w parze rejestrów edx, eax
  shl   rdx, 0x20
  or    rax, rdx ; liczba cykli zegara w rejestrze rax
  push rbx
  mov rbx, rax
  mov rcx, rdi
  jmp .loop
.loop:
  loop .loop
  jmp .exit
.exit:
  rdtsc           ; liczba cykli zegara w parze rejestrów edx, eax
  shl   rdx, 0x20
  or    rax, rdx ; liczba cykli zegara w rejestrze rax
  sub rax, rbx
  pop rbx
  add    rsp, 8
  ret