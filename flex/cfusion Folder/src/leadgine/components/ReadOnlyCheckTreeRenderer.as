package leadgine.components
{
	import flash.events.MouseEvent;
	
	import mx.controls.CheckBox;
	import mx.controls.Tree;
	import mx.controls.treeClasses.TreeListData;

	public class ReadOnlyCheckTreeRenderer extends CheckTreeRenderer
	{
		public function ReadOnlyCheckTreeRenderer()
		{
			super();
		}
		/* none of these worked
		override protected function setCheckState (checkBox:CheckBox, value:Object, state:String):void{
			//do nothing
		}
		override protected function toggleParents (item:Object, tree:Tree, state:String):void{
			//
		}
		override protected function checkBoxToggleHandler(event:MouseEvent):void{
			//
		}
		override public function set data(value:Object):void
		{
			super.data = value;
			
			var _tree:Tree = Tree(this.parent.parent);
			//setCheckState (myCheckBox, value, value.@state);
			if(TreeListData(super.listData).item.@isBranch == 'true')
			{
		    	_tree.setStyle("defaultLeafIcon", null);
			}
	    }
	    */
	    //heck yeah!
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			myCheckBox.enabled = false; 
		}
	}
}