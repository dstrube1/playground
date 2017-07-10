/**
 * Author:		Axel Jensen
 * Notes:		360 Flex Atlanta 
 * Presenation:	Understanding the Component Lifecycle
 * 
 * 
 * differences from 0102
 * 	adds interaction from the mouse
 * 
 * 0103 shows 
 * 	-configuration
 * 	-attachment
 *  -enterframe interaction
 * 	
 * 
 * in an actionscript project
 * 
 * 
 */
package {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;

	public class ThreeSixtyFlex0102 extends Sprite
	{
		private var _background:Shape;
		
		/**
		 * added in 0102
		 **/
		private var ball:Ball;
		private var vx:Number = 5;
		
		public function ThreeSixtyFlex0102()
		{
			
			//CONFIGURATION
			_background = new Shape();
			
			_background.graphics.beginFill(0xFFFFFF,1);
			_background.graphics.drawRoundRectComplex(10,25,150,300,0,11,0,11);
			_background.graphics.endFill();
			
			ball = new Ball(20);
			ball.x = 50;
			ball.y = 100;
			
			//ATTACHMENT
			addChild(_background);
			addChild(ball);

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
				
		}
		
		private function onEnterFrame(event:Event):void
		{
			ball.x += vx;
		}
	}
}
