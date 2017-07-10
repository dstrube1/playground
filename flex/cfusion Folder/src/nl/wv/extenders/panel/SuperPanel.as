/********************************************
 title   : SuperPanel
 version : 1.5
 author  : Wietse Veenstra
 website : http://www.wietseveenstra.nl
 date    : 2007-03-30
********************************************/
package nl.wv.extenders.panel {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import leadgine.events.EndMaximizeEvent;
	import leadgine.events.EndRestoreEvent;
	
	import mx.containers.Panel;
	import mx.controls.Button;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.effects.Move;
	import mx.effects.Resize;
	import mx.events.DragEvent;
	import mx.events.EffectEvent;
	import mx.managers.CursorManager;
	
	[Event(name="endMaximize", type="leadgine.events.EndMaximizeEvent")]
	[Event(name="endRestore", type="leadgine.events.EndRestoreEvent")]
	public class SuperPanel extends Panel {
		[Bindable] public var showControls:Boolean = false;
		[Bindable] public var enableResize:Boolean = false;
				
		[Embed(source="/assets/img/resizeCursor.png")]
		private static var resizeCursor:Class;
		
		private var	pTitleBar:UIComponent;
		private var oW:Number;
		private var oH:Number;
		private var oX:Number;
		private var oY:Number;
		private var normalMaxButton:Button	= new Button();
		private var closeButton:Button		= new Button();
		private var resizeHandler:Button	= new Button();
		private var upMotion:Resize			= new Resize();
		private var downMotion:Resize		= new Resize();
		private var oPoint:Point 			= new Point();
		private var resizeCur:Number		= 0;
		//DS 20090829
		private var maxUpMotion:Resize		= new Resize();
		private var maxUpMove:Move			= new Move();
		private var minimizing:Boolean		= false;
		private var minimized:Boolean		= false;
		//DS 20090831
		private var maxDownMotion:Resize	= new Resize();
		private var maxDownMove:Move		= new Move();
				
		public function SuperPanel() {}

		override protected function createChildren():void {
			super.createChildren();
			this.pTitleBar = super.titleBar;
			//this.setStyle("headerColors", [0x3d7637, 0x30422e]);
			//this.setStyle("borderColor", 0x30422e);
			this.doubleClickEnabled = true;
			
			if (enableResize) {
				this.resizeHandler.width     = 12;
				this.resizeHandler.height    = 12;
				this.resizeHandler.styleName = "resizeHndlr";
				this.rawChildren.addChild(resizeHandler);
				this.initPos();
			}
			
			if (showControls) {
				this.normalMaxButton.width     	= 20;
				this.normalMaxButton.height    	= 20;
				this.normalMaxButton.styleName 	= "increaseBtn";
				this.closeButton.width     		= 20;
				this.closeButton.height    		= 20;
				this.closeButton.styleName 		= "closeBtn";
				this.pTitleBar.addChild(this.normalMaxButton);
				//this.pTitleBar.addChild(this.closeButton);
			}
			
			this.positionChildren();	
			this.addListeners();
		}
		
		public function initPos():void {
			this.oW = this.width;
			this.oH = this.height;
			this.oX = this.x;
			this.oY = this.y;
		}
	
		public function positionChildren():void {
			if (showControls) {
				this.normalMaxButton.buttonMode    = true;
				this.normalMaxButton.useHandCursor = true;
				this.normalMaxButton.x = this.unscaledWidth - this.normalMaxButton.width - 9;
				this.normalMaxButton.y = 8;
				this.closeButton.buttonMode	   = true;
				this.closeButton.useHandCursor = true;
				this.closeButton.x = this.unscaledWidth - this.closeButton.width - 8;
				this.closeButton.y = 8;
			}
			
			if (enableResize) {
				this.resizeHandler.y = this.unscaledHeight - resizeHandler.height - 1;
				this.resizeHandler.x = this.unscaledWidth - resizeHandler.width - 1;
			}
		}
		
		public function addListeners():void {
			this.addEventListener(MouseEvent.CLICK, panelClickHandler);
			this.pTitleBar.addEventListener(MouseEvent.MOUSE_DOWN, titleBarDownHandler);
			//this.pTitleBar.addEventListener(MouseEvent.DOUBLE_CLICK, titleBarDoubleClickHandler);
			//this.addEventListener(MouseEvent.DOUBLE_CLICK, panelDoubleClickHandler);
			if (showControls) {
				this.closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler);
				this.normalMaxButton.addEventListener(MouseEvent.CLICK, normalMaxClickHandler);
			}
			
			if (enableResize) {
				this.resizeHandler.addEventListener(MouseEvent.MOUSE_OVER, resizeOverHandler);
				this.resizeHandler.addEventListener(MouseEvent.MOUSE_OUT, resizeOutHandler);
				this.resizeHandler.addEventListener(MouseEvent.MOUSE_DOWN, resizeDownHandler);
			}
		}
		
		public function panelClickHandler(event:MouseEvent):void {
			this.pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			this.parent.setChildIndex(this, this.parent.numChildren - 1);
			this.panelFocusCheckHandler();
		}
		
		public function titleBarDownHandler(event:MouseEvent):void {
			this.pTitleBar.addEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
		}
			
		public function titleBarMoveHandler(event:MouseEvent):void {
			if (this.width < screen.width) {
				Application.application.parent.addEventListener(MouseEvent.MOUSE_UP, titleBarDragDropHandler);
				this.pTitleBar.addEventListener(DragEvent.DRAG_DROP,titleBarDragDropHandler);
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
				this.panelFocusCheckHandler();
				this.alpha = 0.5;
				this.startDrag(false, new Rectangle(0, 0, screen.width - this.width, screen.height - this.height));
			}
		}
		
		public function titleBarDragDropHandler(event:MouseEvent):void {
			this.pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			this.alpha = 1.0;
			this.stopDrag();
		}
		
		public function panelFocusCheckHandler():void {
			for (var i:int = 0; i < this.parent.numChildren; i++) {
				var child:UIComponent = UIComponent(this.parent.getChildAt(i));
				if (this.parent.getChildIndex(child) < this.parent.numChildren - 1) {
					//child.setStyle("headerColors", [0xC3D1D9, 0xD2DCE2]);
					//child.setStyle("borderColor", 0xD2DCE2);
				} else if (this.parent.getChildIndex(child) == this.parent.numChildren - 1) {
					//child.setStyle("headerColors", [0xC3D1D9, 0x5A788A]);
					//child.setStyle("borderColor", 0x5A788A);
				}
			}
		}
		
		public function titleBarDoubleClickHandler(event:MouseEvent):void {
			this.pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			
			this.upMotion.target = this;
			this.upMotion.duration = 300;
			this.upMotion.heightFrom = oH;
			this.upMotion.heightTo = 28;
			this.upMotion.end();
			
			this.downMotion.target = this;
			this.downMotion.duration = 300;
			this.downMotion.heightFrom = 28;
			this.downMotion.heightTo = oH;
			this.downMotion.end();
			
			if (this.width < screen.width) {
				if (this.minimized) {
				//DS 20090829 condition was this.height == oH, with conditional code reversed
				//note, since the titleBar gets covered by the rest of the panel, this code never gets called
				//must add panelDoubleClickHandler for un-minimizing
				//	this.downMotion.play();
				//	this.downMotion.addEventListener(EffectEvent.EFFECT_END, endEffectEventHandler);
				//	minimized = false;
				} else {
					this.upMotion.play();
					this.upMotion.addEventListener(EffectEvent.EFFECT_END, stopMinimizing);
					this.resizeHandler.visible = false;
					this.minimizing = true;//need this because panelDoubleClickHandler also catches this event after this function is through with it
					this.minimized = true;
				}
			}
		}
		private function stopMinimizing(event:EffectEvent):void{
			this.minimizing = false;
		}
		public function panelDoubleClickHandler(event:MouseEvent):void {
			this.downMotion.target = this;
			this.downMotion.duration = 300;
			this.downMotion.heightFrom = 28;
			this.downMotion.heightTo = oH;
			this.downMotion.end();
			
			if (! minimizing){
				if (this.minimized) {
					this.downMotion.play();
						this.downMotion.addEventListener(EffectEvent.EFFECT_END, endEffectEventHandler);
						minimized = false;
				}//else, nothing
			}
		}
						
		public function endEffectEventHandler(event:EffectEvent):void {
			this.resizeHandler.visible = true;
		}

		public function normalMaxClickHandler(event:MouseEvent):void {
			if (this.normalMaxButton.styleName == "increaseBtn") {
				if (this.height > 28) {
					this.initPos();
					//this.x = 0;
					//this.y = 0;
					//DS 20090829
					this.maxUpMotion.target = this;
					this.maxUpMotion.duration = 300;
					this.maxUpMotion.heightFrom = oH;
					this.maxUpMotion.heightTo = parent.height;
					this.maxUpMotion.widthFrom = oW;
					this.maxUpMotion.widthTo = parent.width;
					//DS 20090831:
					this.maxUpMove.target = this;
					this.maxUpMove.duration = 300;
					this.maxUpMove.xFrom = this.oX;
					this.maxUpMove.xTo = 0;
					this.maxUpMove.yFrom = this.oY;
					this.maxUpMove.yTo = 0;
					this.maxUpMove.end();
					this.maxUpMove.play();
					
					this.maxUpMotion.end();
					this.maxUpMotion.play();
					this.maxUpMotion.addEventListener(EffectEvent.EFFECT_END, handleEndMaximize);
					//this.width = parent.width; // screen.width;
					//this.height = parent.height; // screen.height;
					this.normalMaxButton.styleName = "decreaseBtn";
					//this.positionChildren();
				}
			} else {
				//DS 20090829
				this.maxDownMotion.target = this;
				this.maxDownMotion.duration = 300;
				this.maxDownMotion.heightFrom = parent.height;
				this.maxDownMotion.heightTo = oH;
				this.maxDownMotion.widthFrom = parent.width;
				this.maxDownMotion.widthTo = oW;
				this.maxDownMotion.end();
				this.maxDownMotion.play();
				this.maxDownMotion.addEventListener(EffectEvent.EFFECT_END, handleEndRestore);
				
				//DS 20090831:
				this.maxDownMove.target = this;
				this.maxDownMove.duration = 300;
				this.maxDownMove.xFrom = 0;
				this.maxDownMove.xTo = this.oX;
				this.maxDownMove.yFrom = 0;
				this.maxDownMove.yTo = this.oY;
				this.maxDownMove.end();
				this.maxDownMove.play();
					
				//this.x = this.oX;
				//this.y = this.oY;
				//this.width = this.oW;
				//this.height = this.oH;
				this.normalMaxButton.styleName = "increaseBtn";
				//this.positionChildren();
			}
		}
		private function handleEndMaximize(event:EffectEvent):void{
			repositionChildrenOnEndEffect();
			var endMaximizeEvent:EndMaximizeEvent = new EndMaximizeEvent(EndMaximizeEvent.END_MAXIMIZE);
			dispatchEvent(endMaximizeEvent);
		}
		private function handleEndRestore(event:EffectEvent):void{
			repositionChildrenOnEndEffect();
			var endRestoreEvent:EndRestoreEvent = new EndRestoreEvent(EndRestoreEvent.END_RESTORE);
			dispatchEvent(endRestoreEvent);
		}
		//DS 20090829
		private function repositionChildrenOnEndEffect():void{
			this.positionChildren();
		}
		public function closeClickHandler(event:MouseEvent):void {
			this.removeEventListener(MouseEvent.CLICK, panelClickHandler);
			this.parent.removeChild(this);
		}
		
		public function resizeOverHandler(event:MouseEvent):void {
			this.resizeCur = CursorManager.setCursor(resizeCursor);
		}
		
		public function resizeOutHandler(event:MouseEvent):void {
			CursorManager.removeCursor(CursorManager.currentCursorID);
		}
		
		public function resizeDownHandler(event:MouseEvent):void {
			Application.application.parent.addEventListener(MouseEvent.MOUSE_MOVE, resizeMoveHandler);
			Application.application.parent.addEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			this.resizeHandler.addEventListener(MouseEvent.MOUSE_OVER, resizeOverHandler);
			this.panelClickHandler(event);
			this.resizeCur = CursorManager.setCursor(resizeCursor);
			this.oPoint.x = mouseX;
			this.oPoint.y = mouseY;
			this.oPoint = this.localToGlobal(oPoint);		
		}
		
		public function resizeMoveHandler(event:MouseEvent):void {
			this.stopDragging();

			var xPlus:Number = Application.application.parent.mouseX - this.oPoint.x;			
			var yPlus:Number = Application.application.parent.mouseY - this.oPoint.y;
			
			if (this.oW + xPlus > 140) {
				this.width = this.oW + xPlus;
			}
			
			if (this.oH + yPlus > 80) {
				this.height = this.oH + yPlus;
			}
			this.positionChildren();
		}
		
		public function resizeUpHandler(event:MouseEvent):void {
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_MOVE, resizeMoveHandler);
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			CursorManager.removeCursor(CursorManager.currentCursorID);
			this.resizeHandler.addEventListener(MouseEvent.MOUSE_OVER, resizeOverHandler);
			this.initPos();
		}
	}
	
}