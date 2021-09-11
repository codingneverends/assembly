# Detecting small and large strings
#
# Written by  Gagan - B190480CS

.data
    prompt:	.asciiz "Enter a string: "
    newline: .asciiz	"\n"
    min : .asciiz "Min length string is : "
    max : .asciiz "Max length string is : "
    buf: .space 256

.globl	main
	
.text
main:

	# initialize 
	li	$s0, 10 # loop check let s0 contain string
    li $s1,10 # min-length
    li $s2,0 # max length
    li $s3,0 # iterator cur-length
    li $s4,0 # min word index
    li $s5,0 # max word index
    li $s6,1 # flag
	li $s7,0 # temp word index

	# prompt for input
	li	$v0, 4
	la	$a0, prompt
	syscall

	# read in the value
	li	$v0, 8
    la $a0,buf
    li $a1,256
	syscall
	move 	$s0, $a0

	
loop:	
    bne $s6,1,skip_temp_in
    move $s7,$s0
    skip_temp_in :
    li $s6,0
    lb $t0,0($s0)
	beq $t0,10,forcecheck
    bne $t0,32,skipreset
    forcecheck :
    li $s6,1
    bge $s3,$s1,skipmin
    move $s1,$s3
    move $s4,$s7
    skipmin :
    bgt $s2,$s3,skipmax
    move $s2,$s3
    move $s5,$s7
    skipmax :
    li $s3,0
	add	$s0, $s0, 1
	beq $t0,10,endloop
    j loop
    skipreset :
    add $s3,$s3,1
	# increment loop
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
