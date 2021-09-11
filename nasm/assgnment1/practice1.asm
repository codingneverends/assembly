;Read 3 two-digit numbers and print the second largest number among them.
section .data
msg1 : db 'Enter first digit of first number :'
l1 : equ $-msg1
msg2 : db 'Enter second digit of first number :'
l2 : equ $-msg2
msg3 : db 'Enter first digit of second number :'
l3 : equ $-msg3
msg4 : db 'Enter second digit of second number :'
l4 : equ $-msg4
msg5 : db 'Enter first digit of third number :'
l5 : equ $-msg5
msg6 : db 'Enter second digit of third number :'
l6 : equ $-msg6
msg7 : db ' ', 10
l7 : equ $-msg7
section .bss
d1 : resb 1
d2 : resb 1
d3 : resb 1
d4 : resb 1
d5 : resb 1
d6 : resb 1
n1 : resb 1
n2 : resb 1
n3 : resb 1
ans1 : resb 1
ans2 : resb 1
junk : resb 1
junk1 : resb 1
junk2 : resb 1
junk3 : resb 1
junk4 : resb 1
junk5 : resb 1
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

	mov eax, 3
	mov ebx, 0
	mov ecx, junk1
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
	mov [n1], ax;n1=d1*10+d2

	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, l3
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d3
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, junk2
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg4
	mov edx, l4
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d4
	mov edx, 1
	int 80h
	
    mov eax, 3
	mov ebx, 0
	mov ecx, junk3
	mov edx, 1
	int 80h
	
	;Second number calculation

	mov al, byte[d3]
	sub al, 30h
	mov bl, 10
	mov ah, 0
	mul bl
	mov bx, word[d4]
	sub bx, 30h
	add ax, bx
	mov [n2], ax;n2
	

	mov eax, 4
	mov ebx, 1
	mov ecx, msg5
	mov edx, l5
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d5
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, junk4
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg6
	mov edx, l6
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d6
	mov edx, 1
	int 80h
	
    ;Third number calculation

    mov al, byte[d5]
	sub al, 30h
	mov bl, 10
	mov ah, 0
	mul bl
	mov bx, word[d6]
	sub bx, 30h
	add ax, bx
	mov [n3], ax;n2
	
    ;x,y,z if(x>y){ if(x<z) x else  }
    mov al,[n1]
    cmp al,[n2]
    ja if1
        mov al,[n1]
        cmp al,[n3]
        ja if4
            mov al,[n2]
            cmp al,[n3]
            jb if5
                mov ax,word[n3]
                jmp fin
            if5:
                mov ax,word[n2]
                jmp fin
        if4:
            mov ax,word[n1]
            jmp fin
    if1:
        mov al,[n1]
        cmp al,[n3]
        jb if2
            mov al,[n2]
            cmp al,[n3]
            ja if3
                mov ax,word[n3]
                jmp fin
            if3:
                mov ax,word[n2]
                jmp fin
        if2:
            mov ax,word[n1]
            jmp fin
    fin:
        mov bl, 10
        mov ah, 0
        div bl

        mov byte[ans1], al
        mov byte[ans2], ah
        add byte[ans1], 30h
        add byte[ans2], 30h

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

        mov eax, 1
        mov ebx, 0
        int 80h
