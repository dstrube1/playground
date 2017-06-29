if (typeof(RomanCalculatorKata) == "undefined") console.log("Error: Unit tests depend on RomanCalculator class.");
else {

	(function(){

		var calculator = new RomanCalculatorKata.RomanCalculator();

		var subAddCases = 
		[
			{
				subtractive: "IV",
				additive: "IIII"
			},
			{
				subtractive: "IX",
				additive: "VIIII"
			},
			{
				subtractive: "XL",
				additive: "XXXX"
			},
			{
				subtractive: "XC",
				additive: "LXXXX"
			},
			{
				subtractive: "CD",
				additive: "CCCC"
			},
			{
				subtractive: "CM",
				additive: "DCCCC"
			},
			{
				subtractive: "CMIX",
				additive: "DCCCCVIIII"
			},
			{
				subtractive: "CMXI",
				additive: "DCCCCXI"
			},
		];

		QUnit.test("To Subtractive Notation", function() {

			for(var i = 0; i < subAddCases.length; i++)
			{
				equal(calculator.ToSubtractiveNotation(subAddCases[i].additive), subAddCases[i].subtractive, subAddCases[i].additive + " -> " + subAddCases[i].subtractive);
			}
		});

		QUnit.test("To Additive Notation", function() {

			for(var i = 0; i < subAddCases.length; i++)
			{
				equal(calculator.ToAdditiveNotation(subAddCases[i].subtractive), subAddCases[i].additive, subAddCases[i].subtractive + " -> " + subAddCases[i].additive);
			}
		});

		QUnit.test("Expand To I", function() {
			var cases = 
			[
				{
					input: "VII",
					output: Array(7 + 1).join("I")
				},
				{
					input: "XIIII",
					output: Array(14 + 1).join("I")
				},
				{
					input: "MDCCCCLIIII",
					output: Array(1954 + 1).join("I")
				},
				{
					input: "MDCCCCLXXXX",
					output: Array(1990 + 1).join("I")
				}
			];

			for(var i = 0; i < cases.length; i++)
			{
				equal(calculator.ExpandToI(cases[i].input), cases[i].output, cases[i].input + " -> " + (cases[i].output.match(/I/g)||[]).length + " I's");
			}
		});

		QUnit.test("Condense To M", function() {
			var cases = 
			[
				{
					input: Array(7 + 1).join("I"),
					output: "VII"
				},
				{
					input: Array(14 + 1).join("I"),
					output: "XIIII"
				},
				{
					input: Array(1954 + 1).join("I"),
					output: "MDCCCCLIIII"
				},
				{
					input: Array(1990 + 1).join("I"),
					output: "MDCCCCLXXXX"
				}
			];

			for(var i = 0; i < cases.length; i++)
			{
				equal(calculator.CondenseToM(cases[i].input), cases[i].output, (cases[i].input.match(/I/g)||[]).length +  " I's -> " + cases[i].output);
			}
		});

		QUnit.test("Add", function() {
			var cases = 
			[
				{
					left: "XX",
					right: "II",
					output: "XXII"
				},
				{
					left: "D",
					right: "D",
					output: "M"
				},
				{
					left: "MCMLIV",
					right: "XCII",
					output: "MMXLVI"
				},
				{
					left: "XLVII",
					right: "XCIV",
					output: "CXLI"
				},
				{
					left: "MMVIII",
					right: "CDIX",
					output: "MMCDXVII"
				},
				{
					left: "XL",
					right: "IV",
					output: "XLIV"
				}
			];

			for(var i = 0; i < cases.length; i++)
			{
				equal(calculator.Add(cases[i].left, cases[i].right), cases[i].output, cases[i].left + " + " + cases[i].right + " = " + cases[i].output);
			}
		});

	})();
}