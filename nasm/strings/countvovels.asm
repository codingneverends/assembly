;Counting vovels
section .data
    newline :db 10
    space :db ' '
    msg1 : db "Enter a String : "
    size1 : equ $-msg1
    msg_ : db "No of vovels : "
    size_ : equ $-msg_
    ;setcolor db 1Bh, '[36;40m', 0
    ;.len equ $ - setcolor
section .bss
    string : resb 50
    temp : resb 1
    num : resw 1
    count : resb 1
    count_ : resb 1
section .text
    global _start
    _start :

    ;mov eax, 4
    ;mov ebx, 1
    ;mov ecx, setcolor
    ;mov edx, setcolor.len
    ;int 80h
    ;mov eax, 1
    ;xor ebx, ebx
    ;int 80h

    mov byte[count_],0

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size1
    int 80h

    mov ebx,string
    call readstring


    mov ebx,string
    start_counting :
        mov dl,byte[ebx]
        mov byte[temp],dl
        cmp byte[temp],0
        je end_counting
        push ebx
            mov al,byte[ebx]
            cmp al,32
            je skip_U
            cmp al,'a'
            jne skip_a
                inc  byte[count_]
            skip_a :
            cmp al,'A'
            jne skip_A
                inc  byte[count_]
            skip_A :
            cmp al,'e'
            jne skip_e
                inc  byte[count_]
            skip_e :
            cmp al,'E'
            jne skip_E
                inc  byte[count_]
            skip_E :
            cmp al,'i'
            jne skip_i
                inc  byte[count_]
            skip_i :
            cmp al,'I'
            jne skip_I
                inc  byte[count_]
            skip_I :
            cmp al,'o'
            jne skip_o
                inc  byte[count_]
            skip_o :
            cmp al,'O'
            jne skip_O
                inc  byte[count_]
            skip_O :
            cmp al,'u'
            jne skip_u
                inc  byte[count_]
            skip_u :
            cmp al,'U'
            jne skip_U
                inc  byte[count_]
            skip_U :
        pop ebx
        inc ebx
        jmp start_counting
        end_counting :
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_
    mov edx, size_
    int 80h
    mov cx,word[count_]
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