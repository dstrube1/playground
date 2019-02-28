using Xamarin.Forms;

namespace QuickFlicks
{
    //MVVM
    //https://elearning.xamarin.com/forms/xam301/3-apply-mvvm-to-xamarin-forms-app/exercise3/

    public partial class App : Application
	{
		public App ()
		{
			InitializeComponent();

			MainPage = new NavigationPage(new QuickFlicks.MainPage());
		}

		protected override void OnStart ()
		{
			// Handle when your app starts
		}

		protected override void OnSleep ()
		{
			// Handle when your app sleeps
		}

		protected override void OnResume ()
		{
			// Handle when your app resumes
		}
	}
}
