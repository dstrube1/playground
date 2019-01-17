using System;

//
// sample app basis generated from public example
//

namespace ConsoleApplication1
{
    class EventClass
    {
        private string strItem;

        public string StringValue
        {
            get { return strItem; }
            set
            {
                if (strItem != value)
                {
                    strItem = value;
                    StrValChanged?.Invoke(this, new EventArgs());
                }
            }
        }

        public event EventHandler StrValChanged;

    }
}
