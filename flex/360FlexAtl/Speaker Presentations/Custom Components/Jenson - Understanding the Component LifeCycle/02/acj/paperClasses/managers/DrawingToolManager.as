package acj.paperClasses.managers
{
	import flash.events.MouseEvent;
	import acj.paperClasses.tools.DrawingTool;
	import acj.containers.BlankPaperWrapper;
	import acj.paperClasses.tools.DrawingToolEvent;
	import flash.geom.Point;
	
	public class DrawingToolManager
	{
		/**
		 * Author:  Axel Jensen
		 * Date:	10.21.07
		 * Purpose: dynamically creates a DrawingTool
		 * 
		 * parameters
		 * @className - must extend the acj.paperClasses.DrawingTool Class
		 * 
		 * @event - must be a mouse event, used to capture x & y's for starting x&y's of teh DrawingTool;
		 **/
		public static function createTool(className:Class, event:MouseEvent):DrawingTool{
			
			/*
			if( className != DrawingTool ){
				throw new Error('className must extend the DrawingTool class, please check axel.cfwebtools.com and search for "Drawing"');
				return;
			}
			*/
			
			var newClass:DrawingTool = new className();
			
			newClass.startX = event.localX;
	    	newClass.startY = event.localY;
	    	newClass.endX = event.localX;
	    	newClass.endY = event.localY;
	    	
	    	newClass.invalidateDisplayList();
	    	
			return newClass;
		}
		
		/**
		 * createStaticTool is used when you want to add a tool to the 
		 * display list without a mouse event
		 * say your surrounding a image to create a halo type effect of some sort
		 * you can just pass an sP,eP (startPoint) and (endPoint) and of course
		 * if you look in the flex doces you find that a point is a holder for x and y pairs
		 **/
		public static function createStaticTool(className:Class, sP:Point, eP:Point):DrawingTool{
			
			/*
			if( className != DrawingTool ){
				throw new Error('className must extend the DrawingTool class, please check axel.cfwebtools.com and search for "Drawing"');
				return;
			}
			*/
			
			var newClass:DrawingTool = new className();
			
			newClass.startX = sP.x;
	    	newClass.startY = sP.y;
	    	newClass.endX = eP.x;
	    	newClass.endY = eP.y;
	    	
	    	newClass.invalidateDisplayList();
	    	
			return newClass;
		}
		
		public static function removeTool(blankPaperWrapper:BlankPaperWrapper, drawingTool:DrawingTool):void{
			//loop through the array of children tools to remove it from the array
			for (var i:int = 0; i < blankPaperWrapper.aChildrenTools.length; i++){
				if(blankPaperWrapper.aChildrenTools.getItemAt(i) == drawingTool){
					blankPaperWrapper.aChildrenTools.removeItemAt(i);
				}
			}
			
			trace(blankPaperWrapper.aChildrenTools.length);
			blankPaperWrapper.removeChild(drawingTool);
			blankPaperWrapper.selectedItem = null;
			blankPaperWrapper.removeEventListener(DrawingToolEvent.SELECTED,doNothing);
		}
		
		public static function removeAllTools(blankPaperWrapper:BlankPaperWrapper):void{
			//loop through the array of children tools to remove it from the array
			for (var i:int = blankPaperWrapper.aChildrenTools.length - 1; i >= 0; i--){
				blankPaperWrapper.removeChild(blankPaperWrapper.aChildrenTools.getItemAt(i) as DrawingTool);
				blankPaperWrapper.aChildrenTools.removeItemAt(i);
			}
			
			blankPaperWrapper.selectedItem = null;
			blankPaperWrapper.removeEventListener(DrawingToolEvent.SELECTED,doNothing);
		}
		
		//USED FOR REMOVING EVENT LISTENERS
		private static function doNothing():void{}
	}
}