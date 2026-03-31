%define O_RDONLY    0
%define PROT_READ   0x1
%define MAP_PRIVATE 0x2

section .data
file_name: db "teste.txt", 0

section .text
global _start

; Recv the string address in rdi
string_lenght:
  xor r14, r14
  .loop:
    cmp byte [rdi + r14], 0
    je .end
    inc r14
    jmp .loop
  .end:
    mov rax, r14 
    ret 

; Recv the string address in rdi 
print_string:
  call string_lenght
  mov rdx, rax 
  mov rax, 1 
  mov rsi, rdi 
  mov rdi, 1 
  syscall 
  ret 

_start:
  ; Chama o open
  mov rax, 2 
  mov rdi, file_name 
  mov rsi, O_RDONLY ; Abre o arquivo somente para leitura 
  mov rdx, 0        ; Não estamos criando um arquivo então a flag é 0

  syscall 

  ; mmap 
  mov r8, rax          ; rax armazena o file descriptor do open 
  mov rax, 9           ; número do mmap 
  mov rdi, 0           ; O sistema operacional escolherá o destino do mapa 
  mov rsi, 4096        ; tamanho da página 
  mov rdx, PROT_READ   ; Marcara página para somente leitura 
  mov r10, MAP_PRIVATE ; As páginas não são compartilhadas
  mov r9, 0            ; offset inicial em teste.txt 

  syscall 

  mov rdi, rax         ; Rax tem o endereço do mapa 
  call print_string 

  mov rax, 60 
  mov rdi, 0 
  syscall 














