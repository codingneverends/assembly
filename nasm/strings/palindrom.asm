;Strings -- Plaindrome
section .data
    newline :db 10
    space :db ' '
    msg1 : db "Enter a String : "
    size1 : equ $-msg1
    msg2 : db "String is palindrome",10
    size2 : equ $-msg2
    msg2_ : db "String is not  palindrome",10
    size2_ : equ $-msg2_
section .bss
    string1 : resb 50
    temp : resb 1
    len : resb 1
    count : resb 1
    num : resb 1
    rev : resb 1
    flag : resb 1
    temp_ : resb 1
section .text
    global _start
    _start :

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size1
    int 80h

    mov ebx,string1
    call readstring

    mov ebx,string1
    ;call toLoweCase
    call strlen
    mov al,byte[len]
    dec al
    mov byte[rev],al
    
    mov byte[flag],0

    mov eax,0
    Loop :
        mov ebx,string1
        mov dl,byte[ebx+eax]
        mov byte[temp_],dl
        cmp dl,0
        je endLoop
        push eax
            mov al,byte[rev]
            movzx eax,al
            mov al,byte[ebx+eax]
            cmp byte[temp_],al
            je skip_pali
                inc byte[flag]
            skip_pali :
            dec byte[rev]
        pop eax
        inc eax
        jmp Loop
    endLoop :

    cmp byte[flag],0
    jne not_pali
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, size2
        int 80h
    jmp pali
    not_pali :
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2_
        mov edx, size2_
        int 80h
    pali :

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
toLoweCase :
    start_convert_tolow :
        mov dl,byte[ebx]
        mov byte[temp],dl
        cmp byte[temp],0
        je end_convert_tolow
        cmp dl,94
        ja skip_low_convert
            add dl,32
            mov byte[ebx],dl
        skip_low_convert :
        inc ebx
        jmp start_convert_tolow
        end_convert_tolow :
    ret
toUpperCase :
    start_convert_toup :
        mov dl,byte[ebx]
        mov byte[temp],dl
        cmp byte[temp],0
        je end_convert_toup
        cmp dl,94
        jb skip_up_convert
            sub dl,32
            mov byte[ebx],dl
        skip_up_convert :
        inc ebx
        jmp start_convert_toup
        end_convert_toup :
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