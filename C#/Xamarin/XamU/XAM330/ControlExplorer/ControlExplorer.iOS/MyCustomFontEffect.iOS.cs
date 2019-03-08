using System.ComponentModel;
using System.Linq;
using ControlExplorer.MyEffects;
using CustomFont.iOS;
using UIKit;
using Xamarin.Forms;
using Xamarin.Forms.Platform.iOS;

[assembly: ResolutionGroupName("Xamarin")]
[assembly: ExportEffect(typeof(MyCustomFontEffect), "CustomFontEffect")]
namespace CustomFont.iOS
{
    //This code came prebaked for Exercise 2, but explained after Ex3, here:
    //https://elearning.xamarin.com/forms/xam330/3-create-an-effect/
    //Note use of Element (Xam Forms Element) and Control (platform native control) below.

    class MyCustomFontEffect : PlatformEffect
    {
        private UIFont oldFont;

        protected override void OnAttached()
        {
            if (Element is Label == false)
                return;

            var effect = (MyFontEffect)Element.Effects.FirstOrDefault(e => e is MyFontEffect);
            if (effect != null)
                Control.Layer.ShadowColor = effect.FontShadowColor.ToCGColor();
            var label = Control as UILabel;

            oldFont = label.Font;

            label.Font = UIFont.FromName("Pacifico", label.Font.PointSize);
        }

        protected override void OnDetached()
        {
            if(oldFont != null)
            {
                var label = Control as UILabel;
                label.Font = oldFont;
            }
        }

        protected override void OnElementPropertyChanged(PropertyChangedEventArgs args)
        {
            base.OnElementPropertyChanged(args);
            //Optional; do nothing different in this case
        }
    }
}