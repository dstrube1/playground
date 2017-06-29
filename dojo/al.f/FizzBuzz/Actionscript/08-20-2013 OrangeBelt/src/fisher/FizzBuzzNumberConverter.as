package fisher
{
	import fisher.INumberConverter;
	
	public class FizzBuzzNumberConverter implements INumberConverter
	{
		public function ConvertToString(value:int):String
		{
			var output:String = "";
			
			if (isMultipleOf(3, value) || intContains(3, value))
			{
				output += "Fizz";
			}
			
			if (isMultipleOf(5, value) || intContains(5, value))
			{
				output += "Buzz";
			}
			
			if (output == "") output = value.toString();
			
			return output;
		}
		
		public function isMultipleOf(multiple:int, value:int):Boolean
		{
			return value % multiple == 0;
		}
		
		public function intContains(needle:int, value:int):Boolean
		{
			return value.toString().indexOf(needle.toString()) != -1;
		}
	}
}