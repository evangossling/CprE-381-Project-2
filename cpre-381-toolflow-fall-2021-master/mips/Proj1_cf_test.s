main:
              addi $s0, $s0, 1
              addi $s1, $s1, 5
              addi $s2, $s2, 11
              addi $s3, $s3, 3
              addi $s4, $s4, 2
              addi $s5, $s5, 4
              addi $s6, $s6, 8
              jal funct1
              j exit

funct1:
              bne $s0, $s1, funct4
              jr $ra

funct2:
              addi $s3, $s2, 4
              addu $s1, $s1, $s1
              bne $s1, $s3, funct3
              jr $ra
 
funct3:
              addi $s1, $s1, 5
              beq $s1, $s3, funct5
	      jr $ra
 
funct4:
              add $s0, $s0, $s1
              addi $s0, $s0, 2           
              beq $s0, $s6, funct2
              jr $ra
             
funct5:
              addi $s6, $s1, 20
              jr $ra
 
exit:
              halt

