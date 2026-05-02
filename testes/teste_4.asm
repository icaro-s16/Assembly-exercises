extern print_int
extern print 
extern print_new_line
extern exit

%macro puts 1
  %ifid %1
    mov rdi, %1
    call print 
  %else
    %ifnum %1
      mov rdi, %1
      call print_int
    %else 
      %error "Invalid argument to puts"
    %endif
  %endif
%endmacro

%assign i "hello" + 1

section .data
hello: db "Hello, world", 0

section .text 
global _start

_start:
  puts hello 
  call print_new_line
  puts 10
  call print_new_line
  mov rdi, 0
  call exit


  


