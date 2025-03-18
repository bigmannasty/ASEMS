%ifndef PRINT_BUFFER_FLUSH
%define PRINT_BUFFER_FLUSH

print_buffer_flush:
	
	push rcx
	push r11

	push rsi
	push rdx
	push rax
	
	mov rsi,PRINT_BUFFER
	mov rdx,[PRINT_BUFFER_LENGTH]
	mov rax,1
	syscall
	xor rax,rax
	mov [PRINT_BUFFER_LENGTH],rax

	pop rax
	pop rdx
	pop rsi

	pop r11
	pop rcx
	
	ret

PRINT_BUFFER_LENGTH:
	dq 0

%endif

