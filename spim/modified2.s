# Prgm 3 -- Co prime


.data
    prompt :	.asciiz "Enter a number: "
    newline : .asciiz	"\n"
    SAY_NO : .asciiz "No\n"
    SAY_YES : .asciiz "Yes\n"

.globl	main
	
.text
main:

	li	$t0, 0
	
	# prompt for input a number
	li	$v0, 4
	la	$a0, prompt
	syscall

	# read number
	li	$v0, 5
	syscall
	move 	$t0, $v0
	# prompt for second number
	li	$v0, 4
	la	$a0, prompt
	syscall

	# read next number
	li	$v0, 5
	syscall
	move 	$t2, $v0

    # 2 or -2 if 2 numbers differ by 2

    sub $t3,$t0,$t2
    beq $t3,-2,check_prime
    beq $t3,2,check_prime

    j say_not_coprime
    check_prime :

    add $a0,$t0,0
    # calling prime check function
    jal prime
    add $t3,$v0,0
    beq $t3,0,say_not_coprime

    add $a0,$t2,0
    # calling prime check function
    jal prime
    add $t4,$v0,0
    beq $t4,0,say_not_coprime

    # if both prime then

    say_coprime :
    li	$v0, 4
	la	$a0, SAY_YES
	syscall
    j exit

    say_not_coprime :
    li	$v0, 4
	la	$a0, SAY_NO
	syscall

exit :
	
    li	$v0,10		# exit
	syscall

# Check_prime function
# return 1 for prime
prime :
    li $v0,1
    beq $a0,2,prime_skip_check
    li $v0,0
    beq $a0,1,prime_skip_check
    li $v0,0
    li $v1,2
    prime_For :
    bge $v1,$a0,end_prime_For
    div $a0,$v1
    mfhi $t1
    beq $t1,0,prime_skip_check
    add $v1,$v1,1
    j prime_For
    end_prime_For :
    li $v0,1
    prime_skip_check :
    jr $ra

