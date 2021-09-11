# Find Replace Print
#
# Written by  Gagan - B190480CS

.data
    prompt:	.asciiz "Enter a string: "
    newline: .asciiz	"\n"
    search : .asciiz "String to Search : "
    replace : .asciiz "String to replace : "
    buf : .space 256
    bufs : .space 256
    bufr : .space 256

.globl	main
	
.text
main:
	li	$s0, 10 # main string
    li $s1,10 # search
    li $s2,0 # replace

	# prompt for input
	li	$v0, 4
	la	$a0, prompt
	syscall
	# read in the main string
	li	$v0, 8
    la $a0,buf
    li $a1,256
	syscall
	move 	$s0, $a0

    # prompt for input
	li	$v0, 4
	la	$a0, search
	syscall
	# read in the value
	li	$v0, 8
    la $a0,bufs
    li $a1,256
	syscall
	move 	$s1, $a0

    # prompt for input
	li	$v0, 4
	la	$a0, replace
	syscall
	# read in the value
	li	$v0, 8
    la $a0,bufr
    li $a1,256
	syscall
	move 	$s2, $a0

	
loop :	
    lb $t0,0($s0) # main string loaded
	beq $t0,10,endloop
    lb $t1,0($s1) # find string loaded
    bne $t1,$t0,skipFor
    li $t1,1
    For :
    add $s6,$s0,$t1
    add $s7,$s1,$t1
    lb $t2,0($s6)
    lb $t3,0($s7)
    beq $t3,10,endFor
    beq $t2,10,endloop
    bne $t2,$t3,skipFor
    add $t1,$t1,1
    j For
    endFor :
    beq $t2,32,skip_For
    beq $t2,10,skip_For
    j skipFor
    skip_For :
    add $s0,$s0,$t1
    add $s6,$s2,0
    p_For :
    lb $t0,0($s6)
    beq $t0,10,endp_For
    li	$v0, 11
	move    $a0, $t0
    syscall
    add $s6,$s6,1
    j p_For
    endp_For :
    beq $t2,10,endloop
    skipFor :
    lb $t0,0($s0)
    li	$v0, 11
	move    $a0, $t0
    syscall
	add	$s0, $s0, 1
	j loop
endloop:
	li	$v0, 4
	la	$a0, newline
	syscall
    
exit :
	
    li	$v0,10		# Code for syscall: exit
	syscall
