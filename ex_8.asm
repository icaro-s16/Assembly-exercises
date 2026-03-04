global _start 

section .data
message: db 'Eu amo a mariazinha', 10

section .text
_start:
    mov rax, 1; O número da chamada do sistema deve ser armazenado em rax
    mov rdi, 1; Argumento #1 em rdi: Indica onde escrever (descritor), como queremos stdout é 1
    mov rsi, message; Argumento #2 indica onde começa a string
    mov rdx, 20; Argumento #3 em rdx escrevemos quantos bytes serão escritos junto do \0
    syscall; essa instrução faz uma chamada do sistema
    mov rax, 60; Move para rax o System call : sys_exit 
    xor rsi, rsi
    syscall; Chama a system call sys_exit para indicar o fim do programa

