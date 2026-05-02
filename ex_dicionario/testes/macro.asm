
%define N abs
%define X(n) n##:

section .data 

X(N) db "Hello, world", 10, 0

section .text 
global _start

_start: