/**
 * Author:		Axel Jensen
 * Notes:		360 Flex Atlanta 
 * Presenation:	Understanding the Component Lifecycle
 * 
 * 0101 shows 
 * 	-configuration
 * 	-attachment
 * 
 * in an actionscript project
 */

package {
	import flash.display.Sprite;
	import flash.display.Shape;

	public class ThreeSixtyFlex0101 extends Sprite
	{
		private var _background:Shape;
		
		public function ThreeSixtyFlex0101()
		{
			
			//CONFIGURATION
			_background = new Shape();
			
			_background.graphics.beginFill(0xFFFFFF,1);
			_background.graphics.drawRoundRectComplex(10,25,150,300,0,11,0,11);
			_background.graphics.endFill();
			
			
			//ATTACHMENT
			addChild(_background);
				
		}
	}
}
