import time, math

# Really verbose implementation of the (recursive) binary GCD algorithm
def binary_gcd(a, b):
	def even(n):
		return n%2 == 0
		
	if a == 0 and b == 0:
		return 0
	if a == 0:
		return b
	elif b == 0:
		return a
	elif even(a) and even(b):
		return 2 * binary_gcd(int(a/2), int(b/2))
	elif even(a) and not even(b):
		return binary_gcd(int(a/2), b)
	elif not even(a) and even(b):
		return binary_gcd(a, int(b/2))
	elif not (even(a) or even(b)):
		if a >= b:
			return binary_gcd(int((a - b)/2), b)
		else:
			return binary_gcd(int((b - a)/2), a)

# Really naive GCD implementation using a function that finds all divisors
def naive_gcd(a, b):
	def divisors(n):
		d = []
		for i in range(1, n+1):
			if (n%i == 0):
				d.append(i)
		return d
	
	da, db = divisors(a), divisors(b) # find the divisors of both a and b
	common = list(set(da).intersection(db)) # find the set intersection as a list
	return common[-1] # return the last element of this list

# test the algorithms
funcs = {
	"binary_gcd": binary_gcd,
	"naive_gcd": naive_gcd
}
tests = [[54, 24, 6], [42, 56, 14], [2235, 642, 3], [5325, 92325, 75]]

for name, func in funcs.items():
	start = time.clock()
	for test in tests:
		a, b, c = test[0], test[1], test[2]
		r = func(a, b)
		print(name + "(" + str(a) + "," + str(b) + ") = " + str(r))
		print(" => correct" if r == c else " => incorrect (" + str(r) + " != " + str(c) + ")")
	print("time: " + str(time.clock() - start) + " s")