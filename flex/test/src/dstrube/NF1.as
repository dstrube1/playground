package dstrube
{
	import flash.globalization.LocaleID;
	import flash.globalization.NumberParseResult;
	import flash.system.Capabilities;
	
	import mx.controls.Alert;
	
	import spark.formatters.NumberFormatter;
	import flash.globalization.NumberFormatter;
	
	public class NF1
	{
		
		public static function get(value:String):String{
			var nf1:spark.formatters.NumberFormatter = new spark.formatters.NumberFormatter();
			
			//nf1.decimalSeparator = ",";
			nf1.fractionalDigits = 2;
			nf1.trailingZeros = true;
			//nf1.groupingSeparator = " ";
			//Alert.show("nf1.actualLocaleIDName: " + nf1.actualLocaleIDName);
			//Alert.show("flash.system.Capabilities.language: "+ flash.system.Capabilities.language);
			//var rm:ResourceManager = new ResourceManager();
			//var LID:LocaleID = new LocaleID("");
			//Alert.show("nf1.decimalSeparator = '" + nf1.decimalSeparator+"'; nf1.groupingSeparator = '"+nf1.groupingSeparator+"'");
			var nf2:flash.globalization.NumberFormatter = new flash.globalization.NumberFormatter("");
			nf1.decimalSeparator = nf2.decimalSeparator;
			nf1.groupingSeparator = nf2.groupingSeparator;
			
			var result:NumberParseResult = nf1.parse(value);

			return nf1.format(result.value);
		}
	}
}