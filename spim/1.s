# Fibonacci
#
# Written by  Gagan - B190480CS

.data
    prompt:	.asciiz "Enter in an integer: "
    newline: .asciiz	"\n"

.globl	main
	
.text
main:

	# initialize 
	li	$s0, 10 # loop check
	li $s1,1	# first ele
	li $s2,1	# second ele
	li $s3,1	# third ele
	li $s4,1	# loopi
	
	# prompt for input
	li	$v0, 4
	la	$a0, prompt
	syscall

	# read in the value
	li	$v0, 5
	syscall
	move 	$s0, $v0
    li	$v0, 1
	move	$a0, $s3
	syscall
    li	$v0, 4
	la	$a0, newline
	syscall
    beq $s0,1,exit
    li	$v0, 1
	move	$a0, $s3
	syscall
    li	$v0, 4
	la	$a0, newline
	syscall
    beq $s0,2,exit

    sub $s4,$s4,1

	
loop:	
	# print str1
	# li	$v0, 4
	# la	$a0, str1
	# syscall

	# print loop value
	beq $s0,$s4,exit

    add $s3,$s2,$s1
    move $s1,$s2
    move $s2,$s3

	li	$v0, 1
	move	$a0, $s3
	syscall

	# print newline
	li	$v0, 4
	la	$a0, newline
	syscall

	# increment loop
	add	$s4, $s4, 1
	j loop


exit :
	
    li	$v0,10		# Code for syscall: exit
	syscall