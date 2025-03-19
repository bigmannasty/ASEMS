;;;;;;;;DEFINITIONS;;;;;;;;

%define LOAD_ADDRESS 0x00020000
%define CODE_SIZE END-(LOAD_ADDRESS+0x78)
%define PRINT_BUFFER_SIZE 4096


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
	
	mov rdi,0
	mov rax,0
	mov rsi,INPUT_STRING
	mov rdx,15
	
	push r11
	push rcx

	syscall

	pop rcx
	pop r11

	mov rax,1
	mov rdi,1

	call print_string

	mov rsi,NEWLINE
	
	mov rax,[SOME_NUM]
	call print_int_d
	call print_string
	inc rax
	mov [SOME_NUM],rax
	mov rax,[SOME_NUM]
	call print_int_d
	call print_string

	call print_buffer_flush


	jmp .exit


.exit:
	mov rax,60
	syscall



NEWLINE:
	db 10,0

SOME_NUM:
	dq 10

INPUT_STRING:

END:

PRINT_BUFFER:
