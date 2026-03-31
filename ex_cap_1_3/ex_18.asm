ALUNO_ID    equ 0    ; id    == int     |  reserva 4 bytes
ALUNO_IDADE equ 4    ; idade == int     |  reserva id + 4 bytes
ALUNO_NOME  equ 8    ; nome  == char*   |  reserva id + idade + n * sizeof(char)
ALUNO_SIZE  equ 28   ; Reserva de 20 bytes para o nome + reservas anteriores

section .data 
nome: db "Icaro", 0

section .bss
aluno: resb ALUNO_SIZE


section .text
global _start

_start:
  ; Movendo o id  
  mov qword [ aluno + ALUNO_ID ], 1982
  ; Movendo a idade 
  mov qword [ aluno + ALUNO_IDADE ], 18 
  ; Movendo o nome 
  xor r14, r14 
.loop:
  cmp byte [ nome + r14 ], 0
  jz .end
  mov ax, [ nome + r14 ]
  mov [ aluno + ALUNO_NOME + r14 ], ax
  inc r14
  jmp .loop
.end:
  mov rax, 60
  mov rdi, 0
  syscall


  

