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

	[DefaultProperty("content")]


	[Bindable]
	public class BlankPaperWrapper extends UIComponent
	{
		//public STATIC PROPERTIES
		
		//private STATIC PROPERTIES		
		private static var BORDER_WIDTH:int = 400;
		private static var BORDER_HEIGHT:int = 400;
		private static var DEFAULT_TOOL:Class = ButtonRectangleTool; //must extend DrawingTool
		
		public function BlankPaperWrapper():void {
			super();

			this.addEventListener(FlexEvent.CREATION_COMPLETE,onCreationComplete);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);

		}
		
		//OTHER PROPERTIES (alphabetical)
		/**
		 * white bg
		 **/
		private var _border:Shape;
		
		/**
		 * the content we want to have contained by the wrapper
		 **/
		private var _content:UIComponent;
		public function set content(value:UIComponent):void {
			if(_content) {
				removeChild(_content);
			}
			_content = value;
			addChild(_content);
			
			invalidateSize();
		}
		
		public function get content():UIComponent {
			return _content;
		}
		
		[Inspectable(enumeration="vertical,horizontal")]
		public function set direction(value:String):void {}
		
		/**
		 * enableMouseInteraction is by default set to true,
		 * when you set it to false the mouse events are ignored
		 **/
		 public var enableMouseInteraction:Boolean = true;
		
		/**
		 * an array of the tools in the wrapper
		 **/
		 private var _aChildrenTools:ArrayCollection = new ArrayCollection();
		 public function get aChildrenTools():ArrayCollection{
		 	return _aChildrenTools;
		 }
		 
		 public function set aChildrenTools(val:ArrayCollection):void{
		 	_aChildrenTools = val;
		 }
		
		/**
		 * the tool we are currently drawing
		 **/
		private var _newTool:DrawingTool = new DrawingTool();
		
		
		/***
		 * selectedItem
		 * 
		 * this is for the selectedItem on the Wrapper
		 * say you want to delete an item, you select it first
		 * and then delete it, or select it first to move it...
		 * it is the currently selectedItem
		 * 
		 * selectedItem must extend the acj.paperClasses.DrawingTool class
		 **/
		private var _selectedItem:DrawingTool;
		public function set selectedItem(val:DrawingTool):void{
			_selectedItem = val;
		}
		public function get selectedItem():DrawingTool{
			return _selectedItem;
		}
		
		
		/***
		 * selectedTool 
		 * 
		 * is here so the user can give 
		 * the component a selected tool 
		 * this is the current tool that we are drawing with
		 * be it a RectangleTool, LineTool or soon to be something
		 * like a gradient Tool or something like that.
		 * 
		 * selectedTool must extend the acj.paperClasses.DrawingTool class
		 **/
		private var _selectedTool:Class;
		public function set selectedTool(val:Class):void{
			_selectedTool = val;
		}
		public function get selectedTool():Class{
			return _selectedTool;
		}
		
		//EVENT LISTENERS
		private function onCreationComplete(event:FlexEvent):void{
			//placeholder
			systemManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			systemManager.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			
		}
		
		private function onKeyDown(event:KeyboardEvent):void{
			if(selectedItem)
			{
				switch(event.keyCode){
					case 46:
						DrawingToolManager.removeTool(this,selectedItem);
						selectedItem = null;
						break;
				}
			}
				
			//trace('[keyDown]'+event.keyCode);
		}
		
		private function onKeyUp(event:KeyboardEvent):void{
			//trace('[keyUp]'+event.keyCode);
		}
		
		private function onMouseDown(event:MouseEvent):void{
			//trace('onMouse_Down');
			if(enableMouseInteraction)
				startDragging(event);
		}
		
				
		protected function startDragging(event:MouseEvent):void
	    {
	    	createTool(event);
	    	
	        systemManager.addEventListener(
	            MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
	
	        systemManager.addEventListener(
	            MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
	
	        systemManager.stage.addEventListener(
	            Event.MOUSE_LEAVE, stage_mouseLeaveHandler);
	    }
	    
	    protected function stopDragging():void
	    {
	    	completeDrag();
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
	    	
	    	_newTool.endX = pt.x;
	    	_newTool.endY = pt.y;
	    	
	    	_newTool.invalidateDisplayList();
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
			
			if(_content) {
				measuredHeight = _content.getExplicitOrMeasuredHeight();
				measuredWidth = _content.getExplicitOrMeasuredWidth();
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(isNaN(unscaledWidth) || isNaN(unscaledHeight)) {
				return;
			}
			else
			{
				if(_content) {
					_content.move(0,0);
					_content.setActualSize(unscaledWidth, unscaledHeight);
				}
				
				_border.graphics.clear();
				_border.graphics.beginFill(0xFFFFFF,.1);
				_border.graphics.drawRect(0,0,this.unscaledWidth,this.unscaledHeight);
				_border.graphics.endFill();
			}
		}
		
		//OTHER FUNCTIONS
		private function drawingToolClickHandler(event:DrawingToolEvent):void{
			//trace(event.drawingTool.isSelected);
			if(event.drawingTool.isSelected && !event.drawingTool.isDragging)
				this.selectedItem = event.drawingTool;
			else
				selectedItem = null;
		}
		
		private function createTool(event:MouseEvent):void{
			
			if( selectedTool == null )
				selectedTool = DEFAULT_TOOL;
				
			_newTool = DrawingToolManager.createTool(selectedTool,event);

	    	addChild(_newTool);
	    	this._aChildrenTools.addItem(_newTool);
	    	_newTool.addEventListener(DrawingToolEvent.SELECTED, drawingToolClickHandler);
		}
		
		
		public function createStaticTool(sP:Point,eP:Point):DrawingTool{
			
			if( selectedTool == null )
				selectedTool = DEFAULT_TOOL;
				
			_newTool = DrawingToolManager.createStaticTool(selectedTool,sP,eP);

	    	addChild(_newTool);
	    	this._aChildrenTools.addItem(_newTool);
	    	_newTool.addEventListener(DrawingToolEvent.SELECTED, drawingToolClickHandler);
	    	
	    	//because we arent using a mouse event here, we have to set up the listeners manually
	    	_newTool.setupListeners();
	    	
	    	return _newTool;
		}
		
		
		private function completeDrag():void{
			_newTool.setupListeners();
		}
		
	}
}