extern print_char
extern print_new_line 
extern parse_int 
extern print_int
extern exit 

%define NULL        0x0
%define O_RDONLY    0x0
%define PROT_WRITE  0x1
%define MAP_PRIVATE 0x2

section .data
fname: db "input.txt",0

section .text 
global _start

; Recv the number in rdi
is_prime:
  xor r13, r13   

  cmp rdi, 2
  jl .error 

  mov r14, 2 
  mov rax, rdi  
  
  .loop: 
    cmp r14, rax
    jge .end

    xor rdx, rdx
    div r14 
    inc r14 
    cmp rdx, 0
    je .error
    jmp .loop

  .error:
    mov r13, 1 
  .end:
    mov rax, r13
    ret
  

_start:
  mov rax, 2
  mov rdi, fname 
  mov rsi, O_RDONLY
  mov rdx, NULL
  syscall 
  push rax 

  mov rax, 9 
  mov rdi, NULL
  mov rsi, 4096
  mov rdx, PROT_WRITE
  mov r10, MAP_PRIVATE
  pop r8
  mov r9, 0 
  syscall 


  mov rdi, rax 
  call parse_int

  mov rdi, rax
  call is_prime 
  mov rdi, rax 
  call print_int
  call print_new_line
  mov rdi, 0
  call exit
  



