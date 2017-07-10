package acj.paperClasses.tools
{
	import mx.core.UIComponent;
	import flash.events.MouseEvent;


	//------------------------------
	//
	// Styles
	//
	//------------------------------
	// set styles here
	
	
	public class LineTool extends DrawingTool
	{
		
		//CONSTRUCTOR
		public function LineTool()
		{
			super();
		}
		
		//OVERRIDDEN FUNCTIONS
		override protected function createChildren():void
		{
			super.createChildren();
		}
		
		override public function clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			super.clickHandler(event);
		}
		
		override public function mouseDownHandler(event:MouseEvent):void
		{
			super.mouseDownHandler(event);
		}
		
		override public function mouseOutHandler(event:MouseEvent):void
		{
			super.mouseOutHandler(event);
		}
		
		override public function mouseOverHandler(event:MouseEvent):void
		{
			super.mouseOverHandler(event);
		}
		
		override public function mouseUpHandler(event:MouseEvent):void
		{
			super.mouseUpHandler(event);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			graphics.clear();
			graphics.lineStyle(2, lc, 1);
			graphics.moveTo(startX,startY);
			graphics.lineTo(endX,endY);
		}
	}
}