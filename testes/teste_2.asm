extern print_int
extern exit
extern print_new_line


%macro dec_value 1               
  mov r13, %1             
  .loop:           
    cmp r13, 0        
    jle .end       
    mov rdi, r13       
    call print_int 
    call print_new_line
    dec r13           
    jmp .loop        
  .end             
%endmacro

section .text
global _start

_start:
  mov rax, 10
  dec_value 10
  mov rdi, 0
  call exit

