;Write a program to read a number and find whether it is prime or not
section .data
msg1 : db 'Enter a number : ',
l1 : equ $-msg1
prime : db 'Prime Number',10
p1 : equ $-prime
primenot : db 'Not a Prime Number',10
p2 : equ $-primenot
iszero: db 'Neither a prime number nor a not prime',10
iszero_l : equ $-iszero
section .bss
d1 : resb 1
counter : resb 1
halfval : resb 1
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
	sub byte[d1], 30h
	mov byte[counter], 2
    mov ax,[d1]
    mov bl,2
    mov ah,0
    div bl;al -- quo
    mov byte[halfval],al
    cmp ax,0
    jne for
    mov eax, 4
        mov ebx, 1
        mov ecx, iszero
        mov edx, iszero_l
        int 80h
    jmp fin
	for:
		mov al, byte[counter]
		cmp al, byte[halfval]
        ja endfor
        mov ax,[d1]
        mov bl,byte[counter]
        mov ah,0
        div bl
        cmp ah,0
        je  notprime
		add byte[counter], 1
		mov al, byte[counter]
		cmp al, byte[halfval]
		jna for
    endfor:
        mov eax, 4
        mov ebx, 1
        mov ecx, prime
        mov edx, p1
        int 80h
    jmp fin
    notprime:
    mov eax, 4
	mov ebx, 1
	mov ecx, primenot
	mov edx, p2
	int 80h
    fin:
	mov eax, 1
	mov ebx, 0
	int 80h