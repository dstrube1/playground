using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace GreatQuotes
{
    public class QuoteManager
    {
        public static QuoteManager Instance { get; private set; }

        private readonly IQuoteLoader _loader;
        private readonly ITextToSpeech _tts;
        public IList<GreatQuote> Quotes { get; private set; }

        public QuoteManager(IQuoteLoader loader, ITextToSpeech tts)
        {
            if (Instance != null)
                throw new Exception("Can only create a single QuoteManager.");
            Instance = this;
            _loader = loader;
            _tts = tts;

            Quotes = new ObservableCollection<GreatQuote>(loader.Load());
        }

        public void SayQuote(GreatQuote quote)
        {
            if (quote == null)
                throw new ArgumentNullException(nameof(quote));

            //ITextToSpeech tts = ServiceLocator.Instance.Resolve<ITextToSpeech>();

            var text = quote.QuoteText;

            if (!string.IsNullOrWhiteSpace(quote.Author))
                text += $" by {quote.Author}";

            _tts.Speak(text);
        }

        public void Save()
        {
            _loader.Save(Quotes);
        }
    }
}