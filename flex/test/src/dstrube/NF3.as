package dstrube
{
	//import mx.formatters.NumberBaseRoundType;
	import mx.formatters.NumberFormatter;
	
	public class NF3
	{
		
		public static function get(value:String):String{
			var nf3:NumberFormatter = new NumberFormatter();
			nf3.precision = 2; //same outcome as without
			//nf3.rounding = NumberBaseRoundType.NEAREST; //no effect in this case
			return nf3.format(value);
		}
	}
}