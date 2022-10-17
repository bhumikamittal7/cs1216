.data
buffer: .space 50
L1: .asciiz "Enter an alphanumeric string: "
newline: .asciiz "\n"
L2: .asciiz "Error! Invalid Input. Enter an alphanumeric string of length less than 50"
palindrome: .asciiz "Yes, the string is a palindrome."
notPalindrome: .asciiz "No, the string is not a palindrome."
#===================================================================================================================================
.text
main:
li $v0, 4	
la $a0, L1
syscall				#ask user to enter string
li $v0, 8			#read string, s
la $a0, buffer			#allocate space = 50
li $a1, 51			#fixing max character length to n-1 = 50
syscall

add $sp $sp -4
sw $ra 0($sp)
jal isvalid			#check validity
lw $ra 0($sp)
add $sp $sp 4

add $sp $sp -4
sw $ra 0($sp)
jal lowecase_loop		#convert lowercase
lw $ra 0($sp)
add $sp $sp 4

la $a0, buffer			#lowercase valid string goes in $a0
move $t2, $zero			#place pointer at the end
move $t1, $zero 		#place pointer at the start

gotoEnd_loop:			#pointer to the end
lb $t3, buffer($t2)
beqz $t3, pointerEnd
addi $t2, $t2, 1
j gotoEnd_loop

pointerEnd:
addi $t2, $t2, -2

backSpace:
lb $t3, buffer($t2)		#get last character in $t3
bne $t3, 32, leadingSpace	#if not a whitespace jump to leadingspace
addi $t2, $t2, -1		#go to previous character
j backSpace			#keep checking until no trailing white space

leadingSpace:
lb $t3, buffer($t1)		#get first char in $t3
bne $t3, 32, noSpace		#if not a whitespace jump to nospace
addi $t1, $t1, 1		#if a whitespace, check next character
j leadingSpace			#keep checking until no white space

noSpace:			#t1 is pointing at the first non-space charcter and $t2 is pointing at the last non-space character
lb $t8, buffer($t1)
lb $t9, buffer($t2)
bne $t8, $t9, isnotPalindrome
addi $t1, $t1, 1
addi $t2, $t2, -1
bge $t1, $t2, isPalindrome
j noSpace

isPalindrome:
li $v0, 4	
la $a0, palindrome
syscall	
li $v0, 10			#exit
syscall

isnotPalindrome:
li $v0, 4	
la $a0, notPalindrome
syscall	
li $v0, 10			#exit
syscall
#===================================================================================================================================
lowecase_loop:
lb $t1, 0($a0)
beqz $t1, done
beq $t1, 10, done
bge $t1, 65, Upper1
sb $t1, 0($a0)
addi $a0, $a0, 1
j lowecase_loop

Upper1:
ble $t1, 90, Upper2
sb $t1, 0($a0)
addi $a0, $a0, 1
j lowecase_loop

Upper2:
addi $t1, $t1, 32
sb $t1, 0($a0)
addi $a0, $a0, 1
j lowecase_loop

done: 
jr $ra
#===================================================================================================================================
isvalid:
move $t0, $a0

valid_loop:
lb $t1, 0($t0)
beqz $t1, validString
beq $t1, 10, validString
bge $t1, 33, b
addi $t0, $t0, 1
j valid_loop

b:
ble $t1, 47, invalid
bge $t1, 58, b1
addi $t0, $t0, 1
j valid_loop

b1:
ble $t1, 64, invalid
bge $t1, 91, b2
addi $t0, $t0, 1
j valid_loop

b2:
ble $t1, 96, invalid
bge $t1, 123, b3
addi $t0, $t0, 1
j valid_loop

b3:
ble $t1, 126, invalid
addi $t0, $t0, 1
j valid_loop

invalid:
li $v0, 4	
la $a0, L2
syscall	
li $v0, 10			#exit
syscall

validString:
jr $ra
