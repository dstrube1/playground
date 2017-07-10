package view.distortion
{
	import com.adobe.ac.mxeffects.Distortion;
	import com.adobe.ac.mxeffects.DistortionConstants;
	
	import mx.skins.halo.ButtonSkin;
	
	public class ButtonSkin3D extends ButtonSkin
	{
		override protected function updateDisplayList( w : Number, h : Number ) : void
		{
			super.updateDisplayList( w, h );
			
			var distortion : Distortion = new Distortion( this );
			distortion.smooth = true;
			distortion.buildMode = DistortionConstants.OVERWRITE;
			
			switch ( name )
			{
				case "upSkin":
					
					distortion.openDoor( 25, DistortionConstants.BOTTOM );
					
					break;
				
				case "overSkin":

					distortion.openDoor( 15, DistortionConstants.BOTTOM );
			}
		}		
	}
}