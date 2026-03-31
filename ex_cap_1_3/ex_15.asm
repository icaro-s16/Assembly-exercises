section .data 
msg: db "Hello, world!", 10

section .text
global _start

_start:
  mov rax, 10
  or rax, 0 
  jnz .end
  mov rax, 1 
  mov rdi, 1 
  mov rsi, msg 
  mov rdx, 14
  syscall

.end:
  mov rax, 60
  mov rdi, 0
  syscall 


