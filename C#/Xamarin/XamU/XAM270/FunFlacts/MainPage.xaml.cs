using FlagData;
using Xamarin.Forms;
using System;

namespace FunFlacts
{
	public partial class MainPage : ContentPage
	{
        readonly FunFlactsViewModel vm = new FunFlactsViewModel();

		public MainPage()
		{
			InitializeComponent();
            BindingContext = vm;
            
            //old:
            // Setup the view
			//InitializeData();
		}
		
		private void InitializeData()
		{
            #region old
            //country.ItemsSource = (IList)repository.Countries;

            //https://elearning.xamarin.com/forms/xam270/1-use-data-binding/exercise1/1-create-a-binding-in-code
            //country.SelectedItem = CurrentFlag.Country;
            //country.SelectedIndexChanged += (s, e) => CurrentFlag.Country = repository.Countries[country.SelectedIndex];
            //country.BindingContext = CurrentFlag;
            //country.SetBinding(Picker.SelectedItemProperty, new Binding(nameof(CurrentFlag.Country)));

            //flagImage.Source = CurrentFlag.GetImageSource();

            //adopted.Date = CurrentFlag.DateAdopted;
            //adopted.DateSelected += (s, e) => CurrentFlag.DateAdopted = e.NewDate;

            //hasShield.IsToggled = CurrentFlag.IncludesShield;
            //hasShield.Toggled += (s, e) => CurrentFlag.IncludesShield = hasShield.IsToggled;

            //description.Text = CurrentFlag.Description;

            //BindingContext = CurrentFlag;
            #endregion
            #region new
            // Set the binding context
            //this.BindingContext = new { Countries = repository.Countries, CurrentFlag };
            #endregion
        }

		private async void OnShow(object sender, EventArgs e)
		{
			vm.CurrentFlag.DateAdopted = vm.CurrentFlag.DateAdopted.AddYears(1);
			await DisplayAlert(vm.CurrentFlag.Country,
				$"{vm.CurrentFlag.DateAdopted:D} - {vm.CurrentFlag.IncludesShield}: {vm.CurrentFlag.MoreInformationUrl}", 
				"OK");
		}

		private void OnMoreInformation(object sender, EventArgs e)//TappedEventArgs e)
		{
			Device.OpenUri(vm.CurrentFlag.MoreInformationUrl);
		}

		private void OnPrevious(object sender, EventArgs e)
		{
            vm.MoveToPreviousFlag();
		}

		private void OnNext(object sender, EventArgs e)
		{
            vm.MoveToNextFlag();
        }
    }
}
