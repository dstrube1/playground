using System;

using Xamarin.Forms;

namespace Astronomy.Pages
{
    public partial class PersonalizePage : ContentPage
    {
        public PersonalizePage()
        {
            InitializeComponent();

            btnSave.Clicked += BtnSaveClicked;
            btnCancel.Clicked += BtnCancelClicked;

            if (Application.Current.Properties.ContainsKey("Name"))
            {
                entryName.Text = Application.Current.Properties["Name"].ToString();
            }
            if (Application.Current.Properties.ContainsKey("Icon"))
            {
                pickerIcon.SelectedItem = Application.Current.Properties["Icon"];
            }
        }

        async void BtnCancelClicked(object sender, EventArgs e)
        {
            await Navigation.PopModalAsync();
        }

        async void BtnSaveClicked(object sender, EventArgs e)
        {
            Application.Current.Properties["Name"] = entryName.Text;
            Application.Current.Properties["Icon"] = pickerIcon.SelectedItem.ToString();
            await Application.Current.SavePropertiesAsync();
            await Navigation.PopModalAsync();
        }
    }
}
