using Android.App;
using Android.Content.PM;
using Android.OS;

///////////////////////////////////////////////////////////////////////////
// IMPORTANT: 
//DO NOT UPDATE PACKAGES FOR ANY PROJECT IN THIS SOLUTION
//Or if you do, do so only if necessary, and do so only after backing up all code in this solution into a separate location.
//Updating packages in some project in this solution breaks the Android part.
///////////////////////////////////////////////////////////////////////////

namespace ControlExplorer.Droid
{
    //Original:
    //  [Activity(Label = "ControlExplorer", Icon = "@drawable/icon", Theme = "@android:style/Theme.Material.Light", MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation)]
    //Works
    //[Activity(Label = "ControlExplorer", Icon = "@drawable/icon", Theme = "@android:style/Theme.Material", MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation)]
    [Activity(Label = "ControlExplorer", Icon = "@drawable/icon", Theme = "@style/MyCustomTheme", MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation)]
    //MyCustomTheme is in Resources/values-v21/styles.xml
    public class MainActivity : global::Xamarin.Forms.Platform.Android.FormsApplicationActivity
    {
        protected override void OnCreate(Bundle bundle)
        {
            base.OnCreate(bundle);

            global::Xamarin.Forms.Forms.Init(this, bundle);
            LoadApplication(new App());
        }
    }
}

