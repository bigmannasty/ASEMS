%ifndef PRINT_CHARS
%define PRINT_CHARS

;;;include;;;
%include "lib/io/buffer_flush.asm"


print_chars:

	push rsi
	push rdx  ;
	push rcx
	push rax
	push r8
	
	mov rax,PRINT_BUFFER  ;move address of the buffer into rax
	add rax,[PRINT_BUFFER_LENGTH]  ;add the length(in bytes) of the buffer to rax
	
	add rdx,rsi  ;add the val at rsi(string address) to rdx
	
	mov r8,PRINT_BUFFER  ;mov the address of the buffer into r8
	add r8,PRINT_BUFFER_SIZE  ;add the overall size of the buffer (4096 usually) to r8, giving the maximum address for a print

.buffer_load_loop:
	mov byte cl,[rsi]  ;move the first byte of rsi(source reg so first char of string) into cl(8-bit reg for char)
	mov byte [rax],cl  ;move the char from cl into rax
	inc rsi  ;rsi++ to move onto the next char in the string (incrementing the address basically)
	inc rax  ;rax++ to move onto the next car position in the buffer
	cmp r8,rax  ;if rax(pointer) points to outside the max allowed size of the buffer, flush the buffer
	ja .no_flush
	mov rcx,PRINT_BUFFER_SIZE  ;move the buffer size(usually 4096) into rcx
	mov [PRINT_BUFFER_LENGTH],rcx  ;set the value of the buffer length(i.e. the bytes already taken up) to the buf size indicating that it's full
	call print_buffer_flush  ;flush it out into the console
	mov rax,PRINT_BUFFER  ;reset the address of rax to the start of the buffer

.no_flush:
	cmp rsi,rdx  ;if rsi(current char address of the string) hasn't hit the end of the string, repeat the load_loop 
	jb .buffer_load_loop
	sub rax,PRINT_BUFFER  ;if rsi has reached the end of the string, sub the start address of the buffer from rax(current byte in the buffer)
	mov [PRINT_BUFFER_LENGTH],rax  ;the subtraction leaves the length of the total used bytes of the buffer, then set the buffer len to that
	
	pop r8
	pop rax
	pop rcx
	pop rdx
	pop rsi
	
	ret

%endif

