%ifndef PRINT_BUFFER_FLUSH
%define PRINT_BUFFER_FLUSH

print_buffer_flush:
	
	push rcx  ;;affected registers in
	push r11  ;;the write syscall

	push rsi
	push rdx
	push rax
	push rdi
	
	mov rdi,1
	mov rsi,PRINT_BUFFER  ;moving address of the buffer into rsi(source/pointer reg for write syscall)
	mov rdx,[PRINT_BUFFER_LENGTH]  ;moving the length of the print buffer into rdx(strlen for write syscall)
	mov rax,1  ;setting rax to the std out writing sys val
	syscall  ;print out the buffer by iterating through each byte between rsi(start address) until rsi+rdx(strlen in bytes)
	xor rax,rax  ;set rax to 0
	mov [PRINT_BUFFER_LENGTH],rax  ;set the buffer length to rax/0

	pop rdi
	pop rax
	pop rdx
	pop rsi

	pop r11
	pop rcx
	
	ret

PRINT_BUFFER_LENGTH:
	dq 0

%endif

