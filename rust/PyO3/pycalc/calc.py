# to run:
#python calc.py

import fire
from libpycalc_cli import{
	sum_as_string,
	diff_as_string,
	product_as_string,
	quotient_as_string,
}

"""
pycalc_sum = pycalc.sum_as_string(5,20)
pycalc_diff = pycalc.diff_as_string(5,20)
pycalc_prod = pycalc.product_as_string(5,20)
pycalc_quot_0 = pycalc.quotient_as_string(5,20)
pycalc_quot_1 = pycalc.quotient_as_string(20,5)
# Error?
pycalc_quot_2 = pycalc.quotient_as_string(20,0)

print("sum as string (5,20): " + pycalc_sum)
print("diff as string (5,20): " + pycalc_diff)
print("product as string (5,20): " + pycalc_prod)
print("quotient as string (5,20): " + pycalc_quot_0)
print("quotient as string (20,5): " + pycalc_quot_1)
print("quotient as string (20,0): " + pycalc_quot_2)
"""

class Calculator(object):
	def pycalc_add(self, num1, num2):
		# Add two numbers
		return sum_as_string(num1, num2)
	
	def subtract(self, num1, num2):
		# Subtract two numbers
		return diff_as_string(num1, num2)
	
	def multiply(self, num1, num2):
		# Multiply two numbers
		return product_as_string(num1, num2)
	
	def divide(self, num1, num2):
		# Divide two numbers
		return quotient_as_string(num1, num2)

if __name__ == "__main__":
	# Python Fire: a library from Google that automatically generates command line 
	# interfaces (CLIs) from any Python object, making it easy to create and use command line tools.
	# pip install fire
	#https://python-fire.readthedocs.io/en/latest/
	#https://google.github.io/python-fire/guide/
	fire.Fire(Calculator)
	#pass
	
"""
USAGE:
./calc.py [operation] [param1] [param2]
[Example]
./calc.py add 2 2
"""