using Foundation;
using System;
using UIKit;

namespace Fireworks
{
    public partial class AboutViewController : UIViewController
    {
        public AboutViewController (IntPtr handle) : base (handle)
        {
        }


        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            buttonClose.TouchUpInside += delegate (object sender, EventArgs eventArgs) {
                DismissViewController(true, null);
            };
        }
    }
}