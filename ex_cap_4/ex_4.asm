extern print_int
extern parse_int
extern exit


%define NULL        0x0
%define O_RDONLY    0x0
%define PROT_WRITE  0x1
%define MAP_PRIVATE 0x2

section .data
fname: db "input.txt", 0

section .text
global _start

; Recv the string address in rdi 
sum_digits:
  push rbp 
  mov rbp, rsp 
  sub rsp, 4

  mov dword [rbp - 4], 0

  xor r14, r14
  xor r13, r13
  .loop:
    cmp byte [rdi + r14], 48
    jl .end 
    cmp byte [rdi + r14], 57
    jg .end

    mov r13B,  byte [rdi + r14]
    sub r13B, 48 

    add dword [ rbp - 4 ], r13D
    
    inc r14
    jmp .loop

  .end:
    mov eax , dword [rbp - 4]
    add rsp, 4
    pop rbp
    ret 

_start:
  mov rax, 2
  lea rdi, [fname]
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
  xor r9, r9
  syscall 


  mov rdi, rax 
  call sum_digits

  mov rdi, rax 
  call print_int

  mov rdi, 0
  call exit








