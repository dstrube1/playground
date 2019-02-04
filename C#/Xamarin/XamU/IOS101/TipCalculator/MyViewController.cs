using System;
using System.Diagnostics;
using CoreGraphics;
using UIKit;

namespace TipCalculator
{
    public class MyViewController : UIViewController
    {
        public MyViewController()
        {
        }

        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            //https://elearning.xamarin.com/ios/ios101/3-views-behavior/
            nfloat height = View.Bounds.Height;
            nfloat width = View.Bounds.Width;
            var subview = new UIView()
            {
                Frame = new CGRect(width / 2 - 20, height / 2 - 20, 40, 40)
            };

            //https://elearning.xamarin.com/ios/ios101/3-views-behavior/subviews
            var emailEntry = new UITextField()
            {
                //20 from the left, 28 from the top, 20 from the right, 35 tall
                Frame = new CGRect(20, 28, View.Bounds.Width - 20, 35), //incorrectly called View.Width in video
                KeyboardType = UIKeyboardType.EmailAddress,
                BorderStyle = UITextBorderStyle.RoundedRect,
                Placeholder = "Email Address"
            };

            var button = new UIButton(UIButtonType.Custom)
            {
                Frame = new CGRect(20, 71, View.Bounds.Width - 40, 35), //weird that 20 from the right doesn't really seem to work
                BackgroundColor = UIColor.FromRGB(0.5f, 0, 0)
            };
            button.SetTitle("Login", UIControlState.Normal);

            var label = new UILabel(new CGRect(190, 110, 100, 35))
            {
                Text = "Label",
                TextAlignment = UITextAlignment.Center, //this doesn't seem to work
                TextColor = UIColor.Blue
            };

            View.Add(label); //or View.AddSubview(label);
            //add multiple views:
            View.AddSubviews(emailEntry, button);
            //order in which they're added matters

            //If you want to remove everything:
            //RemoveAllContent();

            View.BackgroundColor = UIColor.Yellow;

            button.TouchUpInside += delegate(object sender, EventArgs args) {
                HideKeyboard(emailEntry);//this is not necessary if calling RemoveAllContent
                //RemoveAllContent();
            };
        }

        void HideKeyboard(UITextField textField)
        {
            Debug.WriteLine("HideKeyboard");
            textField.ResignFirstResponder();
        }

        private void RemoveAllContent()
        {
            Debug.WriteLine("RemoveAllContent");
            foreach (UIView subview in View)
            {
                subview.RemoveFromSuperview();
            }
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);

            //In real world, this is something declared elsewhere
            var backgroundImage = new UIImageView();

            if (disposing)
            {
                Debug.WriteLine("Disposing");
                backgroundImage.Dispose();
                backgroundImage = null;
            }
            else
            {
                Debug.WriteLine("NOT Disposing");
            }
        }

        public override void DidReceiveMemoryWarning()
        {
            base.DidReceiveMemoryWarning();
            //throw away any cached objects that can be recreated
            Debug.WriteLine("DidReceiveMemoryWarning");
        }
    }
}
