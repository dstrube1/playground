package events
{
	import flash.events.Event;

	public class PanelMenuEvent extends Event
	{
		public static const PANEL_MENU_CHANGE:String = 'panelMenuChange';
		
		public var index:Number;
		
		public function PanelMenuEvent(index:Number, type:String)
		{
			super(type);
			this.index = index;	
		}
		
		
		public override function clone():Event
		{
			return new PanelMenuEvent(index, type);
		}
	}
}