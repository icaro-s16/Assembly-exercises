extern print
extern exit
extern print_int
extern print_new_line

%define NULL 0x0 
%define O_RDONLY 0x0 
%define PROT_READ 0x1
%define MAP_PRIVATE 0x02


%define STRUCT_STAT 144
%define ST_FILE_SIZE 48


section .data
fname: db "ex_1.asm", 0
label: db "File Size: ", 0

section .bss
stat: resb STRUCT_STAT
st_size: resb 20

section .text 
global _start



; Recv the address in rdi
; Recv the value to set in rsi 
; Recv the size in rdx 
memset:
  xor r14, r14 
  cmp rdx, 0 
  jle .end 
  .loop:
    mov byte [rdi + r14], sil
    inc r14 
    cmp r14, rdx
    jge .loop 
  .end:
    ret 


_start: 
  ; Opening the file 
  mov rax, 2 
  lea rdi, [fname]   
  mov rsi, O_RDONLY   ; Define the open mode to Read Only
  mov rdx, NULL       ; No args in mode argument 
  syscall             ; Recv the file descriptor in rax 

  ; Mapping the file
  mov r8, rax         ; Mov the file descriptor   
  mov rax, 9
  mov rdi, NULL       ; Set the start address NULL 
  mov rsi, 4096       ; Set the amount address to map 
  mov rdx, PROT_READ  ; Set the map to be only read 
  mov r10, MAP_PRIVATE; set the to be privat 
  syscall             ; Return the virtual address in rax 
  
  push rax 

  ; Closing the file
  mov rax, 3
  mov rdi, r8
  syscall 

  pop rdi 
  call print

  lea rdi, [label]
  call print
  
  lea rdi, [stat]
  mov rsi, NULL
  mov rdx, STRUCT_STAT 
  call memset 
  
  mov rax, 4
  lea rdi, [ fname ]
  lea rsi, [ stat ]
  syscall 
  
  mov rdi, qword [stat + ST_FILE_SIZE]
  call print_int

  call print_new_line

  mov rdi, 0 
  call exit

