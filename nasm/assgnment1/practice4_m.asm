section .data
    msg : db 'Enter number : ',
    l1 : equ $-msg
    msg2 : db 'Sum is  '
    l2 : equ $-msg2
    nwl : db ' ',10
    nwl_l : equ $-nwl
    neg_sn : db '-'
    neg_sn_l : equ $-neg_sn
section .bss
    num resw 1
    count resb 1
    neg_ resb 1
    num1 resw 1
    counter resw 1
    sum resw 1
temp resb 1
section .text
	global _start:
	_start:
    mov word[num],0
    mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, l1
	int 80h
    call read_num

    mov ax,word[num]
    mov word[num1],ax    

    mov word[counter], 0
    mov word[sum],0

    for:
        add word[counter],2
        mov ax,word[counter]
        cmp ax,word[num1]
        ja endfor
        mov ax,word[counter]
        add word[sum],ax
        jmp for
    endfor:

    mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

    mov ax,word[sum]
    mov word[num],ax
    call print_num

    mov eax, 1
	mov ebx, 0
	int 80h
    
read_num:
    mov word[num], 0
    mov byte[neg_],1
    loop_read:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h
        cmp byte[temp], 10
        je end_read
        cmp byte[temp],45
        je set_neg
        mov ax, word[num]
        mov bx, 10
        mul bx
        mov bl, byte[temp]
        sub bl, 30h
        mov bh, 0
        add ax, bx
        mov word[num], ax
    jmp loop_read
    set_neg:
        mov byte[neg_],-1
        jmp loop_read
    end_read:
        mov dx,0
        mov al, [num]
        mov bl, [neg_]
        imul bl
        mov word[num],ax

ret



print_num:
    mov byte[count],0
    cmp word[num],32767
    ja print_negsn
    extract_no:
        cmp word[num], 0
        je print_no
        inc byte[count]
        mov dx, 0
        mov ax, word[num]
        mov bx, 10
        div bx
        push dx
        mov word[num], ax
        jmp extract_no
    print_no:
        cmp byte[count], 0
        je end_print
        dec byte[count]
        pop dx
        mov byte[temp], dl
        add byte[temp], 30h
        mov eax, 4
        mov ebx, 1
        mov ecx, temp
        mov edx, 1
        int 80h
        jmp print_no
    jmp end_print
    print_negsn:
        mov eax,4
        mov ebx,1
        mov ecx,neg_sn
        mov edx,neg_sn_l
        int 80h
        mov ax,65535
        sub ax,word[num]
        add ax,1
        mov word[num],ax
        jmp extract_no
    end_print:
        mov eax,4
        mov ebx,1
        mov ecx,nwl
        mov edx,nwl_l
        int 80h
ret