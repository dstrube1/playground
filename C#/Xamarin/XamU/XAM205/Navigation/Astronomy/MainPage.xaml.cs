using Astronomy.Pages;
using Xamarin.Forms;

namespace Astronomy
{
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            InitializeComponent();
            NavigationPage.SetBackButtonTitle(this, "Back"); //won't see this in effect until the next page

            btnSunrise.Clicked +=  (sender, e) => {  Navigation.PushAsync(new SunrisePage()); };
            btnMoonPhase.Clicked +=  (sender, e) => {  Navigation.PushAsync(new MoonPhasePage()); };
            //Clicking into any item on this page, the Back button will change back to the previous page name 
            //unless we add a call to SetBackButtonTitle in AstronomicalBodiesPage:
            btnSpaceInfo.Clicked +=  (sender, e) => {  Navigation.PushAsync(new AstronomicalBodiesPage()); };
            btnAbout.Clicked +=  (sender, e) => {  Navigation.PushAsync(new AboutPage()); };
            btnPersonalize.Clicked += async (sender, e) => { await Navigation.PushModalAsync(new PersonalizePage()); };
        }
        protected override void OnAppearing()
        {
            base.OnAppearing();
            if (Application.Current.Properties.ContainsKey("Name") && Application.Current.Properties.ContainsKey("Icon"))
            {
                lblWelcome.Text = "Welcome " + Application.Current.Properties["Name"] + Application.Current.Properties["Icon"] + "!";
            }
        }
    }
}