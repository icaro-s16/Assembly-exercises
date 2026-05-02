section .bss
buffer: resq 1

section .text
global _start
_start:
  mov rax, 12
  push rax
  ; Imprimindo a parte decimal
  mov rdx, 0
  mov rbx, 10
  div rbx
  push rax 
  mov rax, 1
  mov rdi, 1
  pop rcx
  mov [buffer], rcx
  add qword [buffer], 48
  mov rsi, buffer
  mov rdx, 1
  syscall
  pop rcx
  mov al, 10
  sub qword [buffer], 48
  mov bl, [buffer]
  mul bl
  sub rcx, rax  
  mov [buffer], rcx
  mov rax, 1
  mov rdi, 1
  add qword [buffer], 48
  mov rsi, buffer
  mov rdx, 1
  syscall
  mov qword [buffer], 10
  syscall
  mov rax, 60
  xor rdi, rdi
  syscall
  
  
  
  
