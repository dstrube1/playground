using System;
using System.Linq;
//using System.Linq.Expressions;

namespace Assignment10
{
	public class Notes
	{
		public Notes ()
		{
		}

		public void doStuff(){
			int[] numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
			var lowNums = 
				from num in numbers
				where num < 5
				select num;
			Console.WriteLine ("low numbers: ");
			foreach (var x in lowNums){
				Console.Write (x+", ");
			}

			string[] foods = { "cherry", "apple", "blueberry" };
			var sortedFoods = 
				from food in foods
				orderby food
				select food;
			Console.WriteLine ("\n\nfoods sorted alphabetically: ");
			foreach (var x in sortedFoods){
				Console.Write (x+", ");
			}

			var sortedByLengthFoods = 
				from food in foods
				orderby food.Length
				select food;
			Console.WriteLine ("\n\nfoods sorted by length: ");
			foreach (var x in sortedByLengthFoods){
				Console.Write (x+", ");
			}

		}

	}
}


