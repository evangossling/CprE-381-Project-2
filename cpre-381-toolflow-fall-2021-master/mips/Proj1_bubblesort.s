.data
arr: .word 5, 3, 2, 4, 7, -2

.text

j main
bubble_sort:
  slti $t0, $a1, 2
  bne $0, $t0, done
  sll $a1, $a1, 2
  add $t7, $a0, $a1
  
loop:
  li $t0, 1
  addi $t1, $a0, 4
  
do_bubble:
  lw $t2, -4($t1)
  lw $t3, 0($t1)
  slt $t4, $t3, $t2 
  beq $0, $t4, no_swap
  sw $t2, 0($t1)
  sw $t3, -4($t1)
  li $t0, 0
  
no_swap:
  addi $t1, $t1, 4
  bne $t7, $t1, do_bubble
  beq $0, $t0, loop
  
done:
  jr $ra

main:
  li $a0, 0x10010000
  li $a1, 0x6
  jal bubble_sort
  halt
