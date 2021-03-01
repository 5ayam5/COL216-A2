
    .text
    .globl main

main:
    addi $s0, $zero, 1
    addi $s1, $zero, 3
    addi $s2, $zero, 4

    # index creation increase index by one everytime because char
    addi $t0, $zero, 0
    sw $s0, arr($t0)
<<<<<<< HEAD
        addi $t0, $t0, 4
    sw $s1, arr($t0)
        addi $t0, $t0, 4
=======
    addi $t0, $t0, 4
    sw $s1, arr($t0)
    addi $t0, $t0, 4
>>>>>>> d286eaec0077fc5693795d9626120605b3eb335d
    sw $s2, arr($t0)


    addi $t0, $zero, 0

<<<<<<< HEAD
    ############################################
    #while loop
    ############################################
    while:
        beq $t0, arr.size, exit

        lw $t6, arr($t0)

#print char and newline
        li $v0, 1
        move $a0, $t6
=======
    # ###########################################
    # while loop
    # ###########################################
    while:
        beq $t0, 12, exit

        lw $t5, arr($t0)

# print char and newline
        li $v0, 1
        move $a0, $t5
>>>>>>> d286eaec0077fc5693795d9626120605b3eb335d
        syscall

        li $v0, 4
        la $a0, newline
        syscall


<<<<<<< HEAD
        addi $t0, $t0,1
        j while
        
    exit:
        li $v0,10
        syscall
=======
        addi $t0, $t0,4
        j while
        
exit:
    li $v0,10
    syscall
>>>>>>> d286eaec0077fc5693795d9626120605b3eb335d




.data
<<<<<<< HEAD
    arr: .space 4*n #size of arr needed (4 bytes per int and 1 byte per char)
    n: .word 3
=======
    arr: .space 3 # size of arr needed (4 bytes per int and 1 byte per char)
>>>>>>> d286eaec0077fc5693795d9626120605b3eb335d
    newline: .asciiz "\n"