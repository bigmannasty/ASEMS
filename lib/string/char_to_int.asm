%ifndef CHAR_TO_INT
%define CHAR_TO_INT
%define MAX_STRING_SIZE 1024

;;;include;;;

%include "lib/io/print_int_d.asm"

char_to_int:
	
	;;;USES RAX AS OUTPUT!!!;;;

	push rdx
	push rbx

	xor rax,rax		;initialise to 0
	mov rdx,-1		;set to -1
	mov rbx,10		;multiplier


.main_loop:
	
	inc rdx			;increment
	cmp rdx,7
	jg .return
	
	cmp byte [rsi+rdx],0	;check for null
	je .return
	cmp byte [rsi+rdx],48	;check for non-num char
	jl .not_num
	cmp byte [rsi+rdx],57
	jg .not_num
	
	push rdx
	mul rbx			;move onto next digit
	pop rdx
	
	xor rbx,rbx
	mov bl, [rsi+rdx]	;add current char into rbx
	sub rbx,48		;turn rbx char into int
	add rax,rbx 		;add int to rax
	mov rbx,10		;reset rbx to multiplier

	jmp .main_loop		;restart


.not_num:
	mov rax,0		;given string has an invalid character


.return:

	pop rbx
	pop rdx

	ret

%endif

