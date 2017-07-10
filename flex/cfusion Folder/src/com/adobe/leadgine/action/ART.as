package com.adobe.leadgine.action
{
	[Managed]
	[RemoteClass(alias="com.adobe.leadgine.cfc.ART")]

	public class ART
	{

		public var ARTID:Number = 0;
		public var ARTISTID:Number = 0;
		public var ARTNAME:String = "";
		public var DESCRIPTION:String = "";
		public var PRICE:Number = 0;
		public var LARGEIMAGE:String = "";
		public var MEDIAID:Number = 0;
		public var ISSOLD:Number = 0;


		public function ART()
		{
		}

	}
}