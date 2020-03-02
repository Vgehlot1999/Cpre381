#
# First part of the Lab 3 test program
#

# data section
.data

# code/instruction section
.text

addi $5 $5 5
addi $6 $5 5
addi $7 $5 5
addi $3 $3 3
addi $8 $5 5
addi $9 $5 5
addi $10 $5 5
addi $5 $10 5
addi $5 $9 5
addi $6 $3 3
sub $8 $5 $6

END:
addi  $2,  $0,  10              # Place "10" in $v0 to signal an "exit" or "halt"
syscall                         # Actually cause the halt
