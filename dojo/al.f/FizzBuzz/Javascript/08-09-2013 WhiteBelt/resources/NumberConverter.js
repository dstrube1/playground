if (typeof(Namespace) == "undefined") Namespace = {};
if (typeof(Namespace.alf) == "undefined") Namespace.alf = {};
if (typeof(Namespace.alf.FizzBuzz) == "undefined") Namespace.alf.FizzBuzz = {};

Namespace.alf.FizzBuzz.NumberConverter = function()
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