section .data
    msg1 : db 'enter the string', 10
    l1 : equ $-msg1
    msg2 : db 'number of spaces in the string', 10
    l2 : equ $-msg2
    newline : db '', 10
    string_len : db 0

section .bss
    string : resb 50
    temp : resb 1
    num : resw 1
    count : resb 1
    space_count : resw 1

section .text
global _start:
    _start:

    mov word[space_count], 0

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, l1
    int 80h

    mov ebx, string
    call read_string

    mov ebx, string
    counting:
    mov al, byte[ebx]
    cmp al, 0
    je end_counting
    cmp al,' '
    je inc_v

    next:
    inc ebx
    jmp counting

    end_counting:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, l2

    mov ax, word[space_count]
    mov word[num], ax
    call print_num

    mov eax, 1
    mov ebx, 0
    int 80h

    inc_v:
    inc word[space_count]
    jmp next

read_string:
pusha

reading:
push ebx
mov eax, 3
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h

pop ebx
cmp byte[temp], 10
je end_reading

mov al, byte[temp]
mov byte[ebx], al
inc ebx
jmp reading

end_reading:
mov byte[ebx], 0
mov ebx, string
popa
ret

print_num:
mov byte[count],0
cmp word[num], 0
jne skip_zero_print
skip_zero_print:
pusha

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
mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h

popa
ret
