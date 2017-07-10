package acj.paperClasses.tools
{
	import mx.core.UIComponent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import acj.paperClasses.tools.DrawingToolEvent;


	// -------------------------------------------
	// 
	// STYLES
	//
	// -------------------------------------------
	/**
	 *  Color of the tool when drawn
	 *
	 *  @default 0x000000
	 */
	[Style(name="lineColor", type="uint", format="Color", inherit="no")]
	
	/**
	 *  color of that the tool will change to when the mouse clicks on it
	 *  
	 *  @default 0xFFF000
	 */
	[Style(name="mouseDownColor", type="uint", format="Color", inherit="yes")]
	
	/**
	 *  color of that the tool will change to when the mouse rolls over it
	 *  
	 *  @default 0x3366FF
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")]
	
	/**
	 *  Color of the tool when it is selected
	 *
	 *  @default 0xF00000
	 */
	[Style(name="selectedColor", type="uint", format="Color", inherit="no")]
	
	
	public class DrawingTool extends UIComponent
	{
		public var startX:Number;
		public var startY:Number;
		
		public var endX:Number;
		public var endY:Number;
		
		public var lc:uint;
		
		//PRIVATE VARS
		/**
		 * we need to keep track of another pair of 
		 * startx, starty, endx, endy pairs
		 * in order to move the Tool when dragging on it.
		 * these can be private vars because nothing besides
		 * itself should need to see them
		 */
		 
		public function get isDragging():Boolean{
			if(systemManager.hasEventListener(MouseEvent.MOUSE_MOVE))
				return true;
			else
				return false;
		}
		
		private var moveStartX:Number;
		private var moveStartY:Number;
		
		private var moveEndX:Number;
		private var moveEndY:Number;
		
		private var moveDistanceX:Number;
		private var moveDistanceY:Number;
		
		private var _isSelected:Boolean;
		public function set isSelected(val:Boolean):void{
			this._isSelected = val;
			if(val)
				lc = getStyle('selectedColor');
		}
		
		public function get isSelected():Boolean{
			return _isSelected;
		}
		
		
		public function DrawingTool()
		{
			super();
			setupStyles();
		}
		
		public function setupStyles():void{
			if(getStyle('lineColor') == undefined)setStyle('lineColor','0x000000');
			if(getStyle('mouseDownColor') == undefined)setStyle('mouseDownColor','0xFF0000');
			if(getStyle('rollOverColor') == undefined)setStyle('rollOverColor','0x3366FF');
			if(getStyle('selectedColor') == undefined)setStyle('selectedColor','0xF00000');
		}
		public function setupListeners():void{
			//need to set up events 
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		/**
		 * Listens for click
		 **/
		[Event(name="click", type="flash.events.MouseEvent")]
		[Event(name="selected", type="acj..paperClasses.tools.DrawingToolEvent")]
		public function clickHandler(event:MouseEvent):void
		{
			isSelected = !isSelected;
			
			var drawingToolEvent:DrawingToolEvent = new DrawingToolEvent(this,event,DrawingToolEvent.SELECTED);
			dispatchEvent(drawingToolEvent);
			
			invalidateDisplayList();
		}
		
		
		/**
		 * Listens for mouseDown
		 **/
		[Event(name="mouseDown", type="flash.events.MouseEvent")]
		public function mouseDownHandler(event:MouseEvent):void
		{
			trace('mouseDown');
			//stop propogation so the BlankPaperWrapper doesn't listen and 
			//act on the mouseDown event
			event.stopPropagation();
			
			//trace('MOUSE_DOWN - DrawingTool');
			lc = getStyle('mouseDownColor');
			
			//adjust our move x and y's
			moveStartX = event.localX;
	    	moveStartY = event.localY;
	    	moveEndX = event.localX;
	    	moveEndY = event.localY;
	    	moveDistanceX = 0;
	    	moveDistanceY = 0;
	    	
	    	
			startDragging(event);
			invalidateDisplayList();
		}
		
		/**
		 * Listens for mouseLeave
		 **/
		[Event(name="mouseLeave", type="flash.events.MouseEvent")]
		public function mouseLeaveHandler(event:MouseEvent):void
		{
			//trace('MOUSE_LEAVE - DrawingTool');
			stopDragging();
		}
		/**
		 * Listens for mouseMove
		 **/
		[Event(name="mouseMove", type="flash.events.MouseEvent")]
		public function mouseMoveHandler(event:MouseEvent):void
		{
			var pt:Point = new Point(event.stageX,event.stageY);
	    	pt = globalToLocal(pt);
	    	
	    	moveEndX = pt.x;
	    	moveEndY = pt.y;
	    	
	    	//we need to re-adjust our start x & y and end x & y 
	    	
	    	moveDistanceX = moveEndX - moveStartX;
	    	moveDistanceY = moveEndY - moveStartY;

	    	//adjust our start variables again after we
	    	//have changed the moveDistance vars
	    	moveStartX = moveEndX;
	    	moveStartY = moveEndY;
	    	
	    	resetMoveVars();
	    	
	    	invalidateDisplayList();
		}
		/**
		 * Listens for mouseOver
		 **/
		[Event(name="mouseOver", type="flash.events.MouseEvent")]
		public function mouseOverHandler(event:MouseEvent):void
		{
			lc = getStyle('rollOverColor');
			invalidateDisplayList();
		}
		
		/**
		 * Listens for mouseOut
		 **/
		[Event(name="mouseOut", type="flash.events.MouseEvent")]
		public function mouseOutHandler(event:MouseEvent):void
		{
			if(isSelected && !isDragging)
				lc = getStyle('selectedColor');
			else
				lc = getStyle('lineColor');
				
			invalidateDisplayList();
		}
		
		/**
		 * Listens for mouseUp
		 **/
		[Event(name="mouseUp", type="flash.events.MouseEvent")]
		public function mouseUpHandler(event:MouseEvent):void
		{
			lc = getStyle('lineColor');
			
			if(isDragging)
				this.resetMoveVars();
			
			stopDragging();
			
			
			invalidateDisplayList();
			//trace('MOUSE_UP - DrawingTool');
		}
		
		protected function startDragging(event:MouseEvent):void
	    {
	        systemManager.addEventListener(
	            MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
	
	        systemManager.addEventListener(
	            MouseEvent.MOUSE_UP, mouseUpHandler, true);
	
	        systemManager.stage.addEventListener(
	            Event.MOUSE_LEAVE, mouseLeaveHandler);
	    }
	    protected function stopDragging():void
	    {
	        systemManager.removeEventListener(
	            MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
	
	        systemManager.removeEventListener(
	            MouseEvent.MOUSE_UP, mouseUpHandler, true);

	        systemManager.stage.removeEventListener(
	            Event.MOUSE_LEAVE, mouseLeaveHandler);
	    }
	    
	    private function resetMoveVars():void{
	    	startX += moveDistanceX;
	    	endX += moveDistanceX;
	    	startY += moveDistanceY;
	    	endY += moveDistanceY;
	    }
		
	}
}