package dstrube
{
//	import flash.globalization.LocaleID;
	import flash.globalization.NumberParseResult;
	
	import flash.globalization.NumberFormatter;
	import mx.controls.Alert;
	
	public class NF2
	{
		
		public static function get(value:String):String{
			var nf2:NumberFormatter = new NumberFormatter("");// LocaleID.DEFAULT = same outcome as without
			nf2.fractionalDigits = 5; //= same outcome as without
			//Alert.show("nf2.decimalSeparator = '" + nf2.decimalSeparator+"'; nf2.groupingSeparator = '"+nf2.groupingSeparator+"'");
			nf2.trailingZeros = true;
			var result:NumberParseResult = nf2.parse(value);
			
			//nf2.parseNumber(value); = NaN

			return nf2.formatNumber(result.value)
		}
	}
}