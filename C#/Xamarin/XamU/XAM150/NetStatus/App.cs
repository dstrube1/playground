using System;
using Plugin.Connectivity;
using Plugin.Connectivity.Abstractions;
using Xamarin.Forms;

//From XAM150
//This works because the Xam.Plugin.Connectivity nuget package has been added to all projects in this solution

//In the Android manifest, added ACCESS_NETWORK_STATE and ACCESS_WIFI_STATE permissions

//For UWP, laugh until you need more info, then re-read XAM150

//

namespace NetStatus
{
	public class App : Application
	{
		public App()
		{
			// The root page of your application
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
