package vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class UserBean
	{
		public var ID:int = 0;
		public var userid:String = "";
		public var firstName:String = "";
		public var lastName:String = "";
		public var email:String = "";
		public var company:String = "";
		public var age:int = 0;
		public var address:String = "";
		
		public var aPhoneNr:ArrayCollection = new ArrayCollection();
		
		function UserBean() {}
		
	}
}