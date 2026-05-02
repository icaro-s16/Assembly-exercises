%include "colon.inc" 

extern print 
extern print_int 
extern exit 
extern find_word


section .data 
d3: db "key 3", 0
d2: db "key 2", 0
d1: db "key 1", 0 

colon "key 3", node3
dd 2026

colon "key 2", node2 
db ", world", 0

colon "key 1", node1 
db "!!", 10, 0

section .text 
global _start

_start:
    mov rsi, node1
    mov rdi, d3
    call find_word
    mov edi, dword [ rax ]
    call print_int
    mov rsi, 0
    call exit 
    
