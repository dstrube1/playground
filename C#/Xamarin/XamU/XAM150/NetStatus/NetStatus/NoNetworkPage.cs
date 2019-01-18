using System.Diagnostics;
using System.Net;
using System.Net.Http;
using Plugin.Connectivity;
using Plugin.Connectivity.Abstractions;
using Xamarin.Forms;

namespace NetStatus
{
    public class NoNetworkPage : ContentPage
    {
        public NoNetworkPage()
        {
            BackgroundColor = Color.FromRgb(0xf0, 0xf0, 0xf0);
            Content = new Label()
            {
                Text = "No Network Connection Available",
                HorizontalOptions = LayoutOptions.Center,
                VerticalOptions = LayoutOptions.Center,
                TextColor = Color.FromRgb(0x40, 0x40, 0x40),
            };
        }

        protected override async void OnAppearing() 
        {
            base.OnAppearing();

            CrossConnectivity.Current.ConnectivityChanged += UpdateNetworkInfo;

            try
            {
                var client = new HttpClient();
                var url = "https://ops-dev.georgiaaquarium.org/API/rest/DiveLog/GetDiveModes";
                var result = await client.GetStringAsync(url);
                Debug.WriteLine("result = " + result);
            }
            catch (HttpRequestException httpRequestException)
            {
                Debug.WriteLine($"Caught exception: {httpRequestException.Message}");
            }
            catch(WebException webException)
            {
                Debug.WriteLine($"Caught exception: {webException.Message}");
            }
        }

        protected override void OnDisappearing()
        {
            base.OnDisappearing();

            CrossConnectivity.Current.ConnectivityChanged -= UpdateNetworkInfo;
        }

        private void UpdateNetworkInfo(object sender, ConnectivityChangedEventArgs e)
        {
            if (CrossConnectivity.Current != null && CrossConnectivity.Current.ConnectionTypes != null)
            {
                foreach (var cType in CrossConnectivity.Current.ConnectionTypes)
                {
                    Debug.WriteLine("In NoNetworkPage : UpdateNetworkInfo - connectionType: " + cType.ToString());
                }
            }
        }
    }
}
