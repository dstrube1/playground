using System;
using System.ComponentModel;
using ControlExplorer.iOS;
using ControlExplorer.MyEffects;
using CoreAnimation;
using CustomGradient.iOS;

using UIKit;

using Xamarin.Forms;
using Xamarin.Forms.Platform.iOS;

[assembly: ExportEffect(typeof(MyCustomGradientEffect), "CustomButtonGradientEffect")]
namespace CustomGradient.iOS
{
    public class MyCustomGradientEffect : PlatformEffect
    {
        private CAGradientLayer gradLayer;

        protected override void OnAttached()
        {
            if (Element is Button == false)
                return;
            SetGradient();
        }

        protected override void OnDetached()
        {
            if (gradLayer != null)
                gradLayer.RemoveFromSuperLayer();
        }

        private void SetGradient() 
        {
            if (gradLayer != null)
                gradLayer.RemoveFromSuperLayer();
            var xfButton = Element as Button;
            var colorTop = xfButton.BackgroundColor;
            //using static value:
            //var colorBottom = Color.Black;
            //using attached property (see also OnElementPropertyChanged):
            var colorBottom = MyGradientEffect.GetGradientColor(xfButton);
            gradLayer = Gradient.GetGradientLayer(colorTop.ToCGColor(), colorBottom.ToCGColor(), (nfloat)xfButton.Width, (nfloat)xfButton.Height);
            Control.Layer.InsertSublayer(gradLayer, 0);
        }

        //https://elearning.xamarin.com/forms/xam330/4-add-configurable-properties/exercise5/3-read-the-attached-property
        protected override void OnElementPropertyChanged(PropertyChangedEventArgs e)
        {
            base.OnElementPropertyChanged(e);

            if (Element is Button == false)
                return;

            if (e.PropertyName == MyGradientEffect.ColorProperty.PropertyName)
                SetGradient();
        }
    }
}
