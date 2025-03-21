%ifndef SCAN_STRING
%define SCAN_STRING
%define MAX_STRING_SIZE 1024

;;;include;;;


scan_string:

	push r11  ;syscall regs
	push rcx

	push rax  ;syscall num
	push rdi  ;file des/io stream arg
	push rdx  ;string size max
	
	mov rdx,MAX_STRING_SIZE
	mov rax,0
	mov rdi,0

	syscall

	pop rdx
	pop rdi
	pop rax

	pop rcx
	pop r11
	
	ret

%endif

