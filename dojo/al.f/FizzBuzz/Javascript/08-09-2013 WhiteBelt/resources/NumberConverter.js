if (typeof(Namespace) == "undefined") Namespace = {};
if (typeof(Namespace.AlexanderFisher) == "undefined") Namespace.AlexanderFisher = {};
if (typeof(Namespace.AlexanderFisher.FizzBuzz) == "undefined") Namespace.AlexanderFisher.FizzBuzz = {};

Namespace.AlexanderFisher.FizzBuzz.NumberConverter = function()
{
	var self = this;

	self.IntToString = function(number)
	{
		if ((MultipleOf(number, 3) || Contains(number, "3")) && (MultipleOf(number, 5) || Contains(number, 5)))
		{
			return "FizzBuzz";
		}
		else if (MultipleOf(number, 3) || Contains(number, "3"))
		{
			return "Fizz";
		}
		else if (MultipleOf(number, 5) || Contains(number, "5"))
		{
			return "Buzz";
		}
		else
		{
			return number;
		}
	}

	function MultipleOf(number, of)
	{
		return number % of == 0;
	}

	function Contains(number, needle)
	{
		return number.toString().indexOf(needle) != -1;
	}
}