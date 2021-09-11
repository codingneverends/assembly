;Counting no of substrings
section .data
    newline :db 10
    space :db ' '
    msg1 : db "Enter main String : "
    size1 : equ $-msg1
    msg1_ : db "Enter sub String : "
    size1_ : equ $-msg1_
    msg2 : db "No of presence sub string prent in main string is  : "
    size2 : equ $-msg2
section .bss
    mainstring : resb 50
    substring : resb 50
    temp : resb 1
    num : resw 1
    count : resb 1
    _temp : resb 1
    len : resb 1
    pos : resb 1
    presence : resb 1
    outeri : resb 1
    imax : resb 1
    loopi : resb 1
    tempval : resb 1
section .text
    global _start
    _start :

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size1
    int 80h

    mov ebx,mainstring
    call readstring

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1_
    mov edx, size1_
    int 80h

    mov ebx,substring
    call readstring
    mov ebx,mainstring
    call strlen
    mov dl,byte[len]
    mov byte[imax],dl
    mov ebx,substring
    call strlen
    mov al,byte[len]
    dec al
    mov dl,byte[imax]
    add dl,al
    mov byte[imax],dl
    
    mov byte[presence],0
    mov ebx,mainstring
    mov eax,0
    mov byte[loopi],0
    for :
        mov dl,byte[loopi]
        cmp dl,byte[imax]
        jnb endFor
        mov dl,byte[ebx+eax]
        cmp dl,0
        je endFor
            push ebx
            push eax
            mov ebx,substring
                innerFor :
                    mov dl,byte[ebx]
                    cmp dl,0
                    je addendinnerFor
                    mov byte[tempval],dl
                    push ebx
                        mov ebx,mainstring
                        mov dl,byte[ebx+eax]
                    pop ebx
                    inc ebx
                    inc eax
                    cmp dl,byte[tempval]
                    jne endinnerFor
                jmp innerFor
                addendinnerFor :
                    inc byte[presence]
                endinnerFor :
            pop eax
            pop ebx
            inc eax
            inc byte[loopi]
        jmp for
        endFor :

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, size2
    int 80h

    mov dl,byte[presence]
    movzx ax,dl
    mov word[num],ax
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