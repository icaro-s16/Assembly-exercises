extern print
extern print_new_line
extern exit

section .data 

error_msg: db "Error!", 10, 0

x1:
dq x2
db "Valor 1", 10, 0


x2: 
dq 0
db "valor 2", 10, 0


section .text
global _start


; Recv: rdi -> address 1, rsi -> index
get_linked_list:
    xor r14, r14 
    .loop:  
        cmp r14, rsi 
        je .end 
        inc r14 
        cmp qword [rdi], 0
        je .error
        mov rax, qword [ rdi ]
        mov rdi, rax 
        jmp .loop 
    .end:
        add rdi, 8
        mov rax, rdi
        ret 
    .error:
        mov rax, error_msg 
        ret 
        



_start:
    mov rdi, x1
    mov rsi, 2
    call get_linked_list
    mov rdi, rax 
    call print 
    mov rdi, 0
    call exit 