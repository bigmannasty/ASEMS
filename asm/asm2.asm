BITS 64

section .data

section .text
global _start

_start:
	mov rax,60
	mov rdi,1
	syscall

