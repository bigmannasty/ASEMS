%ifndef PRINT_STRING
%define PRINT_STRING

;;;include;;;
%include "lib/io/print_chars.asm"


print_string:

	push rdx
	
	mov rdx,-1

.print_string_loop:
	inc rdx
	cmp byte [rsi+rdx],0  ;go through the string, incrementing rdx(length of the buffer) until you find the null termination char(0)
	jne .print_string_loop

	call print_chars  ;print out the string with the new found length of the string

	pop rdx

	ret

%endif

