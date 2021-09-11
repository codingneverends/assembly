# Co Cardinate
#
# Written by  Gagan - B190480CS

.data
    prompt:	.asciiz "Enter a string: "
    newline: .asciiz	"\n"
    search : .asciiz "String to Search : "
    replace : .asciiz "String to replace : "
    buf : .space 256
    bufs1 : .space 256
    bufs2 : .space 256

.globl	main
	
.text
main:
	li	$s0, 10 # string_con
    li $s1,10 # string1
    li $s2,0 # string2

	# prompt for input
	li	$v0, 4
	la	$a0, prompt
	syscall
	# read in the main string
	li	$v0, 8
    la $a0,bufs1
    li $a1,256
	syscall
	move 	$s1, $a0

    # prompt for input
	li	$v0, 4
	la	$a0, prompt
	syscall
	# read in the value
	li	$v0, 8
    la $a0,bufs2
    li $a1,256
	syscall
	move 	$s2, $a0
    la $s0,buf

For1 :
    lb $t0,0($s1)
    beq $t0,10,endFor1
    sb $t0,0($s0)
    
    add $s1,$s1,1
    add $s0,$s0,1
    j For1
    endFor1 :
For2 :
    lb $t0,0($s2)
    beq $t0,10,endFor2
    sb $t0,0($s0)
    
    add $s2,$s2,1
    add $s0,$s0,1
    j For2
    endFor2 :
    li $t0,10
    sb $t0,0($s0)

    
	li	$v0, 4
	la	$a0, buf
	syscall

	li	$v0, 4
	la	$a0, newline
	syscall
    
exit :
	
    li	$v0,10		# Code for syscall: exit
	syscall
