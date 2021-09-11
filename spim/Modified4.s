# Detecting small and large strings


.data
    prompt :	.asciiz "Enter a string: "
    newline : .asciiz	"\n"
    min : .asciiz "Minimum length string is : "
    max : .asciiz "Maxaximum length string is : "
    string : .space 256

.globl	main
	
.text
main:

	li	$s0, 10 
    li $s1,10 
    li $s2,0 
    li $s3,0 
    li $s4,0 
    li $s5,0 
    li $s6,1 
	li $s7,0 

	# prompt for input
	li	$v0, 4
	la	$a0, prompt
	syscall

	# read in the value
	li	$v0, 8
    la $a0,string
    li $a1,256
	syscall
	move 	$s0, $a0

	
loop:	
    bne $s6,1,in_skipping
    move $s7,$s0
    in_skipping :
    li $s6,0
    lb $t0,0($s0)
	beq $t0,10,check_force
    bne $t0,32,reset_skip
    check_force :
    li $s6,1
    bge $s3,$s1,min_skip
    move $s1,$s3
    move $s4,$s7
    min_skip :
    bgt $s2,$s3,max_skip
    move $s2,$s3
    move $s5,$s7
    max_skip :
    li $s3,0
	add	$s0, $s0, 1
	beq $t0,10,endloop
    j loop
    reset_skip :
    add $s3,$s3,1
	add	$s0, $s0, 1
	j loop
endloop:
    
	li	$v0, 4
	la	$a0, min
	syscall
    For :
    lb $t0,0($s4)
    beq $t0,32,endFor
    beq $t0,10,endFor
	li	$v0, 11
	move    $a0, $t0
	syscall
    add $s4,$s4,1
    j For
    endFor :

	li	$v0, 4
	la	$a0, newline
	syscall
	li	$v0, 4
	la	$a0, max
	syscall
    
    For_ :
    lb $t0,0($s5)
    beq $t0,32,endFor_
    beq $t0,10,endFor_
	li	$v0, 11
	move	$a0, $t0
	syscall
    add $s5,$s5,1
    j For_
    endFor_  :

	li	$v0, 4
	la	$a0, newline
	syscall


exit :
	
    li	$v0,10		# Code for syscall: exit
	syscall
