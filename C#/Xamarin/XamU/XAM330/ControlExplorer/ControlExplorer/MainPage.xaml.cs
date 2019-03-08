using ControlExplorer.MyEffects;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace ControlExplorer
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class MainPage : ContentPage
    {
        //https://elearning.xamarin.com/forms/xam330/2-apply-effects-to-controls/exercise2/2-resolve-the-effect
        Effect fontEffect;
        //Taking a stab at shadow effect
        Effect shadowEffect;
        //Trying opacity effect
        Effect opacityEffect;
        //
        Effect gradientEffect;

        int count;
        public MainPage()
        {
            InitializeComponent();

            //fontEffect = Effect.Resolve("Xamarin.CustomFontEffect");
            //https://elearning.xamarin.com/forms/xam330/2-apply-effects-to-controls/exercise3/3-apply-routingeffect-in-code
            fontEffect = new MyFontEffect();
            shadowEffect = new MyShadowEffect();
            //https://elearning.xamarin.com/forms/xam330/3-create-an-effect/2-respond-to-ui-notifications
            opacityEffect = new MyOpacityEffect();
            //https://elearning.xamarin.com/forms/xam330/3-create-an-effect/exercise4/5-use-the-gradient-effect
            gradientEffect = new MyGradientEffect();

            labelWelcome.Effects.Add(fontEffect);
            buttonClick.Effects.Add(shadowEffect);
            mySlider.Effects.Add(opacityEffect);
        }

        private void OnButtonClicked(object sender, System.EventArgs e)
        {
            buttonClick.Text = string.Format("Click Count = {0}", ++count);
        }

        private void OnSwitchToggled(object sender, ToggledEventArgs e)
        {
            labelWelcome.Effects.Remove(fontEffect);
            buttonClick.Effects.Remove(shadowEffect);
            buttonClick.Effects.Add(gradientEffect);
            mySlider.IsEnabled = true;

            if (switchEffects.IsToggled)
            {
                labelWelcome.Effects.Add(fontEffect);
                buttonClick.Effects.Add(shadowEffect);
                buttonClick.Effects.Add(shadowEffect);
                if (gradientEffect != null) 
                    buttonClick.Effects.Remove(gradientEffect);
                mySlider.IsEnabled = false;
            }
        }

        private void OnSliderColorValueChanged(object sender, ValueChangedEventArgs e)
        {
            var gradColor = new Color(e.NewValue / 255.0, e.NewValue / 255.0, e.NewValue / 255.0);
            MyGradientEffect.SetGradientColor(buttonClick, gradColor);
        }
    }
}