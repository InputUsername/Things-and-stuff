import math
import sys

def method_1():
	"""
	22/7
	"""
	return 22/7

def method_2():
	"""
	Liu Hui's method
	"""
	result = math.sqrt(math.sqrt(2) + 1)
	for i in range(7):
		result = math.sqrt(2 + result)
	return 768 * math.sqrt(2 - result)

def method_3(iterations):
	"""
	Madhava's method
	"""
	result = 0
	for k in range(0, iterations):
		result += (-3 ** -k) / (2*k + 1)
	return result * math.sqrt(12)

def method_4():
	"""
	Euler's method
	"""
	return (20 * math.arctan(1 / 7)) + (8 * math.arctan(3 / 79))

def method_5(iterations):
	"""
	Newton's method
	"""
	result = 0
	for k in range(0, iterations):
		n = ((2 ** k) * (math.factorial(k) ** 2))
		d = math.factorial(2*k + 1)
		result += n / d
	return result * 2

def method_6(iterations):
	"""
	Ramanujan's method
	"""
	result = 0
	for k in range(0, iterations):
		n = math.factorial(4 * k) * (1103 + 26390*k)
		d = (math.factorial(k) ** 4) * (396 ** (4*k))
		result += n / d
	result *= (2 * math.sqrt(2)) / 9801
	return 1 / result

def method_7(iterations):
	"""
	David and Gregory Chudnovsky's method
	"""
	result = 0
	for k in range(0, iterations):
		n = (-1 ** k) * math.factorial(6 * k) * (13591409 + 545140134*k)
		d = math.factorial(3*k) * (math.factorial(k) ** 3) * (640320 ** (3*k + 3/2))
		result += n/d

	if (result == 0):
		return 0

	return 1/(result * 12)

def method_8(max_digits):
	# TODO: implement
	# See http://rosettacode.org/wiki/Pi#Lua


pi_methods = [
	method_1,
	method_2,
	method_3,
	method_4,
	method_5,
	method_6,
	method_7,
]
