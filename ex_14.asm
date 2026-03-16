section .text 
global _start 

_start:
  mov rax, 0x112233445567788 
  push rax 
  mov dil, byte [rsp + 3]
  mov rax, 60 
  syscall
