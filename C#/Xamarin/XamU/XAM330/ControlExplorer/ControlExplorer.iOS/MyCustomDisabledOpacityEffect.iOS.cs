using System.ComponentModel;

using CustomDisabledOpacity.iOS;

using Xamarin.Forms;
using Xamarin.Forms.Platform.iOS;

//[assembly: ResolutionGroupName("Xamarin")]
[assembly: ExportEffect(typeof(MyCustomDisabledOpacityEffect), "CustomDisabledOpacityEffect")]
namespace CustomDisabledOpacity.iOS
{
    //https://elearning.xamarin.com/forms/xam330/3-create-an-effect/2-respond-to-ui-notifications
    public class MyCustomDisabledOpacityEffect : PlatformEffect
    {
        protected override void OnAttached()
        {
            //required for interface implementation, but nothing to be done here?
        }

        protected override void OnDetached()
        {
            //required for interface implementation, but nothing to be done here?
        }

        protected override void OnElementPropertyChanged(PropertyChangedEventArgs e)
        {
            base.OnElementPropertyChanged(e);
            if (e.PropertyName == VisualElement.IsEnabledProperty.PropertyName)
            {
                if (((VisualElement)Element).IsEnabled)
                {
                    Control.Layer.Opacity = 1;
                }
                else
                {
                    Control.Layer.Opacity = 0.5f;
                }
            }
        }
    }
}
