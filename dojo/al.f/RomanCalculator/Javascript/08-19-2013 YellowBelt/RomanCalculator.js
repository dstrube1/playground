if (typeof(RomanCalculatorKata) == "undefined") RomanCalculatorKata = {};


RomanCalculatorKata.RomanCalculator = function()
{
	var self = this;

	var numerals = ["I", "V", "X", "L", "C", "D", "M"];
	var subAddMap = 
	[
		{
			additive: "IIII",
			subtractive: "IV"
		},
		{
			additive: "VIIII",
			subtractive: "IX"
		},
		{
			additive: "XXXX",
			subtractive: "XL"
		},
		{
			additive: "LXXXX",
			subtractive: "XC"
		},
		{
			additive: "CCCC",
			subtractive: "CD"
		},
		{
			additive: "DCCCC",
			subtractive: "CM"
		}
	];

	self.Add = function(left, right)
	{
		return self.ToSubtractiveNotation(self.CondenseToM(self.ExpandToI(self.ToAdditiveNotation(left)) + self.ExpandToI(self.ToAdditiveNotation(right))));
	}

	self.ToSubtractiveNotation = function(input)
	{
		var str = input;

		for (var i = subAddMap.length - 1; i >= 0; i--)
		{
			str = str.replace(new RegExp(subAddMap[i].additive, "g"), subAddMap[i].subtractive);
		}

		return str;
	}

	self.ToAdditiveNotation = function(input)
	{
		var str = input;

		for (var i = 0; i < subAddMap.length; i++)
		{
			str = str.replace(new RegExp(subAddMap[i].subtractive, "g"), subAddMap[i].additive);
		}

		return str;
	}

	self.ExpandToI = function(input)
	{
		var str = input;

		for (var i = numerals.length - 1; i > 0; i--)
		{
			//if index is even, replace current numeral with 2 of the previous numeral
			//if index is odd, replace current numeral with 5 of the previous numeral
			str = str.replace(new RegExp(numerals[i], "g"), Array((i % 2 == 0 ? 2 : 5) + 1).join(numerals[i - 1]));
		}

		return str;
	}

	self.CondenseToM = function(input)
	{
		var str = input;

		for (var i = 0; i < numerals.length - 1; i++)
		{
			//if index is even, replace 5 of current numeral with the next numeral
			//if index is odd, replace 2 of current numeral with the next numeral
			str = str.replace(new RegExp(Array((i % 2 == 0 ? 5 : 2) + 1).join(numerals[i]), "g"), numerals[i + 1]);
		}

		return str;
	}
}