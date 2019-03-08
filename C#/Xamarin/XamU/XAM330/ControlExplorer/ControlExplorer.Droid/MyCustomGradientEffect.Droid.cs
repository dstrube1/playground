using Android.Graphics.Drawables;
using ControlExplorer.Droid;
using CustomGradient.Droid;

using Xamarin.Forms;
using Xamarin.Forms.Platform.Android;

[assembly: ExportEffect(typeof(MyCustomGradientEffect), "CustomButtonGradientEffect")]
namespace CustomGradient.Droid
{
    public class MyCustomGradientEffect : PlatformEffect
    {
        private Drawable oldDrawable;

        protected override void OnAttached()
        {
            if (Element is Button == false)
                return;
            oldDrawable = Control.Background;
            SetGradient();
        }

        protected override void OnDetached()
        {
            if (oldDrawable == null)
                return;
            Control.Background = oldDrawable;
        }

        private void SetGradient()
        {
            //https://elearning.xamarin.com/forms/xam330/3-create-an-effect/exercise4/1-create-the-android-effect
            var xfButton = Element as Button;
            var colorTop = xfButton.BackgroundColor;
            Color colorBottom = Color.Black;
            var drawable = Gradient.GetGradientDrawable(colorTop.ToAndroid(), colorBottom.ToAndroid());
            Control.SetBackground(drawable);
        }
    }
}
