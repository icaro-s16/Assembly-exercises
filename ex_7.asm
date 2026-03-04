section .data
text1: db "Your number is greater than 20", 10 ; size -> 31
text2: db "Your number is lower than 20", 10 ; size -> 29

section .text
global _start
_start:
  ; Reading the value
  mov r15, 21
  cmp r15, 20
  jl .sText2
.sText1:
  mov rax, 1 
  mov rdi, 1 
  mov rdx, 31
  lea rsi, [text1]
  syscall
  jmp .end
.sText2:
  mov rax, 1 
  mov rdi, 1 
  mov rdx, 29 
  lea rsi, [text2] 
  syscall
.end:
  mov rax, 60
  xor rdi, rdi
  syscall

