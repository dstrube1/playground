using System;
using Xamarin.Forms;

namespace ControlExplorer.MyEffects
{
    public class MyGradientEffect : RoutingEffect
    {
        //https://elearning.xamarin.com/forms/xam330/4-add-configurable-properties/exercise5/1-add-an-attached-property
        public static readonly BindableProperty ColorProperty = BindableProperty.CreateAttached(
            propertyName: "GradientColor",
            returnType: typeof(Color),
            declaringType: typeof(MyGradientEffect),
            defaultValue: Color.Black);

        public static Color GetGradientColor(VisualElement view)
        {
            return (Color)view.GetValue(ColorProperty);
        }

        public static void SetGradientColor(VisualElement view, Color color)
        {
            view.SetValue(ColorProperty, color);
        }

        public MyGradientEffect() : base("Xamarin.CustomButtonGradientEffect")
        {
        }
    }
}
