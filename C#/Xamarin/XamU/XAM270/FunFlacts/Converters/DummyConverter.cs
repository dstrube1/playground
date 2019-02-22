using System;
using System.Diagnostics;
using System.Globalization;
using Xamarin.Forms;

namespace FunFlacts.Converters
{
    //https://elearning.xamarin.com/forms/xam270/2-use-value-converters/2-apply-value-converter-xaml
    public class DummyConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture) 
        {
            Debug.WriteLine("A good place for debugging");
            return value;
        }
        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture) 
        {
            Debug.WriteLine("A good place for debugging");
            return value;
        }
    }
}
