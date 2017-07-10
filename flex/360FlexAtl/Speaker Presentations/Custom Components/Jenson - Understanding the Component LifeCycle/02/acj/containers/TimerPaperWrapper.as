package acj.containers
{
	import mx.core.UIComponent;
	import flash.display.Shape;
	import mx.events.FlexEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import mx.managers.PopUpManager;
	
	import acj.paperClasses.managers.DrawingToolManager;
	
	import acj.paperClasses.tools.DrawingTool;
	import acj.paperClasses.tools.LineTool;
	import acj.paperClasses.tools.RectangleTool;
	import acj.paperClasses.tools.ButtonRectangleTool;
	
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import acj.paperClasses.tools.DrawingToolEvent;
	import flash.events.KeyboardEvent;
	import mx.collections.ArrayCollection;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	import flash.utils.getTimer;

	[Bindable]
	public class TimerPaperWrapper extends UIComponent
	{
		//public STATIC PROPERTIES
		
		//private STATIC PROPERTIES		
		private static var BORDER_WIDTH:int = 400;
		private static var BORDER_HEIGHT:int = 400;
		private static var DEFAULT_TOOL:Class = LineTool; //must extend DrawingTool
		
		private var startPt:Point = new Point(300,300);
		private var endPt:Point = new Point();
		private var currentPt:Point = new Point();
		private var spring:Number = 0.1;
		private var friction:Number = 0.95;
		private var easing:Number = 0.2;
		
		private var returnToPoint:Boolean = true;
		private var isDragging:Boolean = false;
		

		private var _leftSide:Shape = new Shape();
		private var _rightSide:Shape = new Shape();
		
		// cached calculated page dimensions
		private var _pageWidth:Number;
		private var _pageHeight:Number;		
		private var _hCenter:Number;
		private var _centerX:Number;
		private var _centerY:Number;
		private var _radius:Number;
		private var _pageLeft:Number;
		private var _pageTop:Number;
		private var _pageRight:Number;
		private var _pageBottom:Number;
		
		//all of the boundary points
		private var br:Point = new Point(); //bottom right
		private var tr:Point = new Point(); //top right
		private var bl:Point = new Point(); //bottom left
		private var tl:Point = new Point(); //top left
		private var bc:Point = new Point(); //bottom center
		private var tc:Point = new Point(); //top center
		
		
		private var timer:Timer = new Timer(10);
		private var autoTurnDurationD:Number = 1000;
		private var _turnStartTime:Number;
		
		public function TimerPaperWrapper():void {
			super();

			this.addEventListener(FlexEvent.CREATION_COMPLETE,onCreationComplete);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);

		}
		
		//OTHER PROPERTIES (alphabetical)
		/**
		 * white bg
		 **/
		private var _border:Shape;
		
		//EVENT LISTENERS
		private function onCreationComplete(event:FlexEvent):void{
			//placeholder
		}
		
		private function onMouseDown(event:MouseEvent):void{
			//trace('onMouse_Down');
			startDragging(event);
		}
		
				
		protected function startDragging(event:MouseEvent):void
	    {
	    	timer.addEventListener(TimerEvent.TIMER, onTimer);
	    	timer.start();
	    	isDragging = true;
	    	
	    	var pt:Point = new Point(event.stageX,event.stageY);
	    	pt = globalToLocal(pt);
	    	
	    	endPt.x = pt.x;
	    	endPt.y = pt.y;
	    	
	        systemManager.addEventListener(
	            MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
	
	        systemManager.addEventListener(
	            MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
	
	        systemManager.stage.addEventListener(
	            Event.MOUSE_LEAVE, stage_mouseLeaveHandler);
	    }
	    
	    protected function stopDragging():void
	    {
	    	if(returnToPoint == false)
	    	{
		    	this.removeEventListener(TimerEvent.TIMER, onTimer);
		    	timer.stop();
		    	timer.reset();
	    	}
	    	
	    	isDragging = false;
	    	
	        systemManager.removeEventListener(
	            MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
	
	        systemManager.removeEventListener(
	            MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
	
	        systemManager.stage.removeEventListener(
	            Event.MOUSE_LEAVE, stage_mouseLeaveHandler);
	    }
	    
	    private function systemManager_mouseMoveHandler(event:MouseEvent):void
	    {
	    	var pt:Point = new Point(event.stageX,event.stageY);
	    	pt = globalToLocal(pt);
	    	
	    	endPt.x = pt.x;
	    	endPt.y = pt.y;
	    }
	    
	    private function isOutOfBounds():Boolean
	    {
	    	var b:Boolean = false;
	    	
	    	var dx:Number = endPt.x - bc.x;
	    	var dy:Number = endPt.y - bc.y;
	    	var currentDistance:Number = Math.sqrt(dx*dx + dy*dy);
			
			if(currentDistance >= _pageWidth)
			{
				b = true;
			}
				    	
	    	return b;
	    }
	    
	    private function onTimer(event:TimerEvent):void
	    {
	    	var vx:Number;
	    	var vy:Number;
	    	var dx:Number;
	    	var dy:Number;
	    	var d:Number; //distance from the end of the currentLine (currentPt) to the center pt
	    	
	    	var currentDX:Number;
	    	var currentDY:Number;
	    	var distance:Number; //distance from the current mouse point to the center
	    	var angle:Number;
	    	
	    	graphics.clear();
	    	graphics.lineStyle(2, 0x000000, 1);
	    	graphics.beginFill(0xffffff);
	    	
	    	if(currentPt.x == 0 && currentPt.y == 0)
	    	{
	    		currentPt.x = startPt.x;
	    		currentPt.y = startPt.y;
	    	}
	    	
	    	currentDX = (endPt.x - _centerX) * easing;
	    	currentDY = (endPt.y - _centerY) * easing;
	    	distance = Math.sqrt(currentDX*currentDX + currentDY*currentDY);
	    	
	    	if(isDragging)
	    	{
		    	var _isOutOfBounds:Boolean = isOutOfBounds();
		    	
		    	if( _isOutOfBounds == false )
		    	{
		    		vx = (endPt.x - currentPt.x) * easing;
			    	vy = (endPt.y - currentPt.y) * easing;
			    	
			    	currentPt.x += vx;
			    	currentPt.y += vy;
			    	
			    	dx = startPt.x - currentPt.x;
					dy = startPt.y - currentPt.y;
					d = Math.sqrt(dx*dx + dy*dy);
					
					//draw right triangle
					graphics.beginFill(0xffffff)
					graphics.drawCircle(currentPt.x, _centerY, d/2);
					graphics.endFill();
		    	}
		    	else if( _isOutOfBounds == true )
		    	{
			    	angle = Math.atan2(currentDX,currentDY);
			    	vx = _centerX + Math.sin(angle) * _radius;
			    	vy = _centerY + Math.cos(angle) * _radius;
			    	currentPt.x = vx;
					currentPt.y = vy;
					
					dx = _centerX - currentPt.x;
					dy = _centerY - currentPt.y;
					d = Math.sqrt(dx*dx + dy*dy);
					
					//draw right triangle
					graphics.moveTo(currentPt.x,currentPt.y);
					graphics.lineTo(_centerX,_centerY);
					
					//y3 = y1 - (x3 - x1)(x2 - x1)/(y2 - y1)
					var y3:Number = currentPt.y - (startPt.x - currentPt.x)*(_centerX - currentPt.x)/(_centerY - currentPt.y);
					
					graphics.moveTo(currentPt.x,currentPt.y);
					graphics.lineTo(startPt.x,y3);
					
					//if mouse is on the right side of book set center to be mid of right page
					graphics.drawCircle(_centerX, _centerY, d);
					
		    	}
		    	
				graphics.moveTo(startPt.x,startPt.y);
				graphics.lineTo(currentPt.x,currentPt.y);
				
				doStopPoint(dx);
				invalidateDisplayList();
	    	}
	    	else if( !isDragging && returnToPoint )
	    	{
	    		_turnStartTime = NaN;
	    		vx = (startPt.x - currentPt.x) * easing;
		    	vy = (startPt.y - currentPt.y) * easing;
		    	
		    	currentPt.x += vx;
		    	currentPt.y += vy;
		    	
		    	graphics.clear();
				graphics.lineStyle(2, 0x000000, 1);
				graphics.moveTo(startPt.x,startPt.y);
				graphics.lineTo(currentPt.x,currentPt.y);
				
				dx = startPt.x - currentPt.x;
				dy = startPt.y - currentPt.y;
				d = Math.sqrt(dx*dx + dy*dy);
				trace(d/2);
				
				doStopPoint(dx);
				invalidateDisplayList();
	    	}
	    	
	    	graphics.endFill();
	    }
	    
	    private function doStopPoint(dx:Number):void
	    {
	    	if(Math.abs(dx) < .05 && isDragging == false)
			{
				this.removeEventListener(TimerEvent.TIMER, onTimer);
		    	timer.stop();
		    	timer.reset();
			}
	    }
	    
	    private function systemManager_mouseUpHandler(event:MouseEvent):void
	    {
            stopDragging();
	    }
	    
	    private function stage_mouseLeaveHandler(event:MouseEvent):void
	    {
            stopDragging();
	    }
	    
	    //OVERRIDDEN METHODS
		override protected function createChildren():void {
			super.createChildren();
			
			//setup left side
			addChild(_leftSide);
			
			//setup right side
			addChild(_rightSide);
			
			// draws white background
			_border = new Shape();
			_border.graphics.clear();
			_border.graphics.beginFill(0xFFFFFF,.1);
			_border.graphics.drawRect(0,0,BORDER_WIDTH,BORDER_HEIGHT);
			_border.graphics.endFill();

			addChild(_border);
		}
		
		override protected function measure():void {
			super.measure();
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(isNaN(unscaledWidth) || isNaN(unscaledHeight)) {
				return;
			}
			else
			{
				
				_border.graphics.clear();
				_border.graphics.beginFill(0xFFFFFF,.1);
				_border.graphics.drawRect(0,0,this.unscaledWidth,this.unscaledHeight);
				_border.graphics.endFill();
				
				
				//setup left side
				_leftSide.x = 100;
				_leftSide.y = 100;
				_leftSide.graphics.clear();
				_leftSide.graphics.beginFill(0x000000,.5)
				_leftSide.graphics.drawRect(0,0,150,175);
				_leftSide.graphics.endFill();
				
				//setup right side

				_rightSide.x = _leftSide.x;
				_rightSide.y = 100;
				_rightSide.graphics.clear();
				_rightSide.graphics.beginFill(0xff0000,.5)
				_rightSide.graphics.drawRect(150,0,150,175);
				_rightSide.graphics.endFill();
				
				startPt.x = _rightSide.x + _rightSide.width + _leftSide.width;
				startPt.y = _rightSide.y + _rightSide.height;
				
				updateDetails();
				//trace('[_rightSide.width]'+_rightSide.width+'_x]'+_rightSide.x+'[startPt.x]'+startPt.x);
			}
		}
		
		//OTHER FUNCTIONS
		private function updateDetails():void
		{
			_hCenter = (_leftSide.width + _rightSide.width)/2;
			_pageWidth = 150;
			_pageLeft = _hCenter - _pageWidth;
			_pageRight = _hCenter + _pageWidth;
			_pageTop = 0;
			_pageBottom = startPt.y;
			_pageHeight = 175;
			_centerX = startPt.x - _hCenter;
			_centerY = _pageBottom;
			_radius = _pageWidth;
			
			br.x = _rightSide.x + _rightSide.width + _leftSide.width;
			br.y = _rightSide.y + _rightSide.height;
			
			tr.x = _rightSide.x + _rightSide.width;
			tr.y = _rightSide.y;
			
			bl.x = _leftSide.x;
			bl.y = _leftSide.y + _leftSide.height;
			
			tl.x = _leftSide.x;
			tl.y = _leftSide.y;
			
			bc.x = _centerX
			bc.y = _centerY;
			
			
		}
		
	}
}