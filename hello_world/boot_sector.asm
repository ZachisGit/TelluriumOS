; ############################ #
; Bootloader address 0000:7c00 #
; ############################ #
[org 0x7c00]

mov bx, hello_word_str
call write_str
call loop

; Writes a char to the screen (using int 0x10)
; al=char to be printed
write_char:
	push ax

	mov ah, 0x0e
	int 0x10

	pop ax
	ret

; Writes a string to the screen (using int 0x10)
; bx=string address
write_str:
	push bx
	push ax

	jmp .draw_loop

	.draw_loop:
		mov al, [bx]
		cmp al, 00
		je .done

		mov al, [bx]
		call write_char
		inc bx
		jmp .draw_loop

	.done:
		pop ax
		pop bx
		ret



loop:
	jmp loop;	; loop around

hello_word_str:
	db "Hello World!", 0

; $ = current position
; $$ = current section beginning 
; (in this case($-$$ == $-0 == $-0000:7c00))
times 510-($-$$) db 0
dw 0xaa55