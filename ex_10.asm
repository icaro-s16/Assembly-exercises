section .data
test: dq -1

section .text
global _start

_print:
  mov rax, 1
  mov rdi, 1
  mov rdx, 1
  add qword[test], 42
  lea rsi, [test]
  syscall
  sub qword[test], 42
  ret

_start:
  mov byte[test], 1
  call _print
  mov word[test], 1
  call _print
  mov dword[test], 1
  call _print 
  mov qword[test], 1
  call _print
  mov rax, 60
  xor rdi, rdi
  syscall
