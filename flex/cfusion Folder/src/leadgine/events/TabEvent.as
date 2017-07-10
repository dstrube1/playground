package leadgine.events
{
	import flash.events.Event;

//from http://www.russback.com/adobe-flex/intercepting-tab-events-in-a-flex-tabnavigator.html
	public class TabEvent extends Event
	{
		 /**
         * Constants for each type of TabEvent
         */
        public static const TAB_MOUSE_ACTIVITY:String = "tabEventTabMouseActivity"; 
        public static const TAB_ITEMCLICK_ACTIVITY:String = "tabEventTabItemClickActivity"; 
        
        /**
         * event property to hold the event that occurred on the Tab
         */
        public var event:Event;
        
        /**
         * Calls the constructor class of the super class and assigns the received event to the event property
         */
        public function TabEvent(type:String, event:Event, bubbles:Boolean=true, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            this.event = event;
        }
	}
}