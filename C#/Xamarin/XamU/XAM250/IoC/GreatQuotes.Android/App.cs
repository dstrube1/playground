using Android.App;
using System;
using Android.Runtime;

namespace GreatQuotes
{
	[Application(Icon="@drawable/icon", Label="@string/app_name")]
	public class App : Application
	{
        private readonly SimpleContainer container = new SimpleContainer();
        public App(IntPtr h, JniHandleOwnership jho) : base(h, jho)
		{
		}

		public override void OnCreate()
		{
            //https://elearning.xamarin.com/forms/xam250/3-ioc-container/exercise3/3-setup-the-di-container
            //Old: Factory
            //QuoteLoaderFactory.Create = () => new QuoteLoader();
            //New: Dependency injection:
            container.Register<IQuoteLoader, QuoteLoader>();
            //challenge:
            //https://elearning.xamarin.com/forms/xam250/3-ioc-container/exercise3/4-extra-challenge-refactor
            container.Register<ITextToSpeech, TextToSpeechService>();
            //end challenge
            container.Create<QuoteManager>();

			base.OnCreate();
		}

		public static void Save()
		{
			QuoteManager.Instance.Save();
		}
	}
}

