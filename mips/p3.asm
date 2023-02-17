.data
	enterMessage : .asciiz "Enter N : "
	N : .word 0
	returnFact : .word 0
.text

main :
	#print enter Message
	li $v0, 4
	la $a0, enterMessage
	syscall
	
	#read integer N
	li $v0, 5 
	syscall
	sw $v0, N
	li $v0, 1 #initialize $v0
	
	lw $a0, N #save N for use as an argument
	jal factorial #goto factorial(jump and link)
	
	sw $v0, returnFact #store return value at 'returnFact'
	
	#print result
	li $v0, 1
	lw $a0, returnFact
	syscall
	
	#terminate asm
	li $v0, 10
	syscall
	
#factorial function
factorial :
	#set $sp -8(return address(4), argument(4)) to adjust stack pointer
	addi $sp, $sp, -8

	sw $ra, 4($sp) #store return address
	sw $s0, ($sp) #store argument
	
	beq $a0, 1, calcFactorial #if(N == 1) mul start;
	
	move $s0, $a0 #set argument N
	sub $a0, $a0, 1 #N-1
	jal factorial #recursion factorial
	
	mul $v0, $s0, $v0 #mul
	
	calcFactorial :
		#load saved value
		lw $ra, 4($sp)
		lw $s0, ($sp)
		addi $sp, $sp, 8
		#jump to return address
		jr $ra
	
	
