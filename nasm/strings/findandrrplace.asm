;Finding a string and replacing with another string
section .data
    newline :db 10
    space :db ' '
    msg1 : db "Enter String : "
    size1 : equ $-msg1
    msg2 : db "String to be changed : "
    size2 : equ $-msg2
    msg3 : db "String to be replaced as : "
    size3 : equ $-msg3
    msg4 : db "New String is : "
    size4 : equ $-msg4
section .bss
    string1 : resb 200
    string_search : resb 10
    string_replace : resb 10
    stringtemp : resb 200
    temp : resb 1
    isstring2first : resb 1
    _temp : resb 1
    readstring_array_size : resb 1
    end_read_string_ele : resb 1
    strlen_s_ar : resb 1
    len : resb 1
    strcmp_val : resb 1
section .text
    global _start
    _start :

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size1
    int 80h

    mov byte[readstring_array_size],10
    mov ebx,string1
    call readstring_array
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, size2
    int 80h

    mov ebx,string_search
    call readstring

    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, size3
    int 80h

    mov ebx,string_replace
    call readstring

    movzx eax,byte[readstring_array_size]
    mov edx,string_search
    mov ebx,string1
    mov ecx,string_replace
    call search_string_array_

    mov byte[readstring_array_size],10
    mov ebx,string1
    call printstring_array
    mov eax, 4
    mov ebx, 1
    mov byte[ecx], 10
    mov edx, 1
    int 80h

    mov eax, 1
	mov ebx, 0
	int 80h

readstring_array :
    push ebx
    movzx eax,byte[readstring_array_size]
    mov byte[end_read_string_ele],0
    ;mov byte[readstring_array_size],10
    start_read_s_ar :
        cmp byte[end_read_string_ele],1
        je end_read_s_ar
        push eax
        push ebx
        call readstring_ele
        pop ebx
        pop eax
        add ebx,eax
        jmp start_read_s_ar
    end_read_s_ar :
        mov byte[ebx],0
        pop ebx
    ret

readstring_ele :
    start_readstring_ele :
        push ebx
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h
        pop ebx
        cmp byte[temp],32
        je end_readstring_ele
        cmp byte[temp],10
        je end_readstring_ele
        mov al,byte[temp]
        mov byte[ebx],al
        inc ebx
        jmp start_readstring_ele
    end_readstring_ele:
        cmp byte[temp],10
        jne end_readstring_ele_
        mov byte[end_read_string_ele],1
        end_readstring_ele_ :
        mov byte[ebx],0
    ret

search_string_array_ :
    cmp byte[ebx],0
    je end_search_string_array_
    pusha

    movzx eax,byte[readstring_array_size]

    add ebx,eax
    call search_string_array_
    
    popa

    pusha
        call strcmp
        cmp byte[strcmp_val],1
        jne skip_D
            pusha
                mov edx,ebx
                mov ebx,ecx;string_replace
                call strcpy
            popa
        skip_D :
    popa

    end_search_string_array_ :
    ret


printstring_array :
    push ebx
    movzx eax,byte[readstring_array_size]
    ;mov byte[readstring_array_size],10
    start_print_s_ar :
        cmp byte[ebx],0
        je end_print_s_ar
        push ebx
        push eax
        call printstring_ele
        pop eax
        pop ebx
        add ebx,eax
        jmp start_print_s_ar
    end_print_s_ar :
        mov eax, 4
        mov ebx, 1
        mov byte[ecx], 10
        mov edx, 1
        int 80h
        pop ebx
    ret

printstring_ele :
    push ebx
    start_printstring_ele :
        mov dl,byte[ebx]
        mov byte[temp],dl
        cmp byte[temp],0
        je end_printstring_ele
        push ebx
        mov eax,4
        mov ebx,1
        mov ecx,temp
        mov edx,1
        int 80h
        pop ebx
        inc ebx
        jmp start_printstring_ele
        end_printstring_ele :
    mov eax, 4
    mov ebx, 1
    mov byte[ecx], 32
    mov edx, 1
    int 80h
    pop ebx
    ret

strlen_array :
    push ebx
    mov byte[strlen_s_ar],0
    movzx eax,byte[readstring_array_size]
    start_strlen_ar :
        cmp byte[ebx],0
        je end_strlen_ar
        add ebx,eax
        inc byte[strlen_s_ar]
        jmp start_strlen_ar
    end_strlen_ar :
        pop ebx
    ret

arr_cpy :
    push ebx
    push edx
    movzx eax,byte[readstring_array_size]
    start_arr_cpy :
        cmp byte[ebx],0
        je end_arr_cpy
            pusha
                call strcpy
            popa
        add ebx,eax
        add edx,eax
    jmp start_arr_cpy 
    end_arr_cpy :
        mov byte[edx],0
        pop edx
        pop ebx
    ret
test_ :
 pusha
    mov eax, 4
    mov ebx, 1
    mov byte[ecx], 68
    mov edx, 1
    int 80h
 popa
 ret

 strcpy :
    push ebx
    push edx
    start_strcpy :
    cmp byte[ebx],0
    je end_strcpy
    mov al,byte[ebx]
    mov byte[edx],al
    inc ebx
    inc edx
    jmp start_strcpy
    end_strcpy :
    mov byte[edx],0
    pop edx
    pop ebx
    ret

strcmp :
    push ebx
    push edx
        pusha
            push ebx
            mov ebx,edx
            call strlen
            mov al,byte[len]
            pop ebx
            call strlen
            mov byte[strcmp_val],1
            cmp al,byte[len]
            je skip_cmp
                ja skip_a_cmp
                mov byte[len],0
                jmp skip_b_cmp
                skip_a_cmp :
                mov byte[len],2
                skip_b_cmp :
            skip_cmp :
        popa
        
        start_cmp_for :
        cmp byte[ebx],0
        je end_cmp_for
        cmp byte[edx],0
        je end_cmp_for
            mov al,byte[ebx]
            cmp al,byte[edx]
            je skip_cmp_for
            ja skip_cmp_for_a
                mov byte[strcmp_val],0
                jmp skip_cmp_for_b
            skip_cmp_for_a :
                mov byte[strcmp_val],2
            skip_cmp_for_b :
            jmp end_cmp_for
            skip_cmp_for :
        inc ebx
        inc edx
        jmp start_cmp_for
        end_cmp_for :
    pop edx
    pop ebx
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

