using System;

using UIKit;

namespace Fireworks
{
	public partial class ViewController : UIViewController
	{
        SimpleParticleGen fireworks;
        public ViewController (IntPtr handle) : base (handle)
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
            // Perform any additional setup after loading the view, typically from a nib.

            fireworks = new SimpleParticleGen(UIImage.FromFile("xamlogo.png"), this.View);
            buttonStart.TouchUpInside += delegate (object sender, EventArgs eventArgs) { fireworks.Start(); };

            }

        partial void ButtonAbout_TouchUpInside(UIButton sender)
        {
            var about = Storyboard.InstantiateViewController("AboutViewController");
            PresentViewController(about, true, null);
        }

        partial void SliderSize_ValueChanged(UISlider sender)
        {
            fireworks.ScaleMax = (nfloat)sender.Value;
        }

        partial void SwitchNight_ValueChanged(UISwitch sender)
        {
            if (sender.On)
            {
                View.BackgroundColor = UIColor.DarkGray;
            }
            else
            {
                View.BackgroundColor = UIColor.White;
            }
        }

        public override void DidReceiveMemoryWarning ()
		{
			base.DidReceiveMemoryWarning ();
			// Release any cached data, images, etc that aren't in use.
		}
	}
}

