using Android.App;
using System;
using Android.Runtime;
using System.Collections.Generic;
using System.Linq;
using GreatQuotes.Data;

namespace GreatQuotes
{
    //https://elearning.xamarin.com/forms/xam250/1-factory-pattern/exercise1/
    [Application(Icon="@drawable/icon", Label="@string/app_name")]
     public class App : Application
     {
          //static QuoteLoader quoteLoader;
          //public static List<GreatQuote> Quotes { get; private set; }

          public App(IntPtr h, JniHandleOwnership jho) : base(h, jho)
          {
          }

          public override void OnCreate()
          {
               base.OnCreate();
            QuoteLoaderFactory.Create = () => new QuoteLoader();
            //quoteLoader = new QuoteLoader();
            //Quotes = quoteLoader.Load().ToList();

            //https://elearning.xamarin.com/forms/xam250/2-service-locator/exercise2/
            ServiceLocator.Instance.Add<ITextToSpeech, TextToSpeechService>();
        }

          public static void Save()
          {
            //quoteLoader.Save(Quotes);
            QuoteManager.Instance.Save();
        }
     }
}

