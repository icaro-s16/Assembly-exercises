extern print_int
extern print_new_line
extern exit

%macro is_prime 1
  %ifnum %1 
    %assign i 1
    %rep %1/2
      %assign i i + 1
      %if  %1 != i  
        %if %1 % i = 0
          mov rax, 0
          jmp %%exit
        %endif
      %endif
    %endrep 
    mov rax, 1 
    %%exit:
  %else
    %error "Invalid parameter"
  %endif
%endmacro


section .text
global _start

_start:
  is_prime 10
  mov rdi, rax
  call print_int
  call print_new_line
  mov rdi, 0
  call exit

