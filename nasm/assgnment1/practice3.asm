;Practice3
section .data
msg1 : db 'Enter first number :'
l1 : equ $-msg1
msg2 : db 'Enter second number :'
l2 : equ $-msg2
msg_1 : db 'Divisible',10
l_1 : equ $-msg_1
msg_2 : db 'Not Divisible',10
l_2 : equ $-msg_2
nwl : db 10
l :equ $-nwl
section .bss
d1 : resb 1
d2 : resb 1
junk : resb 1

section .text
	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d1
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, junk
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d2
	mov edx, 1
	int 80h

	sub byte[d1], 30h
	sub byte[d2], 30h

    mov ax,word[d1]
    mov ah,0
    mov bl,byte[d2]
    div bl
    cmp ah,0

    
	mov eax, 4
	mov ebx, 1

    je if
        mov ecx,msg_2
        mov edx,l_2
    jmp endif
    if:
        mov ecx,msg_1
        mov edx,l_1
    endif:
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, nwl
	mov edx, l
	int 80h
	
	mov eax, 1
	mov ebx, 0
	int 80h
