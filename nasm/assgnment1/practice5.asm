;Comparing Two one digit numbers
section .data
msg1 : db 'Enter first number : '
l1 : equ $-msg1
msg2 : db 'Enter second number : '
l2 : equ $-msg2
msg3 : db 'GCD is : '
l3 : equ $-msg3
nwl : db ' ',10
l :equ $-nwl
section .bss
d1 : resb 1
d2 : resb 1
junk : resb 1
val : resb 1

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

    for:
        mov ax,[d1]
        mov bl,byte[d2]
        mov ah,0
        div bl
        mov byte[d1],ah
        add bl,30h
        mov byte[val],bl
        cmp ah,0
        je fin
        mov ax,[d2]
        mov bl,byte[d1]
        mov ah,0
        div bl
        mov byte[d2],ah
        add bl,30h
        mov byte[val],bl
        cmp ah,0
        je fin
        jmp for
	fin:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg3
        mov edx, l3
        int 80h
		mov eax, 4
		mov ebx, 1
		mov ecx, val
		mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, nwl
	mov edx, l
	int 80h
	
	mov eax, 1
	mov ebx, 0
	int 80h
