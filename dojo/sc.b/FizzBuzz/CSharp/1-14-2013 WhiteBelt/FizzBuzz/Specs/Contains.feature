Feature: Contains
	In order to enhance FizzBuzz
	As a number analyzer
	I want to be check for numbers that contain 3 or 5

Scenario: Contains a 3
	Given the number 13
	When I convert to FizzBuzz with enhanced rules
	Then the result should be 'Fizz'
	
Scenario: Conatins a 5
	Given the number 52
	When I convert to FizzBuzz with enhanced rules
	Then the result should be 'Buzz'

Scenario: Conatins a 5 and a 3
	Given the number 53
	When I convert to FizzBuzz with enhanced rules
	Then the result should be 'FizzBuzz'
	
Scenario: The sequence of numbers up to 15
	Given the numbers 1 to 15
	When I convert to FizzBuzz with enhanced rules
	Then the result should be '1,2,Fizz,4,Buzz,Fizz,7,8,Fizz,Buzz,11,Fizz,Fizz,14,FizzBuzz'
	
Scenario: The sequence of numbers from 50 to 60
	Given the numbers 50 to 60
	When I convert to FizzBuzz with enhanced rules
	Then the result should be 'Buzz,FizzBuzz,Buzz,FizzBuzz,FizzBuzz,Buzz,Buzz,FizzBuzz,Buzz,Buzz,FizzBuzz'
