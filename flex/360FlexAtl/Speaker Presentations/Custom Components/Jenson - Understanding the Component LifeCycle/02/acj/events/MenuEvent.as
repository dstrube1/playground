package acj.events
{
	import flash.events.Event;
	import acj.menuClasses.MenuLabel;

	public class MenuEvent extends Event
	{
		//--------------------------------------------------------------------------
	    //
	    //  Class constants
	    //
	    //--------------------------------------------------------------------------
	    
		/**
	     *  The MenuEvent.CHANGE constant defines the value of the 
	     *  <code>type</code> property of the MenuEvent object for a
	     *  <code>change</code> event, which indicates that selection
	     *  changed as a result of user interaction.
	     *
	     *  @eventType change
	     */
	    public static const CHANGE:String = "change";
	    
	    /**
	    * MenuEvent.ITEM_MOUSE_OVER is an event that is dispatched when an item is rolled over.
	    **/
	    public static const ITEM_MOUSE_OVER:String = "itemOver";
	    
	    /**
	     *  The MenuEvent.ITEM_CLICK constant defines the value of the 
	     *  <code>type</code> property of the MenuEvent object for an
	     *  <code>itemClick</code> event, which indicates that the 
	     *  user clicked the mouse over a visual item in the control.
	     *
	     *  @eventType itemClick
	     */
	    public static const ITEM_CLICK:String = "itemClick"
	    
	    
		//--------------------------------------------------------------------------
	    //
	    //  Constructor
	    //
	    //--------------------------------------------------------------------------
	
	    /**
	     *  Constructor.
	     *  Normally called by the Flex control and not used in application code.
	     *
	     *  @param type The event type; indicates the action that caused the event.
	     *
	     *  @param bubbles Specifies whether the event can bubble
	     *  up the display list hierarchy.
	     *
	     *  @param cancelable Specifies whether the behavior
	     *  associated with the event can be prevented.
	     *
	     *  @param rowIndex The zero-based index of the row that contains
	     *  the renderer, or for editing events, the index of the item in
	     *  the data provider that is being used
	     *
	     */
	    public function MenuEvent(type:String, menuLabel:MenuLabel, bubbles:Boolean = false,
                              cancelable:Boolean = false)
	    {
	        super(type, bubbles, cancelable);
	        
	        this.menuLabel = menuLabel;
	
	    }
	    
	    //--------------------------------------------------------------------------
	    //
	    //  Properties
	    //
	    //--------------------------------------------------------------------------

		public var menuLabel:MenuLabel = null;
		
	    //--------------------------------------------------------------------------
	    //
	    //  Overridden methods: Event
	    //
	    //--------------------------------------------------------------------------
	
	    /**
	     *  @private
	     */
	    override public function clone():Event
	    {
	        return new MenuEvent(type, menuLabel, bubbles, cancelable);
	    }
	}
}