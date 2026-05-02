extern print_new_line
extern print
extern parse_int
extern exit 

%define NULL        0x0
%define O_RDONLY    0x0
%define PROT_WRITE  0x1
%define MAP_PRIVATE 0x2

section .data
fname: db "input.txt", 0
true:  db "true",      0
false: db "false",     0

section .text
global _start

; Recv value to compare in rdi
is_fibonnaci:
  push rbp
  mov rbp, rsp
  sub rsp, 8
  mov dword [rbp - 8], 0
  xor r14, r14 
  mov r13, 1
  .loop:
    cmp rdi, r14
    je .true
    cmp rdi, r14 
    jl .exit 
    mov dword [rbp - 4], r14D
    add dword [rbp - 4], r13D
    mov r14, r13
    mov r13D, dword [rbp - 4]
    jmp .loop
  .true:
    mov dword [rbp - 8], 1
  .exit:
    mov eax, dword [rbp - 8]
    leave 
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
  call is_fibonnaci
  cmp rax, 1 
  je .print_true
  mov rdi, false
  call print
  jmp .end
  .print_true:
    mov rdi, true
    call print
  .end:
  call print_new_line
  mov rdi, 0
  call exit



