section .data
value: db "0123456789" 
newline: db 10

section .text
global _start

_start:
  mov rax, 1 
  mov rdx, 1  
  mov r15, 0
.loop:
  lea rsi, [value + r15]  
  syscall 
  lea rsi, newline
  syscall 
  add r15, 1 
  cmp r15, 10
  jnz .loop
  mov rax, 60
  mov rdi, 0 
  syscall 
  


