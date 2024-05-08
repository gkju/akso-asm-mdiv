0000000000000000 <foo1>:
   0:   53                      push   rbx
   1:   bb 64 00 00 00          mov    ebx,0x64
   6:   66 2e 0f 1f 84 00 00    nop
   d:   00 00 00
  10:   e8 00 00 00 00          call   0x0      ; wywołanie funkcji bar1, właściwy adres wstawia linker
  15:   83 eb 01                sub    ebx,0x1
  18:   75 f6                   jne    0xf6     ; skok o -10 bajtów, czyli do adresu 0x10
  1a:   5b                      pop    rbx
  1b:   c3                      ret

  # tutaj tez z automatu dzieki push rbx wyrownujemy sobie stos do 0 mod 16, a robimy push rbx pop rbx, bo musimy? go w c calling convention na linux zachowac

  dla porownywania liczb ma znaczenie czy sa w nkb czy u2