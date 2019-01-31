using System;
namespace GreatQuotes.Data
{
    //https://elearning.xamarin.com/forms/xam250/2-service-locator/exercise2/
    public interface ITextToSpeech
    {
        void Speak(string text);
    }
}
