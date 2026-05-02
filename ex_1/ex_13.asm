section .data 
error: db "Houve um erro!", 10, 0
ok: db "Nao houve erros!", 10, 0

section .text 
global _start 

; Recv rdi 
strlen:
  xor r14, r14 
.loop:
  cmp byte [rdi + r14], 0 
  jz .end  
  inc r14   
  jmp .loop
.end:
  mov rax, r14 
  ret 

; Recv address in rdi 
print: 
  call strlen 
  mov rdx, rax 
  lea rsi, [rdi]
  mov rax, 1 
  mov rdi, 1 
  syscall 
  ret 



; 30 < x < 50 
_start:
  mov rax, 40 
  cmp rax, 30 
  jle .error 
  cmp rax, 50
  jge .error 
  mov rdi, ok 
  call print 
  mov rax, 60 
  mov rdi, 1 
  syscall
.error:
  mov rdi, error 
  call print 
  mov rax, 60 
  mov rdi, 1 
  syscall


