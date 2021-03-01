# 2019CS10399 Sayam Sethi
# 2019CS50440 Mallika Prabhakar

# ----------------------ASSIGNMENT 1---------------------------

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
	blt		$a0, 49, operate	# not a digit, perform operation
	blt		$a0, 59, push		# a digit, push to stack
	j		fileError			# invalid character
	li		$v0, 1
	syscall

# identify operator and perform operation
operate:
	beq		$a0, 42, product	# operator is *
	beq		$a0, 43, sum		# operator is +
	beq		$a0, 45, diff		# operator is -
	j		fileError

product:
	j		loop

sum:
	j		loop

diff:
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
	# @TODO: validate result and print it
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

push:
	j		loop

# ####
# data
	.data
buffer:
	.space	1
stack:
	.space	400000				# 4e5 space allcated for the stack
MAX:
	.word	400000				# storing the MAX permitted size
input:
	.asciiz	"in"
fileErrorMsg:
	.asciiz "File not found or error while reading file.\nTerminating..."