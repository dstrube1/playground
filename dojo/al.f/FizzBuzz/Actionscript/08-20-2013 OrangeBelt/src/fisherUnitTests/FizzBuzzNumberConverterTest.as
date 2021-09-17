package fisherUnitTests
{
	import fisher.FizzBuzzNumberConverter;
	import org.flexunit.Assert;
	import org.flexunit.runners.Parameterized;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class FizzBuzzNumberConverterTest
	{	
		private var foo:Parameterized;
		protected var converter:FizzBuzzNumberConverter = new FizzBuzzNumberConverter();
		
		public static var isMultipleOfData:Array = [
			[true, 15, 3],
			[true, 15, 5],
			[false, 11, 5],
			[false, 14, 3]
		];
		
		[Test(dataProvider="isMultipleOfData")]
		public function isMultipleOf(output:Boolean, input:int, multiple:int):void
		{
			Assert.assertEquals(converter.isMultipleOf(multiple, input), output);
		}
		
		public static var intContainsData:Array = [
			[true, 313, 3],
			[true, 515, 5],
			[false, 515, 3],
			[false, 313, 5]
		];
		
		[Test(dataProvider="intContainsData")]
		public function intContains(output:Boolean, input:int, needle:int):void
		{
			Assert.assertEquals(converter.intContains(needle, input), output);
		}
		
		public static var ConvertToStringData:Array = [
			["Fizz", 3],
			["Buzz", 5],
			["FizzBuzz", 15],
			["Buzz", 50],
			["Fizz", 13],
			["FizzBuzz", 53]
		];
		
		[Test(dataProvider="ConvertToStringData")]
		public function ConvertToString(output:String, input:int):void
		{
			Assert.assertEquals(converter.ConvertToString(input), output);
		}		
	}
}