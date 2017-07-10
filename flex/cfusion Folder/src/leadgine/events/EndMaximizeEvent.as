package leadgine.events
{
	import flash.events.Event;

	public class EndMaximizeEvent extends Event
	{
		public static const END_MAXIMIZE:String = "endMaximize";
		
		public function EndMaximizeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}