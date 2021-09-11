# Prgm - 1

.data
    enter_a_num :	.asciiz "Enter a number: "
    newline: .asciiz	"\n"

.globl	main
	
.text
main:

	# initialize 
	li	$t0, 10 
	li $t1,1	# n1
	li $t2,1	# n2
	li $t3,1	# n3
	li $t4,1	# i for loop
	
	li	$v0, 4
	la	$a0, enter_a_num 
	syscall

	# reading number
	li	$v0, 5
	syscall
	move 	$t0, $v0
    li	$v0, 1
	move	$a0, $t3
	syscall
    li	$v0, 4
	la	$a0, newline
	syscall
    beq $t0,1,exit
    li	$v0, 1
	move	$a0, $t3
	syscall
    li	$v0, 4
	la	$a0, newline
	syscall
    beq $t0,2,exit

    sub $t4,$t4,1

	
For:	
	beq $t0,$t4,exit

    add $t3,$t2,$t1
    move $t1,$t2
    move $t2,$t3

	li	$v0, 1
	move	$a0, $t3
	syscall

    # new line after each number
	li	$v0, 4
	la	$a0, newline
	syscall

	# i++
	add	$t4, $t4, 1
	j For


exit :
	
    li	$v0,10		#Exit
	syscall