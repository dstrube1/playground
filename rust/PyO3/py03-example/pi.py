#!/usr/bin/env python

import py03_example

sum_string = py03_example.sum_as_string(5,20)
iterations = 100_000
pi_approximation = py03_example.calculate_pi(iterations)
print("sum as string (5,20): " + sum_string)
print("pi approximation (with " + str(iterations) + " iterations): " + str(pi_approximation))

# Hmm, ./pi.py doesn't work as well IRL as it does in the tutorial video :/

# But this works:
# python pi.py