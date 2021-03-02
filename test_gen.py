from random import randint as rand
Map = {0:42, 1:43, 2:45}

n = rand(0, rand(0, int(input())))
with open("in", "w+") as f:
	f.write(chr(rand(48, 57)))
	i, operators = 0, 0
	while i < n:
		if i == operators:
			f.write(chr(rand(48, 57)))
			i += 1
			continue
		op = rand(0, 1)
		if op:
			f.write(chr(Map[rand(0, 2)]))
			operators += 1
		else:
			f.write(chr(rand(48, 57)))
			i += 1
	while operators < n:
		f.write(chr(Map[rand(0, 2)]))
		operators += 1

stack = []
with open("in", "r") as f:
	for c in f.readline():
		char = ord(c)
		if char < 48:
			a = stack.pop()
			if char == 42:
				stack[-1] *= a
			elif char == 43:
				stack[-1] += a
			else:
				stack[-1] -= a
		else:
			stack.append(char - 48)
print(stack[0])
