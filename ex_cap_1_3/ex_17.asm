section .data
correct: dq -1

section .text 
global _start

_start:
  mov rax, [0x400000 - 1]

  mov rax, 60
  mov rdi, 0
  syscall
