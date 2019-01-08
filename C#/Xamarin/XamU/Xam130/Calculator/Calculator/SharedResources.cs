using System;
using Xamarin.Forms;

namespace Calculator
{
    public static class SharedResources
    {
        //original
        //public static Color OperationButtonBackgroundColor = Color.FromRgb(0xff, 0xa5, 0);
        //If we want random colors, but we want all the colors to look the same:
        //public static Color OperationButtonBackgroundColor = GetRandomColor(); 
        //If we want them all different:
        public static Color OperationButtonBackgroundColor { get { return GetRandomColor(); } }

        private static Color GetRandomColor() 
        {
            Random random = new Random((int)DateTime.Now.Ticks);
            return Color.FromRgb(random.Next(0, 0xff), random.Next(0, 0xff), random.Next(0, 0xff));
        }

    }
}
