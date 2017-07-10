package acj.paperClasses.tools
{
	import mx.core.UIComponent;
	import flash.events.MouseEvent;
	import mx.managers.DragManager;

	public class ButtonRectangleTool extends DrawingTool
	{
		//2 is enough to at least see something is happening on the screen, if we set it to 0, you wouldnt see anything.
		private static var MINIMUM_WIDTH:Number = 2;
		private static var MINIMUM_HEIGHT:Number = 2;
		
		//CONSTRUCTOR
		public function ButtonRectangleTool()
		{
			super();
		}
		
		//OVERRIDDEN FUNCTIONS
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
			trace('mouseOver');
		}
		
		override public function mouseUpHandler(event:MouseEvent):void
		{
			super.mouseUpHandler(event);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			var w:Number;
			var h:Number; 
			if( !isNaN(endX) ){
				w = startX - endX;
				h = startY - endY;
				w = Math.abs(w); //switch to positive number;
				h = Math.abs(h); //switch to positive number;
				
				//WE NEED TO OVER RIDE THE WIDTH AND HEIGHT IF THEY ARE DRAGGING AND UP/lEFT OF THE STARTX OR STARTY... 
				//if mouse is top left of startX then set both w/h to the MINIMUM
				//get our ending mouse position by using endX, and endY
				if( endX < startX && endY < startY){
					w = MINIMUM_WIDTH;
					h = MINIMUM_HEIGHT;
				}
				
				//if the mouse is left of starting position, but dragging below it, start to expand then box downward (only set the MINIMUM WIDTH, not the height
				if( endX < startX && endY > startY )w = MINIMUM_WIDTH;
				
				//if the mouse is right of the starting position, and draggin above it, expand the box to the right (only set the min height)
				if( endX > startX && endY < startY )h = MINIMUM_HEIGHT;
				
				
			}else{
				w = unscaledWidth;
				h = unscaledHeight;
			}
			//trace('[endX]  '+endX+'   [endY]  '+endY);
			//trace('[startX]'+startX+'   [startY]'+startY);
			//trace('[w]'+w+'[h]'+h);
			
			graphics.clear();
			graphics.lineStyle(2, lc, 1);
			graphics.beginFill(0xFFFFFF,.5);
			graphics.drawRect(startX,startY,w,h);
			graphics.endFill();
		}
	}
}