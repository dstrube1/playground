package model
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ApplicationModel
	{
		public var aEmailRecipients:ArrayCollection;
		public var aSelectedEmailRecipients:ArrayCollection;
		public var statusMsg:String = "";
		
		public const dbFileName:String = "sqlLiteDemo.db";
		
		function ApplicationModel() {
			aEmailRecipients = new ArrayCollection();			
			aSelectedEmailRecipients = new ArrayCollection();
		}
	}
}