section .data
st: db "Hello, world!!!!!!", 10, 0


section .text
global _start

strlen:
  ; arg -> rdi : String Memory Location
  xor rax, rax 

.loop:   
  
  cmp byte [rdi + rax], 0
  je .end_loop
  
  inc rax
  jmp .loop

.end_loop:
  ret

_start:
  mov rdi, st
  call strlen ; Now r15 have the strlen 
  push rax 
  
  mov rax, 1 
  mov rdi, 1 
  pop rdx
  lea rsi, [st]
  syscall 
  mov rax, 60 
  mov rdi, rax 
  syscall


