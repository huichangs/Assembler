.data
	A : .space 100 #array A[25](A[5][5])
	x : .space 20 #array x[5](x[5][1])
	result : .space 20 #array result[[5](result[5][1])
	
	ASize : .word 100 #array A size
	xSize : .word 20 #array x size
	resultSize : .word 20 #array result size
	ARowSize : .word 20 #A row size to div 5
	
	newLine : .asciiz "\n"

.text

main :	
	 addi $t0, $zero, 0 #initialize $t0
	 addi $t1, $zero, 0 #initialize $t1
	 lw $s4 ARowSize #load ARowSize in $s4
	 lw $s5 ASize #load ASize in $s5
	 lw $s6 xSize #load xsize $s6
	 lw $s7 resultSize #load resultSize $s7
	 
	 #input A[25]
	 AInputLoop : 
	 	beq $t0, $s5, AInputExit #if (Ainputsize == Asize) goto AInputExit;
	 	sw $t0, A($t0) #input $t0 value at A[$t0]
	 	addi $t0, $t0, 4 #add 4(store next word)
	 	
	 	j AInputLoop #loop to input next value
	 #exit Ainput
	 AInputExit :
	 	li $t0, 0 #initialilze $t0
	 
	 #input x[5]
	 xInputLoop : 
	 	beq $t1, $s6, xInputExit #if (xinputsize == xsize) goto xInputExit;
	 	sw $t1, x($t1) #input $t1 value at x[$t1]
	 	addi $t1, $t1, 4 #add 4(store next word)
	 	
	 	j xInputLoop #loop to input next value
	 #exit xinput
	 xInputExit :
	 	li $t1, 0 #initialize $t1
	 
	 #calc A[5][5] * x[5][1] = result[5][1]
	 matrixMulti :
	 	beq $t0, $s5, matrixMultiExit #if ($t0 == 100) goto matrixMultiExit
	 	div $t0, $s4 #divide $t0 to set A[$t0] -> A[i][j], x[j][0], result[i][0]
	 	mflo $t1 #result row in array A, result (i)
	 	mfhi $t2 #remainder column in array A, row in array x (j)
	 	
	 	lw $s0, A($t0) #A[i][j]
	 	lw $s1, x($t2) #x[j][0]
	 	
	 	mul $t3, $s0, $s1 #A[i][j] * x[j][0]
	 	
	 	add $t1, $t1, $t1 #i * 2
	 	add $t1, $t1, $t1 #i * 4
	 	lw $t4, result($t1) #load result[i][0] to calc add
	 	
	 	add $t4, $t4, $t3 #add A[i][j] * x[j][0] + result[i][0]
	 	sw $t4, result($t1) #store new result[i][0]
	 	addi $t0, $t0, 4 #add 4(calc next word)
	 	
	 	j matrixMulti #loop
	 #exit matrixMulti and initialize $t0, $t1
	 matrixMultiExit :
	 	li $t0, 0
	 	li $t1, 0
	 
	 #print result[i][0]
	 printWhile : 
	 	beq $t0, $s7, printExit #if (i == resultSize) goto printExit;
	 	lw $t1, result($t0) #load result[i][0]
	 	
	 	#print result[i][0]
	 	li $v0, 1
	 	move $a0, $t1
	 	syscall
	 	
	 	#print \n
	 	li $v0, 4
	 	la $a0, newLine
	 	syscall
	 	
	 	addi $t0, $t0, 4 #add 4 to print next word
	 	
	 	j printWhile
	 #exit printWhile
	 printExit : 
	 
	 #terminate asm
	 li $v0, 10
	 syscall
	 	
	 
		
