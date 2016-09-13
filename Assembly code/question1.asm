.data
	palinText: .asciiz "Enter a number:\n"
	palinNo: .asciiz "It is not a palindrome\n"
	palinYes: .asciiz "It is a palindrome\n"
.text
	main:
	#variables
	addi $t0, $zero, 10 #t0 = 10
	addi $t1, $zero, 0 #t1 = rem
	
	#print prompt
	la $a1, palinText
	jal printText
	#get input and check palindrome
	li $v0, 5
	syscall
	move $a2, $v0
	move $t2, $v0 #create a duplicate to do a final check
	jal checkPalin #makes $a3 = 1 if palindrome and $a3 = 0 if not
	jal exit
	
	printText:
		li $v0, 4
		move $a0, $a1
		syscall
		jr $ra
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
		addi $a3, $zero, 1
		la $a1, palinYes
		jal printText
		jal exit
	notPalin:
		addi $a3, $zero, 0
		la $a1, palinNo
		jal printText
		jal exit
	exit:
		li $v0, 10
		syscall
		
		
		
		
