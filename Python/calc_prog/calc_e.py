from math import factorial

def method_1(iterations):
	result = 2
	for i in range(2, iterations):
		result += 1 / math.factorial(i)
	return result

e_methods = [
	method_1,
]

#TODO: more
