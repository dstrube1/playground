using System;
using Plugin.Connectivity;
using Plugin.Connectivity.Abstractions;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

//From XAM150
//This works because the Xam.Plugin.Connectivity nuget package has been added to all projects in this solution

//In the Android manifest, added ACCESS_NETWORK_STATE and ACCESS_WIFI_STATE permissions

[assembly: XamlCompilation(XamlCompilationOptions.Compile)]
namespace NetStatus
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();

            MainPage = CrossConnectivity.Current.IsConnected
                ? (Page)new NetworkViewPage()
                : new NoNetworkPage();
        }

        protected override void OnStart()
        {
            // Handle when your app starts

            CrossConnectivity.Current.ConnectivityChanged += HandleConnectivityChanged;
        }

        void HandleConnectivityChanged(object sender, ConnectivityChangedEventArgs e)
        {
            Type currentPage = MainPage.GetType();
            if (e.IsConnected && currentPage != typeof(NetworkViewPage))
            {
                MainPage = new NetworkViewPage();
            }
            else if (!e.IsConnected && currentPage != typeof(NoNetworkPage))
            {
                MainPage = new NoNetworkPage();
            }
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
