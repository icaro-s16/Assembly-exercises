extern func

section .text
global _start

_start:
  mov rdi, 10
  call func 
  mov rdi, rax 
  mov rax, 60 
  syscall
