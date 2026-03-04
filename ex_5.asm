section .data
codes: db '0123456789ABCDEF'

section .text
global _start
_start:
  ; Move o número 1122... em formato hexadecimal para o registrador rax
  mov rax, 0x1122334455667788
  mov rdi, 1 
  mov rcx, 64 
  ; Cada 4 bits devem ser exibidos como um dígito hexadecimal 
  ; Usa o deslocamento (shift) e a operação bit a bit AND para isolá-lo
  ; O resultado é o offset no array 'codes'
.loop:
  push rax
  sub rcx, 4
  ; cl é um registrador, a parte menor de cx
  sar rax, cl
  and rax, 0xf

  lea rsi, [codes + rax]
  mov rax, 1 
  ; syscall deixa rcx e r11 alterados
  push rcx
  syscall
  pop rcx
  pop rax
  ; test é um comando usado para verificações rápidas, tipo é 'é um zero?'
  ; ele armazena os resultados nas flags ZF, usada no operação jnz
  jnz .loop
  mov rax, 60
  xor rdi, rdi
  syscall
