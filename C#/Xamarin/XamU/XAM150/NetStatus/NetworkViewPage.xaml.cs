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
		public NetworkViewPage ()
		{
			InitializeComponent ();
		}

		protected override async void OnAppearing ()
		{
			base.OnAppearing ();

            IsBusy = true;

            foreach (var connectionType in CrossConnectivity.Current.ConnectionTypes)
            {
                Debug.WriteLine("In NetworkViewPage : OnAppearing - connectionType: " + connectionType.ToString());
            }

            CrossConnectivity.Current.ConnectivityChanged += UpdateNetworkInfo;

            IsBusy = false;

            ConnectionDetails.Text = CrossConnectivity.Current.ConnectionTypes.First().ToString();

        }

        protected override void OnDisappearing ()
		{
			base.OnDisappearing ();

			CrossConnectivity.Current.ConnectivityChanged -= UpdateNetworkInfo;
		}

		private void UpdateNetworkInfo (object sender, ConnectivityChangedEventArgs e)
		{
			if (CrossConnectivity.Current != null && CrossConnectivity.Current.ConnectionTypes != null) 
            {
                foreach (var cType in CrossConnectivity.Current.ConnectionTypes)
                {
                    Debug.WriteLine("In NetworkViewPage : UpdateNetworkInfo - connectionType: " + cType.ToString());
                }
                var connectionType = CrossConnectivity.Current.ConnectionTypes.FirstOrDefault ();
				ConnectionDetails.Text = connectionType.ToString ();
			}
		}
	}
}
