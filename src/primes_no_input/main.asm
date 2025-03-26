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

	;;;COUNTING PRIMES;;;

	mov rax,[CURRENT_NUM]  	;num to be checked
	mov rdi,2  		;divider
	mov rcx,10  		;how many primes to count
	mov rdx,0
	mov rsi,SPACES
	
	call print_int_d
	call print_string
	dec rcx

.prime_loop:
	cmp rcx,0  		;check if the counter has hit 0 yet
	je .exit  		;if yes skip to the exit call
	xor rdx,rdx  		;reset rdx to avoid error
	div rdi  		;div rax by rdi
	cmp rdx,0  		;check the remainder
	jg .next_div  		;if the remainder isn't 0 then move on to the next div
	jmp .next_num		;move onto the next number

.is_prime:
	dec rcx			;dec rcx
	mov rax,[CURRENT_NUM]
	call print_int_d	;print the num
	call print_string	;new line
	jmp .next_num		;onto the next num

.next_div:
	cmp rax,rdi  		;check if the divider is bigger than the result
	jl .is_prime		;if it is then the .is_prime block is exectued
	mov rax,[CURRENT_NUM] 	;retrieve current prime cand. from var
	inc rdi  		;inc the divider
	jmp .prime_loop  	;back to loop


.next_num:
	mov rax,[CURRENT_NUM] 	;retrieve current prime cand.
	inc rax  		;increment to next cand.
	mov [CURRENT_NUM],rax  	;save it to the var
	mov rdi,2  		;reset the divider to 2
	jmp .prime_loop  	;jump back to the prime loop


.exit:
	mov rsi,NEWLINE
	call print_string
	call print_buffer_flush
	mov rax,60
	mov rdi,1
	syscall

SPACES:
	db 32,32,32,0

NEWLINE:
	db 10,0

CURRENT_NUM:
	dq 2

END:

PRINT_BUFFER:
