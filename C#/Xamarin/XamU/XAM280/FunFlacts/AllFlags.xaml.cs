using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading.Tasks;
using System.Windows.Input;
using FlagData;
using Xamarin.Forms;

namespace FunFlacts
{
    public partial class AllFlags : ContentPage
    {
        private bool isEditing;
        private ToolbarItem cancelEditButton;
        //https://elearning.xamarin.com/forms/xam280/2-add-remove-items/2-support-pull-to-refresh
        public bool IsRefreshing;
        public ICommand RefreshCommand { get; private set; }

        public AllFlags()
        {
            InitializeComponent();

            //https://elearning.xamarin.com/forms/xam280/1-display-collection/exercise1/2-add-a-listview-to-the-page
            //step3 - with x.Name:
            //flags.ItemsSource = DependencyService.Get<FunFlactsViewModel>().Flags;
            //step 4 - without x.Name:
            BindingContext = DependencyService.Get<FunFlactsViewModel>();
            flags.ItemTapped += Flags_ItemTapped;

            //https://elearning.xamarin.com/forms/xam280/2-add-remove-items/exercise3/2-change-the-toolbar-button
            cancelEditButton = (ToolbarItem)Resources[nameof(cancelEditButton)];

            //https://elearning.xamarin.com/forms/xam280/2-add-remove-items/exercise3/3-add-support-for-editing-mode
            flags.ItemSelected += Flags_ItemSelected;
        }

        protected override void OnAppearing() 
        {
            //https://elearning.xamarin.com/forms/xam280/2-add-remove-items/exercise3/4-use-an-observable-collection
            //Clear out the selected item so that it's possible to click it after the detail screen to edit it
            flags.SelectedItem = null;
        }

        async void Flags_ItemTapped(object sender, ItemTappedEventArgs e)
        {
            if (!isEditing)
            {
                //var flag = (Flag)e.Item;
                await this.Navigation.PushAsync(new FlagDetailsPage());
            }
        }

        async void Flags_ItemSelected(object sender, SelectedItemChangedEventArgs e)
        {
            if (isEditing)
            {
                var flag = (Flag)e.SelectedItem;
                await DeleteFlag(flag, true);
            }

        }

        private async Task DeleteFlag(Flag flag, bool fromEdit)
        {
            var result = await DisplayAlert("Confirm", $"Do you want to delete the {flag} flag?", "Yes", "No");
            if (result)
            {
                //these calls to BeginRefresh and EndRefresh aren't necessary right here and how, but good to know for manually refreshing
                //flags.BeginRefresh();
                //this doesn't seem to help
                //IsRefreshing = true;

                DependencyService.Get<FunFlactsViewModel>().Flags.Remove(flag);
                //Call cancel to exit edit
                if (fromEdit)
                {
                    OnEdit(cancelEditButton, null);
                }
                //for(int i=0; i>=0; i++) { }
                //IsRefreshing = false;
                //flags.EndRefresh();
            }
            else
            {
                //https://elearning.xamarin.com/forms/xam280/2-add-remove-items/exercise3/4-use-an-observable-collection
                //Clear out the selected item so that it's possible to click it after cancelling to edit it
                flags.ItemSelected -= Flags_ItemSelected;
                flags.SelectedItem = null;
                flags.ItemSelected += Flags_ItemSelected;
            }
        }


        private void OnEdit(object sender, EventArgs e)
        {
            var tbItem = sender as ToolbarItem;
            isEditing = (tbItem == editButton);

            ToolbarItems.Remove(tbItem);
            ToolbarItems.Add(isEditing ? cancelEditButton : editButton);
        }
        public async void OnRefreshing(object sender, EventArgs e)
        {
            try
            {
                var collection = DependencyService.Get<FunFlactsViewModel>().Flags;
                int j = 0;
                for (int i = collection.Count - 1; i >= collection.Count / 2; i--)
                {
                    if (j != i)
                    {
                        Debug.WriteLine($"Swapping {i} & {j}");
                        var temp = collection[i];
                        collection[i] = collection[j];
                        collection[j] = temp;
                        j++;
                        await Task.Delay(1000); // make it take some time.
                    }
                }
            }
            finally
            {
                // Turn off the refresh.
                ((ListView)sender).IsRefreshing = false;
            }
        }
        public async void OnDelete(object sender, EventArgs e)
        {
            var menuItem = (MenuItem)sender;
            var flag = (Flag)menuItem.BindingContext;
            await DeleteFlag(flag, false);
        }
    }
}
