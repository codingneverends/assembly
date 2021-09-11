;Removing all ocuurences of sub string in a string
section .data
    newline :db 10
    space :db ' '
    msg1 : db "Enter a String : "
    size1 : equ $-msg1
section .bss
    string : resb 100
    temp : resb 1
    substring : resb 20
    areequal : resb 1
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

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size1
    int 80h

    mov ebx,substring
    call readstring

    mov ebx,string
    mov ecx,substring
    For :
    cmp byte[ebx],0
    je endFor
        mov edx,ebx
        call case_avoid_cmp
        cmp byte[areequal],1
        jne skip_rem
            push ebx
            mov edx,ebx
            checkFor :
            cmp byte[ecx],0
            je delendcheckFor
            cmp byte[edx],0
            je endcheckFor
                call case_avoid_cmp
                cmp byte[areequal],1
                jne endcheckFor
            inc edx
            inc ecx
            jmp checkFor
            delendcheckFor :
                    mov edx,ebx
                    mov ecx,substring
                    DelFor :
                    cmp byte[ecx],0
                    je EndDelFor
                    mov byte[edx],1
                    inc ecx
                    inc edx
                    jmp DelFor
                    EndDelFor :
            endcheckFor :
            pop ebx
        skip_rem :
    inc ebx
    mov ecx,substring
    jmp For
    endFor :

    mov ebx,string
    call printstring
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

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
        cmp byte[temp],1
        je skip_print_force
        push ebx
        mov eax,4
        mov ebx,1
        mov ecx,temp
        mov edx,1
        int 80h
        pop ebx
        skip_print_force :
        inc ebx
        jmp start_printstring
        end_printstring :
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
    ret

printstring_rev :
    cmp byte[ebx],0
    je ret_fn
        pusha
            inc_ebx_32_0 :
            cmp byte[ebx],32
            je inc_ebx_32_0_end
            inc ebx
            jmp inc_ebx_32_0
            inc_ebx_32_0_end :
            inc ebx
            call printstring_rev
        popa
        pusha
            inc_ebx_32_0_ :
            cmp byte[ebx],32
            je inc_ebx_32_0_end_
            pusha
                mov cl,byte[ebx]
                mov eax, 4
                mov ebx, 1
                mov byte[ecx], cl
                mov edx, 1
                int 80h
            popa
            inc ebx
            jmp inc_ebx_32_0_
            inc_ebx_32_0_end_ :
            inc ebx
            pusha
                mov cl,32
                mov eax, 4
                mov ebx, 1
                mov byte[ecx], cl
                mov edx, 1
                int 80h
            popa
        popa
    ret_fn :
    ret

printa:
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx,temp
    mov edx, 1
    int 80h
    popa
ret

case_avoid_cmp :
    pusha
    mov byte[areequal],0
    ;edx and ecx
    mov al,byte[ecx]
    mov bl,byte[edx]
    cmp al,94
    ja skip_idl
        add al,32
    skip_idl :
    cmp bl,94
    ja skip_icl
        add bl,32
    skip_icl :
    cmp al,bl
    jne egual_s
    mov byte[areequal],1
    egual_s :
    popa
ret