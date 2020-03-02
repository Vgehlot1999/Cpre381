.data
list: .word 3, 2, 1, 4, 7, 1, -1
size: .word 7
#MARsWork/Examples/Proj-B_test2.s
.text
main:	
	la $s0, size
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	lw $s0, 0($s0)
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	addi $s1, $s0, -1 #limit
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	addi $s2, $0, 1  #counter
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	la $v1, list     #base address
	
	add $t0, $0, $v1 #initilizes address counter to base address
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	

loop:
	lw $t1, 0($t0)
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	lw $t2, 4($t0)
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	slt $t3, $t2, $t1
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	beq $t3, $0, skipswap
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sw $t1, 4($t0)
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sw $t2, 0($t0)
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
skipswap:
	addi $s2, $s2, 1  #increment coutner by 1
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	addi $t0, $t0, 4  #incrase memory refrence
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	bne $s2, $s0, loop
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	addi $s2, $0, 1   #reset counter to 1
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	add $t0, $0, $v1 #reset address to base
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	addi $s1, $s1, -1
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	bne $s1, $0 loop
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	li   $v0, 10          # system call for exit
      	syscall               # Exit!
      	j end
      	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
	sll $0 $0 0
      	

end:
	
	
