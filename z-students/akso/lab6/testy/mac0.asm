global mac0

; Argumenty funkcji mac0:
;   rdi - wartość a
;   rsi - wartość x
;   rdx - wartość y
mac0:
  imul rdx, rsi
  lea rax, [rdi+rdx] 
  ret ; Wynik powinien być w rejestrze rax.