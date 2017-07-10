package dstrube
{
	import mx.controls.Alert;
	import mx.controls.treeClasses.TreeItemRenderer;
	
	public class MyTreeItemRenderer extends TreeItemRenderer
	{
		public function MyTreeItemRenderer()
		{
			super();
			
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(width, height);
			
			if (data){
				//how is this done?
				var dataLabel:String = data[label];
				if (data.isLeaf){
					Alert.show("Leaf: " + data.label);
				}
				else{
					Alert.show("Branch: " + data.label);
				}
			}
		}
	}
}