using Xamarin.Forms;

namespace ControlExplorer.MyEffects
{
    //https://elearning.xamarin.com/forms/xam330/2-apply-effects-to-controls/2-wrap-an-effect-with-routingeffect
    public class MyFontEffect : RoutingEffect
    {
        //https://elearning.xamarin.com/forms/xam330/4-add-configurable-properties/
        public Color FontShadowColor = Color.Red;//{ get; set; }
        public MyFontEffect() : base("Xamarin.CustomFontEffect")
        {
        }
    }
}
