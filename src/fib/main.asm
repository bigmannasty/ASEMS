;;;;;;;;DEFINITIONS;;;;;;;;

%define LOAD_ADDRESS 0x00020000
%define CODE_SIZE END-(LOAD_ADDRESS+0x78)
%define PRINT_BUFFER_SIZE 1024

;;;;;;;;HEADER;;;;;;;;

BITS 64
org LOAD_ADDRESS
ELF_HEADER:
	db 0x7F,"ELF"
	db 0x02
	db 0x01
	db 0x01
	db 0x09
	db 0x00
	times 7 db 0x00
	dw 0x0002
	dw 0x003E
	dd 0x00000001
	dq START
	dq 0x0000000000000040
	dq 0x0000000000000000
	dd 0x0000000
	dw 0x0040
	dw 0x0038
	dw 0x0001
	dw 0x0000
	dw 0x0000
	dw 0x0000

PROGRAM_HEADER:
	dd 0x00000001
	dd 0x00000007
	dq 0x0000000000000078
	dq LOAD_ADDRESS+0x78
	dq 0x0000000000000000
	dq CODE_SIZE
	dq CODE_SIZE+PRINT_BUFFER_SIZE
	dq 0x0000000000000000

;;;;;;;;includes;;;;;;;;;

%include "lib/io/print_string.asm"
%include "lib/io/print_int_d.asm"


;;;;;;;;instructions;;;;;;;;

START:

	mov rax,0
	mov rdi,1
	mov rdx,1
	mov rsi,NEWLINE
	mov rcx,10
	mov r8,3

.first_3_loop:
	
	call print_int_d
	call print_string

	mov rax,1
	dec r8
	cmp r8,0
	jg .first_3_loop
	
.fib_loop:
	
	add rax,rdi
	call print_int_d
	call print_string
	
	mov rdx,rax
	mov rax,rdi
	mov rdi,rdx

	dec rcx
	cmp rcx,0
	jg .fib_loop

	call print_buffer_flush

	
	xor rdi,rdi
	mov rax,60
	syscall


NEWLINE:
	db 10,0

END:


PRINT_BUFFER:

