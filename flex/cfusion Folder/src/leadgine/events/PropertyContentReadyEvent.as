package leadgine.events
{
	import flash.events.Event;

	public class PropertyContentReadyEvent extends Event
	{
		public static const PROPERTY_CONTENT_READY:String = "propertyContentReady";
		
		public function PropertyContentReadyEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			//hopefully setting bubbles=true will make not just declarers of this even catch it
			//because adding event listener on myDTOP (instance of FullServiceReferral) is not possible
			super(type, bubbles, cancelable);
		}
		
	}
}