.data
	string1:.asciiz "Enter first positive integer : "
	string2:.asciiz "Enter second positive integer : "
.text
main:
	li $v0, 4
	la $a0, string1
	syscall
        li $v0, 5          
        syscall         
        add $s0, $v0, $zero 
        li $v0, 4
	la $a0, string2
	syscall
        li $v0, 5          
        syscall         
        add $s1, $v0, $zero
        slt $t0, $s0, $s1
        addi $sp, $sp, -4         #if n1 < n2  swap
        bne $t0, 0, swap          #
        jal gcd
        j exit
        
swap:
	add $t0, $s0, $zero       #move n1 to temp
	add $s0, $s1, $zero
	add $s1, $t0, $zero
	jal gcd
	j exit
	
gcd:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	bne $s1, 0, else           #if n2 == 0 return n1 
	add $v0, $s0, $zero
	jr $ra
else:                              #return gcd( n2, n1 % n2 )
	add $t0, $s0, $zero
	add $s0, $s1, $zero
	add $s1, $t0, $zero
	rem $s1, $s1, $s0
	jal gcd
	lw $s1, 0($sp) 
 	lw $s0, 4($sp)
 	lw $ra, 8($sp) 
 	addi $sp, $sp, 12 
 	jr $ra
 exit:
 	move $a0, $v0
        li $v0, 1
        syscall  
        li $v0, 10
        syscall 
        
              