using Xamarin.Forms;
using QuickFlicks.ViewModels;
using Xamarin.Forms.Xaml;

[assembly: XamlCompilation(XamlCompilationOptions.Compile)]

namespace QuickFlicks
{
    //MVVM
    //https://elearning.xamarin.com/forms/xam301/3-apply-mvvm-to-xamarin-forms-app/exercise3/

    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            BindingContext = new MainViewModel();
            InitializeComponent();
        }
    }
}
