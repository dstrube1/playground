package leadgine.events
{
	import flash.events.Event;

	public class EndRestoreEvent extends Event
	{
		public static const END_RESTORE:String = "endRestore";
		public function EndRestoreEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}