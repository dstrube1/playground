package {

import mx.core.MovieClipLoaderAsset;
import flash.utils.ByteArray;



public class GeneratedAsset1 extends MovieClipLoaderAsset
{
	public function GeneratedAsset1()
	{
		super();
		initialWidth=271/20;
		initialHeight=270/20;
	}
	private static var bytes:ByteArray = null;

	override public function get movieClipData():ByteArray
	{
		if (bytes == null)
		{
			bytes = ByteArray( new dataClass() );
		}
		return bytes;
	}

	[Embed(_resolvedSource='/Users/davy/Documents/Flex Builder 2/LenzDemo3_new_skin_branch/resources/swf/triangle.swf', mimeType='application/octet-stream')]
	public var dataClass:Class;
}

}
