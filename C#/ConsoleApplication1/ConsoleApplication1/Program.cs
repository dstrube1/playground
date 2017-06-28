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
    class Program
    {
        private static EvClass evRaise;
        public static void Main(string[] args)
        {
            evRaise = new EvClass();
            for (int i = 0; i <= 50000; i++)
            {
                GenLeak();
                //System.Threading.Thread.Sleep(2000);
            }

            Console.ReadKey(true);
        }

        private static void GenLeak()
        {
            MemLeak memoryLeak = new MemLeak(evRaise);
            memoryLeak = null;
            GC.Collect();
            long memory = GC.GetTotalMemory(true);
            Console.WriteLine("Mem: {0:0,0}", memory);
        }

    }
}
