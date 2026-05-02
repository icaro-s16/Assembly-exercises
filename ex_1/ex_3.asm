section .bss
buffer: resq 1

section .text 
global _start 
_start:
  mov rax, 1232903901
  mov r15, 0
.loop:
  add r15, 1
  mov rdx, 0
  mov rbx, 10 ; Adiciona o divisor ao registrador rbx
  div rbx ; Dividi rax por rbx, retorna o quociente para rax e o resto para rdx
  push rdx ; Armazenamos o valor que será printado na stack
  test rax, rax
  jnz .loop
.print_loop:
  mov rax, 1  
  mov rdi, 1 
  pop qword [buffer]
  add qword [buffer], 48
  mov rsi, buffer  
  mov rdx, 1 
  syscall
  sub r15, 1
  test r15, r15 
  jnz .print_loop
  mov rax, 1 
  mov rdi, 1 
  mov qword [buffer], 10
  mov rsi, buffer
  mov rdx, 1 
  syscall 
  mov rax, 60
  xor rdi, rdi
  syscall


  


