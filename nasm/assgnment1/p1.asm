section .data
name : db 'Gagan Lal',10
l : equ $-name

add1 : db 'Eckamattathil house, Thattakuzha P O',0ah
l1 : equ $-add1
add2 : db 'Thattakuzha',0ah
l2 : equ $-add2
add3 : db 'Idukki , 685581',0ah
l3 : equ $-add3

section .text

global _start:
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, name
	mov edx, l
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, add1
	mov edx, l1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, add2
	mov edx, l2
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, add3
	mov edx, l3
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h

