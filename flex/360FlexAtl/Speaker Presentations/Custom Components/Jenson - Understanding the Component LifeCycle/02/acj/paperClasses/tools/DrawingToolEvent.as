package acj.paperClasses.tools
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class DrawingToolEvent extends Event
	{
		public static const SELECTED:String = 'selected';
		
		public var drawingTool:DrawingTool;
		public var mouseEvent:MouseEvent;
		
		public function DrawingToolEvent(drawingTool:DrawingTool, mouseEvent:MouseEvent, type:String, bubbles:Boolean = false){
			super(type,bubbles);
			this.drawingTool = drawingTool;
			this.mouseEvent = mouseEvent;
		}
		override public function clone():Event{
			return new DrawingToolEvent(drawingTool, mouseEvent, type, bubbles);
		}
		
	}
}