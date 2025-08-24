#!/usr/bin/env python

import py03_example

sum_string = py03_example.sum_as_string(5,20)
pi_approximation = py03_example.calculate_pi(10000)
print("sum as string: " + sum_string)
print("pi approximation: " + str(pi_approximation))

# Hmm, ./pi.py doesn't work as well IRL as it does in the tutorial video :/

# But this works:
# python pi.py