using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;

namespace GreatQuotes.Data
{
    public class QuoteManager
    {
        //https://elearning.xamarin.com/forms/xam250/1-factory-pattern/exercise1/
        static readonly Lazy<QuoteManager> instance = new Lazy<QuoteManager>(() => new QuoteManager());
        IQuoteLoader loader;
        public IList<GreatQuote> Quotes;

        public static QuoteManager Instance { get { return instance.Value; } }

        private QuoteManager()
        {
            Quotes = new ObservableCollection<GreatQuote>();
            loader = QuoteLoaderFactory.Create();
            foreach (var quote in loader.Load())
            {
                Quotes.Add(quote);
            }
        }

        public void Save() 
        {
            loader.Save(Quotes);
        }

        //https://elearning.xamarin.com/forms/xam250/2-service-locator/exercise2/5-use-the-tts-service
        public void SayQuote(GreatQuote quote) 
        {
            if (quote == null)
            {
                Debug.WriteLine("Null quote");
                return;
            }
            var service = ServiceLocator.Instance.Resolve<ITextToSpeech>();
            if (service != null)
            {
                service.Speak(quote.QuoteText + " by " + quote.Author);
            }
            else
            {
                Debug.WriteLine("Null service");
            }
        }
    }
}
