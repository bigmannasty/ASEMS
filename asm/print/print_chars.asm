%ifndef PRINT_CHARS
%define PRINT_CHARS

;;;include;;;
%include "bufferFlush.asm"


print_chars:

	push rsi
	push rdx
	push rcx
	push rax
	push r8
	
	mov rax,PRINT_BUFFER
	add rax,[PRINT_BUFFER_LENGTH]
	
	add rdx,rsi
	
	mov r8,PRINT_BUFFER
	add r8,PRINT_BUFFER_SIZE

.buffer_load_loop:
	mov byte cl,[rsi]
	mov byte [rax],cl
	inc rsi
	inc rax
	cmp r8,rax
	ja .no_flush
	mov rcx,PRINT_BUFFER_SIZE
	mov [PRINT_BUFFER_LENGTH],rcx
	call print_buffer_flush
	mov rax,PRINT_BUFFER

.no_flush:
	cmp rsi,rdx
	jb .buffer_load_loop
	sub rax,PRINT_BUFFER
	mov [PRINT_BUFFER_LENGTH],rax
	
	pop r8
	pop rax
	pop rcx
	pop rdx
	pop rsi
	
	ret

%endif

