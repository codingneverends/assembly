;Strings -- test for readstring and printstring
section .data
    newline :db 10
    space :db ' '
    msg1 : db "Enter a String : "
    size1 : equ $-msg1
    msg2 : db "Entered String is : "
    size2 : equ $-msg2
section .bss
    string : resb 50
    temp : resb 1
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
    mov ecx, msg2
    mov edx, size2
    int 80h

    mov ebx,string
    call printstring_rev
    
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
        mov byte[ebx],32
        inc ebx
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
    mov byte[temp],68
    movzx ecx,byte[temp]
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 80h
    popa
ret