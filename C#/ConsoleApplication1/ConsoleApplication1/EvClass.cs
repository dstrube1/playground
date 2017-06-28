using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//
// sample app basis generated from public example
//

namespace ConsoleApplication1
{
    class EvClass
    {
        private string strItem;

        public string StringValue
        {
            get { return this.strItem; }
            set
            {
                if (this.strItem != value)
                {
                    this.strItem = value;
                    if (this.StrValChanged != null)
                    {
                        this.StrValChanged(this, new EventArgs());
                    }
                }
            }
        }

        public event EventHandler StrValChanged;

    }
}
