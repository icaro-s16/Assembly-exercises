section .text
global memset
global memcpy 

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

; Recv the dest address in rdi 
; Recv the src address in rsi 
; Recv the src size in rdx 
memcpy:
  cmp rdx, 0 
  jle .end 

  xor r14, r14 
  .loop:
    mov r13B, byte [rdi + r14]
    mov byte [rsi + r14], r13B 
    
    inc r14 
    
    cmp r14, rdx 
    jl .loop 
  .end:
    ret
















