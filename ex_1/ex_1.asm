section .bss
  buffer: resb 8


section .text
  global _start

  _start:
    mov rax, 10
    add rax, 3
    push rax
    ; Processo para printar no terminal
    mov rax, 1
    mov rdi, 1
    pop byte [buffer]
    add byte [buffer], 48
    mov rsi, buffer
    mov rdx, 1
    syscall
    ; Processo para finalizar o programa
    mov rax, 60
    xor rdi, rdi
    syscall
