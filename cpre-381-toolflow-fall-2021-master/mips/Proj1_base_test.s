main:
	addi $t0, $zero, 0x10
	addiu $t1, $t0, 0x3
	addu $t0, $t1, $t2
	add $t3, $t0, $t1
	and $t4, $t3, 0x2
	andi $t5, $t3, 0x5
	lui $t1, 0x1010
	addi $t0, $0, 4
	sltiu $t8, $t3, 5
	sw $t0, 4($t1)
	lw $t6, 4($t1)
	nor $t7, $t0, $t1
	xor $t8, $t3, $t1
	xori $t9, $t1, 0x1010
	j here
here:	or $t1, $t2, $t3
	ori $t2, $t3, 0x1001
	slt $t0, $t1, $t2
	slti $t1, $t2, 0x3
	sll $t0, $t0, 0x2
	repl.qb $9, 31
	srl $t1, $t0, 0x1
	sra $t2, $t9, 0x1
	sub $t8, $t1, $t0
	sltu $t6, $t1, $t3
	subu $t9, $t0, $t1
	and $t0, $t0, 0x0
	beq $t0, $zero, branchtest
	
branchtest:
	addi $t0, $t0, 0x1
	jal jumptest
	bne $t0, $t1, branchtest
	beq $t0, 0x2, post
	
jumptest:
	addi $t9, $t0, 0x5
	jr $ra
	
post:
	addi $t8, $zero, 0x0
	halt
