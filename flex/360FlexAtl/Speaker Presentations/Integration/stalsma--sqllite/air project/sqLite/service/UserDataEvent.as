package service
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class UserDataEvent extends Event
	{
		public var aUserBeanCollection:ArrayCollection;
		static public const USERDATAEVENT_NAME:String = "UserDataEvent";
		
		public function UserDataEvent(type:String, aUserBean:ArrayCollection)
		{
			super(USERDATAEVENT_NAME, bubbles, cancelable);
			aUserBeanCollection = aUserBean;
		}
		
	}
}