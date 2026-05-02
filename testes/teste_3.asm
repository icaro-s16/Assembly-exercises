extern print_int
extern exit 


section .text
global _start
_start:
  mov rax, -10
  sub rax, 1 
  not rax 
  mov rdi, rax 
  call print_int
  mov rdi, 0 
  call exit
