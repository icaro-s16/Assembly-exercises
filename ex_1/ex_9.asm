section .data
textDec: db "Decimal value: " ; size -> 15
textHex: db "Hexadecimal value: " ; size -> 19
dec: db "0123456789"
hex: db "0123456789ABCDEF" ; size -> 16
newline: db 10

section .text
global _start

print_newline:
  mov rax, 1 ; sys_write
  mov rdi, 1 ; stdout fd
  mov rdx, 1 
  lea rsi, [newline]
  syscall
  ret 

print_hex:
  push r15
  push rbx 
  mov rax, rdi 
  mov r15, 0 
.loop_hex:
  add r15, 1 
  mov rbx, 16 
  xor rdx, rdx 
  div rbx 
  push rdx 
  cmp rax, 0 
  jnz .loop_hex 
.loop_p_hex:
  mov rax, 1 
  mov rdi, 1
  mov rdx, 1 
  pop r14 
  lea rsi, [hex + r14]
  syscall
  sub r15, 1 
  cmp r15, 0 
  jnz .loop_p_hex 
  pop rbx 
  pop r15 
  ret

print_dec:
  ; args : rdi -> int_value
  ; Saving the callee-saved register
  push r15
  push rbx 
  mov rax, rdi
  ; loop counter
  mov r15, 0
.loop:
  add r15, 1 
  mov rbx, 10
  xor rdx, rdx
  div rbx 
  push rdx
  cmp rax, 0
  jnz .loop
.print_loop:
  mov rax, 1 
  mov rdi, 1 
  mov rdx, 1 
  pop r14
  lea rsi, [dec + r14] 
  syscall
  sub r15, 1 
  cmp r15, 0 
  jnz .print_loop
  pop rbx 
  pop r15
  ret

_start:
  mov rax, 1
  mov rdi, 1
  mov rdx, 15
  lea rsi, [textDec]
  syscall
  mov rdi, 9999 ; arg 
  call print_dec
  call print_newline
  mov rax, 1
  mov rdi, 1
  mov rdx, 19
  lea rsi, [textHex]
  syscall
  mov rdi, 9999
  call print_hex
  call print_newline
  mov rax, 60
  xor rdi, rdi
  syscall


