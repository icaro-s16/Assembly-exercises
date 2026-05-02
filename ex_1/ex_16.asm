section .text 
global _start

_start:
  cmp [rdx], bl

  mov bh, bl

  mov al, al

  add bpl, 9

  add [9], spl

  mov r8D, r9D

  mov r9, [r9 + 8*rax]

