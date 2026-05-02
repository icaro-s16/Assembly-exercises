extern strcmp
extern strlen

global find_word

section .text

; Recv : rdi -> String key | rsi -> init pointer
; Return : rax -> 0 | content address 
find_word:
    .loop:
        add rsi, 8
        call strcmp
        cmp rax, 1 
        je .end 
        sub rsi, 8 
        cmp qword [ rsi ], 0
        je .error 
        mov rax, qword [ rsi ]
        mov rsi, rax 
        jmp .loop
    .end:
        call strlen 
        add rsi, rax
        mov rax, rsi
        inc rax 
        ret 
    .error:
        mov rax, 0
        ret

