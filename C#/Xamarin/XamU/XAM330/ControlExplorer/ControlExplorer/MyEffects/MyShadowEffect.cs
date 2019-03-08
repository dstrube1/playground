using Xamarin.Forms;

namespace ControlExplorer.MyEffects
{
    public class MyShadowEffect : RoutingEffect
    {
        //https://elearning.xamarin.com/forms/xam330/4-add-configurable-properties/
        public static readonly BindableProperty ColorProperty = BindableProperty.CreateAttached(
            propertyName: "Color", 
            returnType: typeof(Color), 
            declaringType: typeof(MyShadowEffect), 
            defaultValue: Color.Red);

        public static Color GetColor(View view)
        {
            return (Color)view.GetValue(ColorProperty);
        }

        public static void SetColor(View view, Color color)
        {
            view.SetValue(ColorProperty, color);
        }

        public MyShadowEffect() : base("Xamarin.CustomShadowEffect")
        {
        }
    }
}
