section .data
    space:db ' '
    newline:db 10
    msg1: db "Enter the number of elements of First array: "
    size1: equ $-msg1
    msg4: db "Enter elements of First array: "
    size4: equ $-msg4
    msg1_: db "Enter the number of elements of Second array: "
    size1_: equ $-msg1_
    msg4_: db "Enter elements of Second array: "
    size4_: equ $-msg4_
    msg2: db "Elements in both array  : "
    size2: equ $-msg2
    msg_nil: db "Nil ",10
    size_nil: equ $-msg_nil
section .bss
    nod: resb 1
    num: resw 1
    temp: resb 1
    counter: resw 1
    num1: resw 1
    num2: resw 1
    n1: resd 10
    n: resd 10
    n2: resd 10
    array1: resw 50
    array2: resw 50
    matrix: resw 1
    count: resb 10
    cur_no : resw 1
    flag_ : resb 1
section .text
    global _start
    _start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size1
    int 80h
    call read_num
    mov cx,word[num]
    mov word[n1],cx
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, size4
    int 80h
    mov eax,dword[n1]
    mov dword[n],eax
    mov ebx,array1
    mov eax,0
    call read_array
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1_
    mov edx, size1_
    int 80h
    call read_num
    mov cx,word[num]
    mov word[n2],cx
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4_
    mov edx, size4_
    int 80h
    mov eax,dword[n2]
    mov dword[n],eax
    mov ebx,array2
    mov eax,0
    call read_array
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, size2
    int 80h
    mov ebx,array1
    mov eax,0
    mov dx,0
    mov byte[flag_],0
    loop1:
        mov cx,word[ebx+2*eax]
        mov word[cur_no],cx
        inc eax
        push rax
        push rbx
        push rcx
        mov ebx,array2
        mov eax,0
            loop2:
                mov cx,word[ebx+2*eax]
                inc eax
                cmp cx,word[cur_no]
                jne skipcount
                    mov word[num],cx
                    push rax
                    push rbx
                    mov byte[flag_],1
                    call print_num
                    pop rbx
                    pop rax
                skipcount:
                cmp eax,dword[n2]
                jb loop2


        pop rcx
        pop rbx
        pop rax
        cmp eax,dword[n1]
        jb loop1
    exit:
    cmp byte[flag_],0
    jne p_skip
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_nil
    mov edx, size_nil
    int 80h
    p_skip:
    mov eax,1
    mov ebx,0
    int 80h

print_array:
    ;pusha
    print_loop:
    cmp eax,dword[n]
    je end_print1
    mov cx,word[ebx+2*eax]
    mov word[num],cx
    ;;The number to be printed is copied to ’num’
    ;;before calling print num function
    push rax
    push rbx
    call print_num
    pop rbx
    pop rax
    inc eax
    jmp print_loop
    end_print1:
    ;popa
    ret

read_array:
    ;pusha
    read_loop:
    cmp eax,dword[n]
    je end_read_
    push rax
    push rbx
    call read_num
    pop rbx
    pop rax
    ;;read num stores the input in ’num’
    mov cx,word[num]
    mov word[ebx+2*eax],cx
    inc eax
    ;;Here, each word consists of two bytes, so the counter should be
    ;;incremented by multiples of two. If the array is declared in bytes
    ;;domov word[ebx+eax],cx
    jmp read_loop
    end_read_:
    ;popa
    ret

read_num:
    ;;push all the used registers into the stackusing pusha
    ;;pusha
    ;;store an initial value 0 to variable ’num’
    mov word[num], 0
    loop_read:
    ;; read a digit
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    ;;check if the read digit is the end of number,i.e, the enter-key whose ASCII key is 
    cmp byte[temp],10
    je end_read
    cmp byte[temp],32
    je end_read
    mov ax, word[num]
    mov bx, 10
    mul bx
    mov bl, byte[temp]
    sub bl, 30h
    mov bh, 0
    add ax, bx
    mov word[num], ax
    jmp loop_read
    end_read:
    ret

print_num:
    mov byte[count],0
    ;;pusha
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
    end_print:
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 80h
    ;;The memory location ’newline’ should be declared with the ASCII key for
    ;;new line in section.data.
    ;;popa
ret