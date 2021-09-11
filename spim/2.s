# Prime
#
# Written by  Gagan - B190480CS

.data
    prompt :	.asciiz "Enter an integer: "
    newline : .asciiz	"\n"
    no : .asciiz "No\n"
    yes : .asciiz "Yes\n"

.globl	main
	
.text
main:

	# initialize 
	li	$s0, 0 # loop check
	
	# prompt for input
	li	$v0, 4
	la	$a0, prompt
	syscall

	# read in the value
	li	$v0, 5
	syscall
	move 	$s0, $v0
	# prompt for input
	li	$v0, 4
	la	$a0, prompt
	syscall

	# read in the value
	li	$v0, 5
	syscall
	move 	$s1, $v0

    sub $s2,$s0,$s1
    beq $s2,2,checkpls
    beq $s2,-2,checkpls

    j sayno
    checkpls :

    add $a0,$s0,0
    jal prime
    add $t3,$v0,0
    beq $t3,0,sayno

    add $a0,$s1,0
    jal prime
    add $t4,$v0,0
    beq $t4,0,sayno

    sayyes :
    li	$v0, 4
	la	$a0, yes
	syscall
    j exit

    sayno :
    li	$v0, 4
	la	$a0, no
	syscall

exit :
	
    li	$v0,10		# Code for syscall: exit
	syscall

prime :
    li $v0,1
    beq $a0,2,skipcheck
    li $v0,0
    beq $a0,1,skipcheck
    li $v0,0
    li $t0,2
    prime_For :
    bge $t0,$a0,end_prime_For
    div $a0,$t0
    mfhi $t1
    beq $t1,0,skipcheck
    add $t0,$t0,1
    j prime_For
    end_prime_For :
    li $v0,1
    skipcheck :
    jr $ra

