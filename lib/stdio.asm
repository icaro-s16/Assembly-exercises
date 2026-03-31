section .text

global exit
global strlen 
global print 
global print_int 
global print_new_line
global print_uint 
global print_char
global read_char
global read_word
global parse_int
global parse_uint
global strcpy
global strcmp




; Recv the return value in rdi
exit:
  mov rax, 60
  syscall

; Recv the string address in rdi
; the return value is stored in rax 
strlen:
  xor rax, rax
.loop:
  cmp byte [rdi + rax], 0
  je .end
  inc rax
  jmp .loop
.end:
  ret   

; Recv the string address in rdi
print:
  call strlen  
  mov rdx, rax ; Mov the string lenght to rdx 
  mov rax, 1 
  lea rsi, [rdi]
  mov rdi, 1
  syscall 
  ret

print_new_line:
  push rbp
  mov rbp, rsp
  sub rsp, 1 

  mov rax, 1
  mov rdi, 1
  mov byte [rbp - 1], 10
  lea rsi, [rbp - 1]
  mov rdx, 1 
  syscall 

  add rsp, 1
  pop rbp 
  ret

; Recv the value in rdi 
print_uint:
  push rbp 
  mov rbp, rsp 

  mov rax, rdi
  
  mov rdi, rsp
  sub rsp, 16 
  dec rdi 
  mov byte [rdi], 0 
  mov r8, 10
.loop:
  xor rdx, rdx
  div r8
  add dl, 48
  dec rdi
  mov [rdi], dl
  test rax, rax
  jnz .loop
  call print
  add rsp, 16 
  pop rbp 
  ret

; Recv the value in rdi
print_int:
  test rdi, rdi 
  js .print_signal

.print_value:
  call print_uint
  ret

.print_signal:
  push rdi 
  mov rdi, 45 ; 45 == - 
  call print_char
  pop rdi
  neg rdi
  jmp .print_value


; Recv the char code in rdi 
print_char:
  push rbp 
  mov rbp, rsp 
  sub rsp, 1 

  mov [rbp - 1], rdi 
  mov rax, 1 
  mov rdi, 1 
  mov rdx, 1 
  lea rsi, [rbp - 1]
  syscall 
  
  add rsp, 1
  pop rbp
  ret 


read_char:
  push rbp 
  mov rbp, rsp
  sub rsp, 1 

  mov rax, 0
  mov rdi, 0
  lea rsi, [rbp - 1]
  mov rdx, 1 
  syscall 
  cmp rax, 0
  jle .eof
  mov rax, [rbp - 1]
  
  add rsp, 1
  pop rbp

  ret   
.eof:
  
  add rsp, 1
  pop rbp
  
  mov rax, 0 
  ret

; Recv the buffer address in rdi and the buffer size in rsi
read_word:
  mov rdx, rsi 
  push rsi     
  mov rsi, rdi
  mov rax, 0 
  mov rdi, 0 
  syscall 
  pop rdx 
  cmp rax, rdx 
  je .error                ; If is above or equal than the size of buffer 
  mov byte [rsi + rax - 1], 0  ; Add the null terminator 
  lea rax, [rsi]         
  ret
.error:
  mov rax, 0
  ret

; Recv the string address rdi
parse_uint:
  xor r14, r14
.loop:
  xor rax, rax
  cmp byte [rdi + r14], 48 
  jl .end_loop
  cmp byte [rdi + r14], 57
  jg .end_loop
  mov al, [rdi + r14]
  sub al, 48 
  push rax 
  inc r14
  jmp .loop
.end_loop:
  mov rdi, 1 
.int_loop:
  cmp r14, 0
  je .end 
  dec r14
  pop r13 
  imul r13, rdi
  imul rdi, 10
  add rax, r13
  jmp .int_loop
.end:
  ret

; Recv the string adress in rdi 
parse_int:
  cmp byte [rdi + 0], 45
  je .neg 
  jmp .pos  
.neg:
  mov byte [rdi + 0], 48
  call parse_uint
  neg rax 
  ret 
.pos:
  call parse_uint 
  ret 
  
; Recv the dest string in rdi and the src string in rsi 
strcmp:
  xor r14, r14 
  xor rax, rax 
.loop:
  xor r13, r13
  mov r13B, [rdi + r14]
  cmp byte [rsi + r14], r13B
  jne .error
  inc r14
  mov rax, 1 
  cmp byte [rdi + r14], 0
  je .end 
  jmp .loop
.error:
  mov rax, 0 
.end:
  ret

; Recv: rdi -> string src address | rsi -> dest buffer | rdx -> dest buffer size 
strcpy:
  push rdi 
  mov rdi, rsi 
  call strlen  ; Get the string src size  
  cmp rax, 0
  je .error 
  pop rdi
  cmp rax, rdx 
  jge .error 
  xor r14, r14 ; r14: offSet 
.loop:
  cmp byte [rsi + r14], 0 
  je .end 
  mov r13B, byte [rsi + r14] 
  mov byte [rdi + r14], r13B 
  inc r14 
  jmp .loop 
.end:
  mov byte [rdi + r14], 0 
  mov rax, rdi 
  ret 
.error:
  mov rax, 0 
  ret 

  



