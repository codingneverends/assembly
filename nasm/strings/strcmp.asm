;String Comaprison
section .data
    newline :db 10
    space :db ' '
    msg1 : db "Enter a String : "
    size1 : equ $-msg1
    msg2 : db "Lexographical Order is : ",10
    size2 : equ $-msg2
section .bss
    string1 : resb 50
    string2 : resb 50
    temp : resb 1
    isstring2first : resb 1
    _temp : resb 1
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
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size1
    int 80h

    mov ebx,string2
    call readstring
    ;mov ebx,string2
    ;call toLoweCase

    mov byte[isstring2first],0

    mov eax,0
    Loop :
        mov ebx,string1
        mov dl,byte[ebx+eax]
        mov byte[_temp],dl
        cmp dl,0
        je endLoop
        mov ebx,string2
        mov dl,byte[ebx+eax]
        cmp dl,0
        je endLoop
        cmp dl,byte[_temp]
        jnb set
            mov byte[isstring2first],1
            jmp endLoop
        set : 
        jna set_
            mov byte[isstring2first],0
            jmp endLoop
        set_ :
        inc eax
        jmp Loop
    endLoop :


    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, size2
    int 80h

    cmp byte[isstring2first],1
    je skipT
        mov ebx,string1
        call printstring
    skipT :
        mov ebx,string2
        call printstring
    cmp byte[isstring2first],1
    jne skipT_
        mov ebx,string1
        call printstring
    skipT_ :

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