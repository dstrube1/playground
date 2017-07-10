package
{
	import mx.controls.Alert;
	
	public class XMLMap
	{
		private var myXML:XML;
		
		public function XMLMap(xml:String) {
			myXML = null;
			if (xml.indexOf("<map>") == -1){
				//Alert.show("Missing <map> tag."); //error
				myXML = new XML();
			}
			else if (xml.indexOf("<map>") != 0) {
				//Alert.show("Misplaced <map> tag."); //warning
			}
			if(xml.indexOf("<element") == -1){
				//Alert.show("Missing <element> tag."); //error
				myXML = new XML();
			}
			else if (xml.indexOf("<element") != 5) {
				//Alert.show("Misplaced <element> tag."); //warning
			}
			if (xml.indexOf("key") == -1){
				//Alert.show("Missing key attriubte of <element> tag."); //error
				myXML = new XML();
			}
			else if (xml.indexOf("key") != 9+( xml.indexOf("<element") )){
				//Alert.show("Misplaced key attriubte of <element> tag."); //warning
			}
			if (xml.indexOf("value") == -1){
				//Alert.show("Missing value attriubte of <element> tag."); //error
				myXML = new XML();
			}
			else if (xml.indexOf("value") < xml.indexOf("key")){
				//Alert.show("Misplaced value attriubte of <element> tag."); //warning
			}
			if (xml.indexOf("/>") == -1 ){
				//Alert.show("Missing </element> tag."); //error
				myXML = new XML();
			}
			if (xml.indexOf("</map>") == -1){
				//Alert.show("Missing </map> tag."); //error
				myXML = new XML();
			}
			
			if (myXML == null)
				myXML = new XML(xml);
		}
//		public function XMLMap(xml:XML){
//			myXML = xml;
//		}
		public function print():String{
			return myXML.toString();
		}
		
		public function getKeys():Array{
			var array:Array = new Array();
			
			for each (var korv:XML in myXML.element){
            		array.push(korv.@key);
           	}
           	return array;
		}
		public function getValues():Array{
			var array:Array = new Array();
			
			for each (var korv:XML in myXML.element){
            		array.push(korv.@value);
           	}
           	return array;
		}
	}
}