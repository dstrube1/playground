using System;

using Foundation;
using UIKit;
using System.Threading;
using System.Threading.Tasks;
using System.Diagnostics;
using System.Collections.Generic;
using System.Linq;
using GreatQuotes.Data;

namespace GreatQuotes
{
    //https://elearning.xamarin.com/forms/xam250/1-factory-pattern/exercise1/
    [Register("AppDelegate")]
     public class AppDelegate : UIApplicationDelegate
     {
          //QuoteLoader quoteLoader;
          //public static List<GreatQuote> Quotes { get; private set; }
          public override UIWindow Window { get; set; }

          public override void FinishedLaunching(UIApplication application)
          {
            //quoteLoader = new QuoteLoader();
            //Quotes = quoteLoader.Load().ToList();
            QuoteLoaderFactory.Create = () => new QuoteLoader();

            //https://elearning.xamarin.com/forms/xam250/2-service-locator/exercise2/
            ServiceLocator.Instance.Add<ITextToSpeech, TextToSpeechService>();
        }

        public override async void DidEnterBackground(UIApplication application)
          {
               CancellationTokenSource cts = new CancellationTokenSource();

#pragma warning disable RECS0002 // Convert anonymous method to method group
            var taskId = UIApplication.SharedApplication.BeginBackgroundTask(() => cts.Cancel());

            try
            {
                await Task.Run(() => {
                        //quoteLoader.Save(Quotes);
                        QuoteManager.Instance.Save();
                    }, cts.Token);
            }
            catch (Exception ex) {
                    Debug.WriteLine(ex.Message);
               }
               finally {
                    UIApplication.SharedApplication.EndBackgroundTask(taskId);
               }
#pragma warning restore RECS0002 // Convert anonymous method to method group
        }
    }
}

