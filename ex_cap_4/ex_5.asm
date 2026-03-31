extern print_int
extern exit 

section .text
global _start

; Recv n_1 in rdi and n_2 in rsi
process_number:
  push rbp 
  mov rbp, rsp 
  sub rsp, 8
  mov dword [rbp - 4], edi 
  mov dword [rbp - 8], esi
  xor rax, rax 
  add eax, dword [rbp - 4]
  add eax, dword [rbp - 8]
  leave 
  ret



_start:
  mov rdi, 10
  mov rsi, 10
  call process_number
  mov rdi, rax 
  call print_int
  mov rdi, 0
  call exit
  
