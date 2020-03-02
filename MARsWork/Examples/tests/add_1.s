.data
.text
.globl main

main:
	#Start test
	add $t0, $zero, $zero  # test 0 + 0
	addi $1, $0, 0
    addiu $3, $2, 0x0001
	addi $1, $0, 0xFFFFFFFF     # Set $1 to max value  
    addi $2, $0, 0xFFFFFFFF     # Set $2 to max value

    and $3, $2, $1
 
	# End Test

	# Exit program
	li $v0, 10
	syscall
