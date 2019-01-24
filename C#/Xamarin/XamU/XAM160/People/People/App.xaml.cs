using Xamarin.Forms;
using Xamarin.Forms.Xaml;

[assembly: XamlCompilation(XamlCompilationOptions.Compile)]
namespace People
{
    public partial class App : Application
    {
        public static PersonRepository PersonRepo { get; private set; }
        public static bool IsAsync = true;

        public App(string dbPath)
        {
            InitializeComponent();
            PersonRepo = new PersonRepository(dbPath, IsAsync);
            MainPage = new MainPage();
        }

        protected override void OnStart()
        {
            // Handle when your app starts
            //await MainPage.DisplayAlert(, "OK");
            //    Debug.WriteLine($"App OnStart {myText}");
        }

        protected override void OnSleep()
        {
            // Handle when your app sleeps
        }

        protected override void OnResume()
        {
            // Handle when your app resumes
        }
    }
}
