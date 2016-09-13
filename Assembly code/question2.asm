.data
	notPrime: .asciiz "It is not prime"
	prime: .asciiz "It is prime"
	text: .asciiz "Enter a number:\n"
.text
	main:
		#initialise variables
		addi $t0, $zero, 1 #incrementer
		addi $t1, $zero, 0 #boolean to see if prime
		addi $t2, $zero, 0 #rem
		
		li $v0, 4
		la $a1, text
		jal printText
		#get user input
		li $v0, 5
		syscall
		#the value of $a2 will be checked if it prime
		move $a2, $v0
		jal checkPrime
		
		
		jal exit
	checkPrime:
		add $t0, $t0, 1
		blt $t0, $a2, loop
		#if this statement is executed then the number is a prime number
		add $t1, $zero, 1
		jal printPrime	
	loop:
		div $a2, $t0
		mfhi $t2
		bne $t2, $zero, checkPrime
		#if this statement is executed then the number is not a prime number
		add $t1, $zero, $zero
		jal printPrime
	printPrime:
		beq $t1, $zero, printNotPrime
		li $v0, 4
		la $a0, prime
		syscall
		jal exit
	printNotPrime:
		li $v0, 4
		la $a0, notPrime
		syscall
		jal exit
	printText:
		#will print the value in the register $a1
		li $v0, 4
		move $a0, $a1
		syscall
		jr $ra
	exit:
		li $v0, 10
		syscall
