section .text 
global _start 


; Recv in rdi the address 
strlen:
  xor r8, r8 
.loop:
  cmp byte [rdi + r8], 0 
  je .end 
  inc r8
  jmp .loop
.end:
  mov rax, r8
  ret

; Recv in rdi the string address 
print:
  call strlen 
  mov rdx, rax 
  lea rsi, [rdi]
  mov rax, 1
  mov rdi, 1 
  syscall 
  ret 


; Recv the value in rdi 
print_int:
  cmp rdi, 0
  jl .negative
  
  mov rax, rdi 

  push 0

  mov rdi, rsp  

  sub rsp, 16  

  mov r8, 10
.loop:
  xor rdx, rdx 
  dec rdi
  div r8      ; Remainder -> rdx  quocient -> rax  
  
  add rdx, 48
  mov byte [rdi], dl  ; al == 8 bytes of rdx  
  
  cmp rax, 0 
  jnz .loop 
  call print
  
  add rsp, 24

  ret 
.negative:
  push rdi 

  sub rsp, 1
  mov byte [rsp - 1], 45

  mov rax, 1
  mov rdi, 1 
  mov rdx, 1 
  lea rsi, [rsp - 1]
  syscall 
  
  add rsp, 1
  pop rdi 

  neg rdi
  jmp print_int 
  

  
_start:
  mov rdi, 12903902
  neg rdi
  call print_int
  mov rax, 60 
  mov rdi, 1 
  syscall








