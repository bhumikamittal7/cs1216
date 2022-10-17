.data
buffer: .space 50
L1: .asciiz "Enter an alphanumeric string: "
newline: .asciiz "\n"
L2: .asciiz "Error! Invalid Input. Enter an alphanumeric string of length less than 50"
#===================================================================================================================================
.text
main:
li $v0, 4	#print the string/prompt
la $a0, L1
syscall
li $v0, 8	#read string, s
la $a0, buffer	#allocate space = 50
li $a1, 50	#max character length
syscall
move $s0, $a0	#store s at $s0
#===================================================================================================================================
add $sp $sp -4
sw $ra 0($sp)
jal removeSpace1	#remove leading space and store in $s1
lw $ra 0($sp)
add $sp $sp 4
#===================================================================================================================================
add $sp $sp -4
sw $ra 0($sp)
jal strlen	#store the length of the string in $s2
lw $ra 0($sp)
add $sp $sp 4
#===================================================================================================================================
add $sp $sp -4
sw $ra 0($sp)
jal lowercase	#convert it into lowercase and save in $s3
lw $ra 0($sp)
add $sp $sp 4	
#===================================================================================================================================
		#FIGURE OUT HOW TO REMOVE TRAILING SPACES
#===================================================================================================================================


		
		#check if valid input
		
#===================================================================================================================================
		
		#check for palindrome
		
#===================================================================================================================================
Exit:
li $v0, 10	#exit
syscall
#==================================================================================================================================
strlen:
add $t1, $zero, $zero
loop1:
lb $t2, 0($a0)
beqz $t2, End1
addi $a0, $a0, 1
addi $t1, $t1, 1
j loop1

End1: 
addi $t1, $t1, -1
#li $v0 1
#move $a0, $t1
#syscall
move $s2, $t1
jr $ra
#===================================================================================================================================
removeSpace1:
addi $t4 $zero 32	#t4 = 32

loop2:
lb $t2, 0($a0)		#t2 gets the first char of the string
bne $t2, $t4, End2	#end when this char is not equal to space(32)
addi $a0, $a0, 1	#move pointer to next character
j loop2

End2: 
li $v0 4
la $a0 buffer
syscall
move $s1, $a0
jr $ra
#===================================================================================================================================
lowercase:
#move $t1, $s1
loop7:
lb $t1, 0($s1)
beqz $t1, Exit7
beq $t1, 10, Exit7
bge $t1, 65, Upper1
sb $t1, 0($s1)
addi $s1, $s1, 1
j loop7
Upper1:
ble $t1, 90, Upper2
sb $t1, 0($s1)
addi $s1, $s1, 1
j loop7
Upper2:
addi $t1, $t1, 32
sb $t1, 0($s1)
addi $s1, $s1, 1
j loop7

Exit7: 
li $v0 4
la $a0 buffer
syscall
jr $ra
#===================================================================================================================================
reverseString:
sub $t2, $s2, $zero
add $t1, $zero, $zero
loop3:
lb $t5, buffer($t1)
lb $t6, buffer($t2)
sb $t6, buffer($t1)
sb $t5, buffer($t2)
addi $t1, $t1, 1
addi $t2, $t2, -1
slt $t7, $t1, $t2
bnez $t7, loop3
la $a0, buffer

addi $t4 $zero 32
loop4:
lb $t2, 0($a0)
bne $t2, $t4, End4
addi $a0, $a0, 1
j loop4


End4:
li $v0 4
move $s3 $a0
syscall
move $s3 $a0
jr $ra
#===================================================================================================================================
add $sp $sp -4
sw $ra 0($sp)
jal reverseString	#remove trailing space and store in $s1
lw $ra 0($sp)
add $sp $sp 4

add $sp $sp -4
sw $ra 0($sp)
jal reverseString	#remove trailing space and store in $s1
lw $ra 0($sp)
add $sp $sp 4

add $sp $sp -4
sw $ra 0($sp)
jal strlen	#store the length of the string in $s2
lw $ra 0($sp)
add $sp $sp 4
