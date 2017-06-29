Feature: DivisibleBy
	In order to count number correctly in FizzBuzz
	As a bad counter
	I want numbers


Scenario: The Number Three is Fizz
	Given the number 3
	When I convert to FizzBuzz
	Then the result should be 'Fizz'
	

Scenario: The Number Five is Buzz
	Given the number 5
	When I convert to FizzBuzz
	Then the result should be 'Buzz'
	
Scenario: The sequence of numbers up to 15
	Given the numbers 1 to 15
	When I convert to FizzBuzz
	Then the result should be '1,2,Fizz,4,Buzz,Fizz,7,8,Fizz,Buzz,11,Fizz,13,14,FizzBuzz'
