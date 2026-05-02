extern print
extern print_new_line
extern print_char
extern print_int
extern exit 

section .data
text: db "Im the process son!", 0
label: db "Char ", 0
label_father: db "Waiting process number ",0

section .text
global _start

_start: 
  mov rax, 57 
  syscall
  cmp rax, 0 
  jnz .father
  sub rsp, 2
  xor r14, r14 
  .loop: 
    mov r13B, byte [text + r14]
    mov byte [rsp], r13B
    mov byte [rsp + 1], 0
    push r14 
    mov rdi, label
    call print 
    pop r14
    mov rdi, r14 
    inc rdi
    push r14 
    call print_int
    mov rdi, ':'
    call print_char
    lea rdi, [rsp + 8]
    call print
    call print_new_line
    pop r14
    inc r14 
    cmp byte [text + r14], 0
    jnz .loop 
  add rsp, 2 
  mov rdi, 0
  call exit 

  .father:
    mov rdi, label_father
    call print 
    mov rdi, rax  
    call print_int 
    call print_new_line
    
    sub rsp, 4
    mov rax, 61
    mov rdi, rax
    lea rsi, [rbp - 4]
    xor rdx, rdx 
    mov r10, 0
    syscall
    mov rdi, 0
    call exit













