;;;;;;;;DEFINITIONS;;;;;;;;

%define LOAD_ADDRESS 0x00020000
%define CODE_SIZE END-(LOAD_ADDRESS+0x78)


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
	dq CODE_SIZE
	dq 0x0000000000000000

;;;;;;;;includes;;;;;;;;;

; %include "syscalls.asm"


;;;;;;;;instructions;;;;;;;;

START:

	mov rcx,11
	mov rax,1
	mov rdi,1
	mov rbx,0

.loop:
	cmp rbx,0
	jg .odd
	jmp .even

	
.even:
	
	add rax,rdi
	dec rcx
	inc rbx
	cmp rcx,0
	jg .loop
	mov rdi,rax
	jmp .exit

	
.odd:
	
	add rdi,rax
	dec rcx
	dec rbx
	cmp rcx,0
	jg .loop


.exit:

	mov rax,60
	syscall

END:

