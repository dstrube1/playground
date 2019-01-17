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
    class MemLeak
    {
        private byte[] allocatedMemory;
        private EventClass evEvent;

        public MemLeak(EventClass evPass)
        {
            this.evEvent = evPass;
            this.allocatedMemory = new byte[10000];
            evPass.StrValChanged += new EventHandler(evPass_StringValueChanged);
        }

        private void evPass_StringValueChanged(object sender, EventArgs e)
        {
            Console.WriteLine("evPass_StringValueChanged");
        }

    }
}
