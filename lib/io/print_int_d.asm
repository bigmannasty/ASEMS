;;;;;;;; include ;;;;;;;;

%include "lib/io/buffer_flush.asm"


;;;;;;; define ;;;;;;;;

%ifndef PRINT_INT_D
%define PRINT_INT_D


print_int_d:


	push rax
	push rsi
	push rdx
	push rcx
	push r8


	;;;;; WARNING RAX IS TAKEN AS THE INT INPUT!!! ;;;;;
	; ;move integer value into rax
	xor rcx,rcx  				;set rcx to 0 for count
	mov r8,10
	cmp rax,0
	jne .is_negative  			;if int is != 0 skip to neg check
	push rax
	inc rcx
	jmp .buffer_setup

.is_negative:
	cmp rax,0
	jg .stack_loop
	not rax					;invert rax
	inc rax					;and inc to get the positive
	push rax
	mov rax,PRINT_BUFFER
	add rax,[PRINT_BUFFER_LENGTH]
	mov byte [rax],45
	inc rax
	mov [PRINT_BUFFER_LENGTH],rax
	pop rax


.stack_loop:

	xor rdx,rdx  				;set rdx(remainder reg) to 0
	div r8  				;computes rax/10 then stores R in rdx
	push rdx  				;pushes the remainder onto the stack
	inc rcx  				;increment rcx for digit count

	cmp rax,0
	jg .stack_loop  			;if int at rax > 0, back to loop start

.buffer_setup:
	
	mov rax,PRINT_BUFFER
	add rax,[PRINT_BUFFER_LENGTH]  		;set rax as the pointer to the current empty buffer index
	
	mov r8,PRINT_BUFFER
	add r8,PRINT_BUFFER_SIZE  		;set r8 as the max buffer size


.int_into_ascii_loop:
	
	pop rsi
	add rsi,48  				;pop the first digit off the stack and convert it to its ascii val
	
	mov byte [rax], sil  			;moves digit into rax index of buffer
	dec rcx  				;decrement counter of no. of digits
	inc rax  				;move onto next buffer index

	cmp r8,rax  				;checking if the buffer is full
	ja .no_flush  
	mov rdx,PRINT_BUFFER_SIZE
	mov [PRINT_BUFFER_LENGTH],rdx

	call print_buffer_flush

	mov rax,PRINT_BUFFER

.no_flush:
	
	cmp rcx,0  				;checks to see if the end of the number has been reached
	ja .int_into_ascii_loop
	sub rax,PRINT_BUFFER
	mov [PRINT_BUFFER_LENGTH],rax


	
	pop r8
	pop rcx
	pop rdx
	pop rsi
	pop rax

	ret


%endif
