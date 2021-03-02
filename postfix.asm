# 2019CS10399 Sayam Sethi
# 2019CS50440 Mallika Prabhakar

# ----------------------ASSIGNMENT 2---------------------------

	.text
	.globl	main

# setting and loading initial values along with handling base case
main:
	jal		readFile			# reads file
	move	$s0, $v0			# file descriptor is stored in s0 register
	lw		$s1, MAX			# load max size
	li		$s2, 0				# current size of stack
# loop the reading of file until EOF
loop:
	jal		readChar			# reads the next char
	beq		$v0, 0, printRes	# EOF reached, print the result
	lw		$a0, buffer			# load buffer to register
	blt		$a0, 48, operate	# not a digit, perform operation
	addi	$a0, $a0, -48		# subtract 48 to convert to int
	bgt		$a0, 9, fileError	# invalid character
	jal		push				# a digit, push to stack
	j		loop

# identify operator and perform operation
operate:
	beq		$a0, 42, product	# operator is *
	beq		$a0, 43, sum		# operator is +
	beq		$a0, 45, diff		# operator is -
	j		fileError

product:
	jal		pop
	move	$s3, $v0			# store the value in s3
	jal		pop
	mul		$a0, $s3, $v0		# multiply the top two elements of stack and store in a0
	jal		push
	j		loop

sum:
	jal		pop
	move	$s3, $v0			# store the value in s3
	jal		pop
	add		$a0, $s3, $v0		# add the top two elements of stack and store in a0
	jal		push
	j		loop

diff:
	jal		pop
	move	$s3, $v0			# store the value in s3
	jal		pop
	sub		$a0, $v0, $s3		# subtract the top two elements of stack and store in a0
	jal		push
	j		loop

# reads the file
readFile:
	li		$v0, 13				# syscall for file_open
	la		$a0, input			# load input file name (hardcoded)
	li		$a1, 0				# set read only flag
	li		$a2, 0				# file mode: UNIX style (irrelevant since only single line)
	syscall
	blt		$v0, 0, fileError	# file could not be read
	jr		$ra

# prints error message on file not being read and terminates
fileError:
	la		$a0, fileErrorMsg	# load file error message
	jal		print
	j		exit

# reads the next char
readChar:
	li		$v0, 14				# syscall for file_read
	move	$a0, $s0			# load the file descriptor always (for safety)
	la		$a1, buffer			# the buffer location
	li		$a2, 1				# 1 byte = 1 char to be read
	syscall
	beq		$v0, -1, fileError	# error in reading file
	# two bytes are loaded instead? hence reset the last byte
	la		$a0, buffer
    add		$a0, $a0, $v0  		# address of byte after file data
    sb		$zero, 0($a0)
	jr		$ra


# prints the result after checking if stack size is 1
printRes:
	bne		$s2, 4, fileError	# stack contains more than/less than 1 element
	lw		$a0, stack($zero)		# load the only element of stack
	li		$v0, 1
	syscall
	j		exit

# exit the running of program
exit:
	li		$v0, 10				# syscall for terminate
	syscall

# function to syscall print_string
print:
	li		$v0, 4				# syscall for print_string
	syscall
	jr		$ra

# ####################
# stack push operation
push:
	beq		$s2, $s1, overflow	# max size reached
	sw		$a0, stack($s2)		# push the element
	addi	$s2, $s2, 4			# increment the current size
	jr		$ra

# stack pop operation
pop:
	beq		$s2, 0, fileError	# pop error, hence expression is invalid
	addi	$s2, $s2, -4		# reduce the current size
	lw		$v0, stack($s2)		# load the top element to v0
	jr		$ra

# overflow error
overflow:
	la		$a0, overflowMsg
	jal		print
	j		exit



# ####################
# data
	.data
buffer:
	.space	1
	.align	2
stack:
	.space	400000				# 4e5 space allcated for the stack
	.align	2
MAX:
	.word	400000				# storing the MAX permitted size
input:
	.asciiz	"in"
fileErrorMsg:
	.asciiz "File not found or error while reading file or invalid postfix.\nTerminating..."
overflowMsg:
	.asciiz "Stack size exceeded the maximum permissible limit.\nTerminating evaluation..."