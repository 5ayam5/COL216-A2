
    .text
    .globl main

main:
    lw $s3, bytegap
    addi $s0, $zero, 1
    addi $s1, $zero, 3
    addi $s2, $zero, 4

    # index creation increase index by one everytime because char

    addi $t0, $zero, 0
    #########################################################
    #push and pop
    #########################################################


#push
    #arg a1 and a2
    add $a1, $zero, $t0
    addi $a2, $zero, 15
    jal push
    move $t0, $v1
    #t0 is updated and new element is added to the array


#pop
    #last index and bytegap as arg, return the popped int
    add $a1, $zero, $t0
    move $a2, $s4
    jal pop
    move $t0, $v1
















    # ###########################################
    # while loop
    # ###########################################
    while:
        beq $t0, 12, exit

        lw $t5, arr($t0)

# print char and newline
        li $v0, 1
        move $a0, $t5
        syscall
        #print comma  not working will check it out later
        li $v0, 4
        la $a0, comma
        syscall


        addi $t0, $t0,4
        j while
        
exit:
    li $v0,10
    syscall

push:
    sw $a2, arr($a1)
    addi $v1, $a1, 4
    jr $ra

pop:
    lw $v1, arr($a1)
    sub $v1, $a1, $a2
    jr $ra
    




.data
    arr: .space 3 # size of arr needed (4 bytes per int and 1 byte per char)
    comma: .asciiz ", "
    bytegap: .word 4