section .data
    space:db ' '
    newline:db 10
    msg1: db "Enter the number of elements : "
    size1: equ $-msg1
    msg2: db "Highest Occuring one  : "
    size2: equ $-msg2
    msg3: db "Lowest  Occuring one : "
    size3: equ $-msg3
    msg4: db "Enter elements : "
    size4: equ $-msg4
section .bss
    nod: resb 1
    num: resw 1
    temp: resb 1
    counter: resw 1
    num1: resw 1
    num2: resw 1
    n: resd 10
    array: resw 50
    matrix: resw 1
    count: resb 10
    high_no : resw 1
    low_no : resw 1
    low_i : resw 1
    high_i : resw 1
    cur_count : resw 1
    cur_no : resw 1
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
    mov word[n],cx
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, size4
    int 80h
    mov ebx,array
    mov eax,0
    call read_array
    mov ebx,array
    mov eax,0
    mov dx,0
    mov byte[cur_count],0
    mov byte[low_i],99
    mov byte[high_i],0
    loop1:
        mov cx,word[ebx+2*eax]
        mov word[cur_no],cx
        inc eax
        push rax
        push rbx
        push rcx
        mov ebx,array
        mov eax,0
        mov byte[cur_count],0
            loop2:
                mov cx,word[ebx+2*eax]
                inc eax
                cmp cx,word[cur_no]
                jne skipcount
                    inc byte[cur_count]
                skipcount:
                cmp eax,dword[n]
                jb loop2


        pop rcx
        pop rbx
        pop rax

        mov dx,word[cur_count]
        cmp word[high_i],dx
        jnb skiphigh
            mov word[high_i],dx
            mov word[high_no],cx
        skiphigh:
        cmp word[low_i],dx
        jna skiplow
            mov word[low_i],dx
            mov word[low_no],cx
        skiplow:
        cmp eax,dword[n]
        jb loop1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, size2
    int 80h
    mov ax,word[high_no]
    mov word[num],ax
    call print_num
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, size3
    int 80h
    mov ax,word[low_no]
    mov word[num],ax
    call print_num
    exit:
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