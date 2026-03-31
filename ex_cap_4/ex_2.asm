extern print_uint 
extern exit 
extern print_new_line
extern parse_uint


%define O_RDONLY 0x0
%define PROT_WRITE 0x1
%define MAP_PRIVATE 0x2
%define NULL 0x0 

section .data
fname: db "input.txt", 0


section .text
global _start


; Recv the value in rdi 
factorial:
  mov rax, 1
  cmp rdi, 0
  jle .end
  .loop:
    imul rax, rdi
      dec rdi 
    cmp rdi, 0
    jg .loop 
  .end:
    ret

_start:
  
  ; Opening the file 
  mov rax, 2 
  lea rdi, [fname]
  mov rsi, O_RDONLY
  mov rdx, NULL
  syscall              ; File descriptor in rax 
  ; Mapping the file 
  mov r8, rax 
  mov rax, 9 
  mov rdi, NULL
  mov rsi, 4096
  mov rdx, PROT_WRITE
  mov r10, MAP_PRIVATE
  xor r9, r9
  syscall               ; Address in rax 

  mov rdi, rax 
  call parse_uint



  mov rdi, rax
  call factorial 
  
  mov rdi, rax
  call print_uint
  call print_new_line 
  
  mov rdi, 0
  call exit 



