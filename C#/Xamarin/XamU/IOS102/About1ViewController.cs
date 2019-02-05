using Foundation;
using System;
using UIKit;

namespace Fireworks
{
    public partial class About1ViewController : UIViewController
    {
        public About1ViewController (IntPtr handle) : base (handle)
        {
        }

        partial void UIButton2189_TouchUpInside(UIButton sender)
        {
            DismissViewController(true, null);
            // closing from a modal segue
        }
    }
}