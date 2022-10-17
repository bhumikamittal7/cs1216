.data
L1: .asciiz "Enter N: "
L2: .asciiz "Naive : "
newline: .asciiz "\n"
L3: .asciiz "Input is erroneous"
L4: .asciiz "Interesting: "
#===================================================================================================================================
.text
li $v0, 4	#print the string/prompt
la $a0 L1
syscall
li $v0, 5	#read integer, n
syscall
add $t0, $v0, $zero	#store n at $t0
ble $t0, $zero, Else	#check if input is valid, jump to else
#===================================================================================================================================
addi $sp, $sp -12	#saving data
sw $fp, 8($sp)
sw $ra, 4($sp)
sw $t0, 0($sp)

jal Naive	#call naive

lw $t0, 0($sp)
lw $ra, 4($sp)
lw $fp, 8($sp)
addi $sp, $sp 12	#restore space
#===================================================================================================================================
addi $sp, $sp -8	#saving data
sw $fp, 4($sp)
sw $ra, 0($sp)

jal Interesting		#call interesting

lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp 8		#restore space
#===================================================================================================================================
j Exit
#===================================================================================================================================
Naive:
addi $t1, $t1, 1	#store i=1 at $t1
add $s0, $s0, $zero	#store sum=0 at $t2

Loop1:
bgt $t1, $t0, Exit1
mul $t4, $t1, $t1
add $s0, $s0, $t4
addi $t1, $t1, 1
j Loop1

Exit1:
jr $ra
#===================================================================================================================================
Interesting:
addi $t1, $t0, 1	#$t1 = n+1
add $t2, $t1, $t0	#$t2 = 2n+1
mul $t3, $t0, $t1	#t3 = n(n+1)
mul $t3, $t3, $t2	#t3 = n(n+1)(2n+1)
addi $t5, $t5, 6	#t4 = 6
divu $s1, $t3, $t5	#s1 = n(n+1)(2n+1)/6
jr $ra
#===================================================================================================================================
Else:
li $v0, 4	#print the error message
la $a0 L3
syscall
li $v0, 10	#exit
syscall
#===================================================================================================================================
Exit:
li $v0, 4	#print the string
la $a0, L2
syscall
move $a0, $s0	#print sum
li $v0, 1 
syscall 

li $v0, 4	#print newline
la $a0, newline
syscall

li $v0, 4	#print the string
la $a0, L4
syscall
move $a0, $s1	#print sum
li $v0, 1 
syscall 

li $v0, 10	#exit
syscall
#===================================================================================================================================
