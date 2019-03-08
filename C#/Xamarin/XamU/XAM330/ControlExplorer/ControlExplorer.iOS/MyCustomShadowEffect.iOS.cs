using System.ComponentModel;
using ControlExplorer.MyEffects;
using CoreGraphics;
using CustomShadow.iOS;
using UIKit;
using Xamarin.Forms;
using Xamarin.Forms.Platform.iOS;

//[assembly: ResolutionGroupName("Xamarin")]
[assembly: ExportEffect(typeof(MyCustomShadowEffect), "CustomShadowEffect")]
namespace CustomShadow.iOS
{
    //https://elearning.xamarin.com/forms/xam330/3-create-an-effect/1-update-platform-specific-ui
    public class MyCustomShadowEffect : PlatformEffect
    {
        CGSize oldShadowOffset;
        UIColor oldShadowColor;

        protected override void OnAttached()
        {
            if (Element is Button == false)
                return;

            var button = Control as UIButton;
            //https://www.youtube.com/watch?v=FLETMNX8N_A
            //video in above link refers to this, but doesn't seem to be available anymore
            //button.SetShadowLayer();

            oldShadowOffset = button.TitleShadowOffset;
            oldShadowColor = button.CurrentTitleShadowColor;

            //using static value for color:
            //button.SetTitleShadowColor(UIColor.Black, UIControlState.Normal);
            //using attached property:
            //https://elearning.xamarin.com/forms/xam330/4-add-configurable-properties/1-update-attached-properties
            button.SetTitleShadowColor(MyShadowEffect.GetColor(button.ToView()).ToUIColor(), UIControlState.Normal);
            button.TitleShadowOffset = new CGSize(5, 2);
        }

        protected override void OnDetached()
        {
            //if (oldShadowColor != null) //oldShadowColor is always null, so detach doesn't work with this condition in effect
             // && oldShadowOffset != null) //oldShadowOffset is always not null
            //{
            var button = Control as UIButton;
                button.SetTitleShadowColor(oldShadowColor, UIControlState.Normal);
                button.TitleShadowOffset = oldShadowOffset;
            //}
        }
    }
}
