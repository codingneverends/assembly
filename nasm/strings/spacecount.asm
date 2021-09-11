;Counting space
section .data
    newline :db 10
    space :db ' '
    msg1 : db "Enter a String : "
    size1 : equ $-msg1
    msg2 : db "No of Spaces : "
    size2 : equ $-msg2
section .bss
    string : resb 50
    temp : resb 1
    len : resb 1
    num : resw 1
    count : resb 1
    spaces : resb 1
    spaceflag : resb 1
section .text
    global _start
    _start :

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size1
    int 80h

    mov ebx,string
    call readstring
    
    mov byte[spaces],0
    mov ebx,string
    mov eax,0
    for :
        mov dl,byte[ebx+eax]
        cmp dl,0
        je endfor
        cmp byte[spaceflag],1
        jne dontinc
        cmp dl,' '; Avoid counting  : "hello               world" - if not 1 space eill count as 15 
        je dontinc
        inc byte[spaces]
        dontinc :
        mov byte[spaceflag],0
        cmp dl,' '
        jne flag_0
        mov byte[spaceflag],1
        flag_0 :
        inc eax
        jmp for
    endfor :

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, size2
    int 80h

    mov al,byte[spaces]
    movzx cx,al
    mov word[num],cx
    call print_num

    mov eax, 1
	mov ebx, 0
	int 80h

readstring :
    start_readstring :
        push ebx
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h
        pop ebx
        cmp byte[temp],10
        je end_readstring
        mov al,byte[temp]
        mov byte[ebx],al
        inc ebx
        jmp start_readstring
    end_readstring:
        mov byte[ebx],0
    ret

printstring :
    start_printstring :
        mov dl,byte[ebx]
        mov byte[temp],dl
        cmp byte[temp],0
        je end_printstring
        push ebx
        mov eax,4
        mov ebx,1
        mov ecx,temp
        mov edx,1
        int 80h
        pop ebx
        inc ebx
        jmp start_printstring
        end_printstring :
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
    ret

strlen :
    mov byte[len],0
    start_strlen :
        mov dl,byte[ebx]
        mov byte[temp],dl
        cmp byte[temp],0
        je end_strlen
        inc byte[len]
        inc ebx
        jmp start_strlen
        end_strlen :
    ret

    
print_num:
    mov byte[count],0
    cmp word[num],0
    jne skip___
    mov word[temp],30h
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
    skip___ :
    extract_no :
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
    print_no :
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
    end_print :
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 80h
ret