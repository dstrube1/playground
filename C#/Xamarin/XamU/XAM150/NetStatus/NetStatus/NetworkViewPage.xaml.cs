using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using Newtonsoft.Json;
using Plugin.Connectivity;
using Plugin.Connectivity.Abstractions;
using Xamarin.Forms;

namespace NetStatus
{
    public partial class NetworkViewPage : ContentPage
    {
        public NetworkViewPage()
        {
            InitializeComponent();
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();

            IsBusy = true;

            foreach (var connectionType in CrossConnectivity.Current.ConnectionTypes)
            {
                Debug.WriteLine("In NetworkViewPage : OnAppearing - connectionType: " + connectionType.ToString());
            }

            CrossConnectivity.Current.ConnectivityChanged += UpdateNetworkInfo;

            var client = new HttpClient();
            //var url = "get url from DiveLog app code";
            //var result = await client.GetStringAsync(url);
            //var modes = JsonConvert.DeserializeObject<List<DiveMode>>(result);
            //Debug.WriteLine($"Count of modes: {modes.Count}");

            //url = "get url from DiveLog app code";
            //result = await client.GetStringAsync(url);
            //var divers = JsonConvert.DeserializeObject<List<Diver>>(result);
            //Debug.WriteLine($"Count of divers: {divers.Count}");

            //url = "get url from DiveLog app code";
            //result = await client.GetStringAsync(url);
            //var tenders = JsonConvert.DeserializeObject<List<Diver>>(result);
            //Debug.WriteLine($"Count of tenders: {tenders.Count}");

            //url = "get url from DiveLog app code";
            //result = await client.GetStringAsync(url);
            //var DPICs = JsonConvert.DeserializeObject<List<Diver>>(result);
            //Debug.WriteLine($"Count of DPICs: {DPICs.Count}");

            //url = "get url from DiveLog app code";
            //result = await client.GetStringAsync(url);
            //var locations = JsonConvert.DeserializeObject<List<Location>>(result);
            //Debug.WriteLine($"Count of locations: {locations.Count}");

            for (short s = 0; s < short.MaxValue; s++)
            {
                if (s % 1000 == 0)
                    Debug.Write(".");
            }

            ////serializer.Deserialize()
            //Debug.WriteLine("result = " + result);

            IsBusy = false;

            ConnectionDetails.Text = CrossConnectivity.Current.ConnectionTypes.First().ToString();

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
                    Debug.WriteLine("In NetworkViewPage : UpdateNetworkInfo - connectionType: " + cType.ToString());
                }
                var connectionType = CrossConnectivity.Current.ConnectionTypes.FirstOrDefault();
                ConnectionDetails.Text = connectionType.ToString();
            }
        }
    }
}
