using Xamarin.Forms;
using Xamarin.Forms.Xaml;

[assembly:XamlCompilation(XamlCompilationOptions.Compile)]
namespace Astronomy
{
    public partial class App : Application
    {
        public App ()
        {
            InitializeComponent();

            var navPage = new NavigationPage(new Astronomy.MainPage());

            navPage.BarBackgroundColor = Color.Blue;
            navPage.BarTextColor = Color.Yellow;

            MainPage = navPage;
        }
    }
}
