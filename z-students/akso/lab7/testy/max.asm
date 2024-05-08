global umax, smax

smax:
  mov eax, edi
  cmp esi, edi
  cmovnl eax, esi
  ret 

umax:
  mov eax, edi
  cmp esi, edi
  cmovnb eax, esi
  ret 