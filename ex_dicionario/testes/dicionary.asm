extern print
extern strlen
extern exit 
extern strcmp
extern print_int
extern print_new_line

section .data

error: db "Error!", 10, 0

key: db "key 3", 0

node1:
    dq node2
    dq 120
    db "key 1", 0

node2:
    dq node3
    dq 150
    db "key 2", 0

node3:
    dq 0
    dq 170
    db "key 3", 0


section .text 
global _start


; Recvs:
; rdi -> dictionary address 
; rsi -> key address 
get_value:
    .loop:
        push rdi
        add rdi, 16
        call strcmp
        cmp rax, 1 
        je .end
        pop rdi
        cmp qword [rdi], 0
        je .error 
        mov rax, qword [ rdi ]
        mov rdi, rax 
        jmp .loop 
    .end: 
        pop rax
        add rax, 8
        ret
    .error:
        mov rax, -1
        ret

; recv :
; rdi -> msg address
print_err:
    push rdi
    call strlen
    mov rdx, rax 
    mov rax, 1
    mov rdi, 2
    pop rsi     
    syscall 
    mov rdi, -1 
    call exit 

_start:
    mov rdi, node1 
    mov rsi, key
    call get_value
    cmp rax, -1
    je .err
    mov rdi, qword [ rax ] 
    call print_int
    call print_new_line 
    mov rdi, 0
    call exit
    .err:
        mov rdi, error
        call print_err
        


