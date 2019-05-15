Feature: FizzBuzz Divisible by

Scenario: 100 integers print 100 lines
	Given I have 100 integers
	When I fizzbuzz
	Then the result should have 100 lines

Scenario: fizz prints correctly for divisible by 3
	Given I have 100 integers
	When I fizzbuzz
	And get all numbers divisible by 3
	But not divisible by 5
	And not contains a 5
	Then each should be fizz
	

Scenario: buzz prints correctly for divisible by 5
	Given I have 100 integers
	When I fizzbuzz
	And get all numbers divisible by 5
	But not divisible by 3
	And not contains a 3
	Then each should be buzz
	
Scenario: fizzbuzz prints correctly for divisible by 3 and 5
	Given I have 100 integers
	When I fizzbuzz
	And get all numbers divisible by 5
	And get all numbers divisible by 3
	Then each should be fizzbuzz

Scenario: the number prints correctly for non divisible by 3 and 5
	Given I have 100 integers
	When I fizzbuzz
	And not divisible by 3
	And not divisible by 5
	But not contains a 3
	And not contains a 5
	Then each should be the index