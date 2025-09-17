#!/usr/bin/env python

import ruff_linter

sum_string = ruff_linter.sum_as_string(5,20)
print("sum as string (5,20): " + sum_string)

# ./ruffTest.py works IF first do this:
# chmod 755 ruffTest.py

# This also works:
# python ruffTest.py