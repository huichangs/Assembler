#Sum of even numbers from 1 to N
.data
	enter : .asciiz "Enter the num : "
	print : .asciiz "result : "
	
.text

main : 
	li $s0, 2 #N will be divided by 2
	
	li $v0, 4
	la $a0, enter
	syscall
	
	li $v0, 5 #read integer N
	syscall
	move $t0, $v0 #store N value at $t0
	
	li $t1, 0 #store temp 0 value for sum
	
	#even calc
	loop :
		div $t0, $s0
		mfhi $t3 #store remainder at $t3
		beq $t3, 1, pass #if N is odd, pass add calc
		add $t1, $t1, $t0 #if N is even, add $t0 at $t1
		pass : #empty instruction to skip add if N is odd
		sub $t0, $t0, 1 #next N (N--)
		beq $t0, 0, end #if N is 0, end loop
		j loop #if N is not 0, return to loop
		
	end :
		#print result
		li $v0, 4
		la $a0, print
		syscall
		
		move $a0, $t1
		li $v0, 1 
		syscall
	
	#terminate asm
	li $v0, 10 
	syscall
