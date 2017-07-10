package com.adobe.display
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowType;
	import flash.display.NativeWindowSystemChrome;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * A lightweight window to display the message.
	 */
	public class MessageWindow extends NativeWindow
	{
		public var timeToLive:uint;
		public static const stockWidth:int = 250;
		public static const stockHeight:int = 70;
		private var manager:DisplayManager;
		private const format:TextFormat = new TextFormat("arial",14,0);
					
		public function MessageWindow(message:String, manager:DisplayManager):void{
			this.manager = manager;
			
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			options.type = NativeWindowType.LIGHTWEIGHT;
			options.systemChrome = NativeWindowSystemChrome.NONE;
			options.transparent = true;
			
			super(options);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onClick);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			manager.addEventListener(DisplayManager.LIFE_TICK,lifeTick,false,0,true);
			width = MessageWindow.stockWidth;
			height = MessageWindow.stockHeight;
			x = 20;
			y = 20;
			draw();
			
			var textDisplay:TextField = new TextField();
			textDisplay.text = message;
			textDisplay.setTextFormat(format);
			stage.addChild(textDisplay);
			textDisplay.x = 5;
			textDisplay.y = 5;
			textDisplay.width = width - 10;
			textDisplay.height = height - 10;
			
			alwaysInFront = true;
		}
		
		private function onClick(event:MouseEvent):void{
			close();
		}
		
		public function lifeTick(event:Event):void{
			timeToLive--;
			if(timeToLive < 1){
				close();
			}
		}
		
		public override function close():void{
			manager.removeEventListener(DisplayManager.LIFE_TICK,lifeTick);
			super.close();
		}
		
		private function draw():void{
			var background:Sprite = new Sprite();
			with(background.graphics){
				lineStyle(1);
				beginFill(0xddffdd,.9);
					drawRoundRect(1,2,width-2,height-4,8,8);
				endFill();
			}
			stage.addChild(background);
		}
		
		public function animateY(endY:int):void{
			var dY:Number;
			var animate:Function = function(event:Event):void{
				dY = (endY - y)/4
				y += dY;
				if( y <= endY){
					y = endY;
					stage.removeEventListener(Event.ENTER_FRAME,animate);
				}
			}
			stage.addEventListener(Event.ENTER_FRAME,animate);
		}
	}
}