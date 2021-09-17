Feature: FizzBuzz Contains

Scenario: fizz prints correctly for contains a 3
	Given I have 100 integers
	When I fizzbuzz
	And get all numbers containing a 3
	But not divisible by 5
	And not contains a 5
	Then each should be fizz
	
Scenario: fizz prints correctly for contains a 5
	Given I have 100 integers
	When I fizzbuzz
	And get all numbers containing a 5
	But not divisible by 3
	And not contains a 3
	Then each should be buzz

Scenario: fizzbuzz prints correctly for contains a 3 and 5
	Given I have 100 integers
	When I fizzbuzz
	And get all numbers containing a 3
	And get all numbers containing a 5
	But not divisible by 3
	And not contains a 3
	Then each should be buzz

	
Scenario: fizzbuzz prints correctly for contains a 3 and divisible by 5
	Given I have 100 integers
	When I fizzbuzz
	And get all numbers containing a 3
	And get all numbers divisible by 5
	Then each should be fizzbuzz