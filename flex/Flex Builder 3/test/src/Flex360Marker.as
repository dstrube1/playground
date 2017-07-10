package
{
	import com.yahoo.maps.api.markers.Marker;

	public class Flex360Marker extends Marker
	{
		public function Flex360Marker(){
			super();
			
			this.graphics.beginFill(0xff0000);
			this.graphics.drawCircle(0,0,5);
			this.graphics.endFill();
		}
	}
}