extern print_int 
extern print_new_line
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

; Recv rdi as n 
fibonnaci:
  xor rax, rax 
  cmp rdi, 1
  jle .end
  push rbp
  mov rbp, rsp
  sub rsp, 8
  
  mov dword [rbp - 8], 0
  sub rdi, 2

  xor r14, r14 
  mov r13, 1 
  .loop:
    mov dword [ rbp - 4], r14D
    add dword [ rbp - 4], r13D
    
    mov r14, r13
    mov r13D, dword [ rbp - 4 ]

    inc dword [rbp - 8]
    cmp dword [rbp - 8], edi
    jl .loop
  mov eax, r13D
  leave 
  .end:
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
  xor r9, r9
  syscall

  mov rdi, rax 
  call parse_int

  mov rdi, rax
  call fibonnaci
  mov rdi, rax
  call print_int
  call print_new_line
  mov rdi, 0
  call exit



