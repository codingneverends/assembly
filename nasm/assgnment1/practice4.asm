;Read a 2 digit number and find the sum of even numbers from 0 to that number
section .data
msg1 : db 'Enter first digit of first number :'
l1 : equ $-msg1
msg2 : db 'Enter second digit of first number :'
l2 : equ $-msg2
nwl : db ' ', 10
nwl_l : equ $-nwl
section .bss
d1 : resb 1
d2 : resb 1
n1 : resb 1
;ans0 : resb 1
ans1 : resb 1
ans2 : resb 1
ans3 : resb 1
ans4 : resb 1
junk : resb 1
counter : resw 1
sum : resw 1
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

	;First number calculation
	
	mov al, byte[d1]
	sub al, 30h
	mov bl, 10
	mov ah, 0;
	mul bl;ax=al*bl
	mov bx, word[d2]
	sub bx, 30h
	add ax, bx
	mov [n1], ax

	mov word[counter], 0
    mov word[sum],0

    for:
        add word[counter],2
        mov ax,word[counter]
        cmp ax,word[n1]
        ja endfor
        mov ax,word[counter]
        add word[sum],ax
        jmp for
    endfor:

	mov ax,word[sum]
    ;mov dx,0
    ;mov bx,1000
    ;div bx ;-- dx rem ; quo - ax
    ;mov [ans0],ax
    ;mov ax,dx

	mov bl, 100
	mov ah, 0
	div bl
	add al, 30h
	mov [ans4], ah
	mov [ans1], al
	mov ax, word[ans4]
	mov bl, 10
	mov ah, 0
	div bl
	add al, 30h
	add ah, 30h
	mov [ans2], al
	mov [ans3], ah
	
    ;mov eax, 4
	;mov ebx, 1
	;mov ecx, ans0
	;mov edx, 1
	;int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ans1
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ans2
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ans3
	mov edx, 1
	int 80h

    mov eax, 4
	mov ebx, 1
	mov ecx, nwl
	mov edx, nwl_l
	int 80h

    mov eax, 1
    mov ebx, 0
    int 80h
