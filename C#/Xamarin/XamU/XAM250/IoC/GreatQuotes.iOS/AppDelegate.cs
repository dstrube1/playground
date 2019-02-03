using System;
using Foundation;
using UIKit;
using System.Threading;
using System.Threading.Tasks;
using System.Diagnostics;

namespace GreatQuotes
{
	[Register("AppDelegate")]
	public class AppDelegate : UIApplicationDelegate
	{
        private readonly SimpleContainer container =  new SimpleContainer();
        public override UIWindow Window { get; set; }

		public override void FinishedLaunching(UIApplication application)
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
        }

        public override async void DidEnterBackground(UIApplication application)
		{
			CancellationTokenSource cts = new CancellationTokenSource();

			var taskId = UIApplication.SharedApplication.BeginBackgroundTask(() => cts.Cancel());

			try {
				await Task.Run(() => {
					QuoteManager.Instance.Save();
				}, cts.Token);
			}
			catch (Exception ex) {
				Debug.WriteLine(ex.Message);
			}
			finally {
				UIApplication.SharedApplication.EndBackgroundTask(taskId);
			}
		}
	}
}

