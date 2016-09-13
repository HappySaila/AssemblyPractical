.data
	N: .word 0
	M: .word 0
	start: .asciiz "Enter the starting point N:\n"
	end: .asciiz "Enter the ending point M:\n"
	answer: .asciiz "The palindromic primes are:\n"
	skip: .asciiz "\n"
.text
	main:
	#initialising
	addi $t5, $zero, 0 #N value
	addi $t6, $zero, 0 #N value
	la $a1, start
	jal printText
	
	li $v0, 5
	syscall
	move $t5, $v0
	addi $t5, $t5, 1
	
	la $a1, end
	jal printText
	
	li $v0, 5
	syscall
	move $t6, $v0
	
	la $a1, answer
	jal printText
	
	jal palindromePrime
	
	palindromePrime:
		blt $t5, $t6, forLoop
		jal exit
	forLoop:
		move $a2, $t5
		jal palinMain
	printText:
		li $v0, 4
		move $a0, $a1
		syscall
		jr $ra
		
	palinMain:
	addi $t0, $zero, 10 #t0 = 10
	addi $t1, $zero, 0 #t1 = rem
	move $t2, $t5
	jal checkPalin	
	checkPalin:
	#value to be checked is saved in $a2
	#check if number is greater than 0, returns 0 if false and 1 if true
	sgt $s0, $a2, $zero
	bne $s0, $zero, true
	#once while loop is false, if rem == $a2 then the number is palindromic
	beq $t1, $t2, palin
	jal notPalin
	true:
		#dig equal to $a0 % 10, dig = $s1
		#$a2/10
		div $a2, $t0
		mfhi $s1
		mflo $a2
		#rem * 10 + dig
		mul $t1, $t1, $t0
		add $t1, $t1, $s1
		#go back to checking statements
		jal checkPalin
	palin:
		move $a2, $t5
		#jal prime
		jal prime
	notPalin:
		addi $t5, $t5, 1
		jal palindromePrime
		
		
		
	prime:
		#initialise variables
		addi $t0, $zero, 1 #incrementer
		addi $t1, $zero, 0 #boolean to see if prime
		addi $t2, $zero, 0 #rem
		jal checkPrime
	checkPrime:
		add $t0, $t0, 1
		blt $t0, $a2, loop
		#if this statement is executed then the number is a prime number
		jal printPrime	
	loop:
		div $a2, $t0
		mfhi $t2
		bne $t2, $zero, checkPrime
		#if this statement is executed then the number is not a prime number
		jal notPalin
	printPrime:
		li $v0, 1
		move $a0, $t5
		syscall
		li $v0, 4
		la $a0, skip
		syscall
		jal notPalin #will increment N and run loop again
		
	exit:
		li $v0, 10
		syscall
