/*Write a program that prints the numbers from 1 to 100. But for multiples of three print "Fizz"
instead of the number and for the multiples of five print "Buzz". For numbers which are multiples
of both three and five print "FizzBuzz?". */

package
{
	import flash.display.Sprite;
	
	public class FizzBuzzActionScript extends Sprite
	{
		public function FizzBuzzActionScript()
		{
			// Code for Stage 1 Start
			trace("Stage 1 Results: ");
			
			var i:int;
			var result:String = "";
			for (i = 1;i < 101;i++)
			{
				if ((i % 3 == 0) && (i % 5 == 0))
					trace ("FizzBuzz");
				else if (i % 3 == 0)
					trace("Fizz");
				else if (i % 5 == 0)
					trace ("Buzz");
					
				else
					trace (i);
			}
			trace("End of Stage 1 Results");
			// Code for Stage 1 End
			
			/* Stage 2 - new requirements			
			1 A number is fizz if it is divisible by 3 or if it has a 3 in it			
			2 A number is buzz if it is divisible by 5 or if it has a 5 in it			
			3 Both 1 & 2 then fizzbuzz */
			
			// Code for Stage 2 Start
			
			trace("Stage 2 Results: ");
			
			var result2:String = "";
			var tempString:String = "";
			for (i = 1;i < 101;i++)
			{
				tempString = i.toString();
				
				if ( ((i % 3 == 0) || (tempString.indexOf("3") >= 0))
					&& ((i % 5 == 0) || (tempString.indexOf("5") >= 0)) )
					trace ("FizzBuzz");
				else if ((i % 3 == 0) || (tempString.indexOf("3") >= 0))
					trace("Fizz");
				else if ((i % 3 == 0) || (tempString.indexOf("5") >= 0))
					trace ("Buzz");
					
				else
					trace (i);
			}
			trace("End of Stage 2 Results");
			
			// Code for Stage 2 End
		}
	}
}