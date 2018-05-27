using System;
using System.Collections;
using System.Threading;

//
// a place to test stuff
//

namespace ConsoleApplication1
{
    class Program
    {
        private static EvClass evRaise;

        #region ackerman recursion
        static Hashtable hash;

        //Investigating stackoverflow handling:
        //https://stackoverflow.com/questions/1599219/c-sharp-catch-a-stack-overflow-exception
        //static int nOther;
        //static int topOfStack;
        //const int stackSize = 1000000; // Default?

        //// The func is 76 bytes, but we need space to unwind the exception.
        //const int spaceRequired = 18 * 1024;
        #endregion

        public static void Main(string[] args)
        {
            #region mem leak
            //evRaise = new EvClass();

            //const int limit = 50000;
            //for (int i = 0; i <= limit; i++)
            //{
            //    GenLeak(i, limit);
            //    //System.Threading.Thread.Sleep(2000);
            //}
            #endregion

            #region ackerman recursion
            //https://www.youtube.com/watch?v=i7sm9dzFtEI
            //Console.WriteLine("Phase 2 passed. ");
            hash = new Hashtable();

            const int maxStackSize = 10000000;
            var newThread = new Thread(() => ackermanHash(4, 1), maxStackSize);
            //10000000 works for 4,1; crashes with 10,000,000 for 4,2 at about 38,832k, works with 100,000,000
            newThread.Start();

            #endregion

            Console.ReadLine();
        }

        private static void GenLeak(int index, int limit)
        {
            var memoryLeak = new MemLeak(evRaise);
            memoryLeak = null;
            GC.Collect();
            long memory = GC.GetTotalMemory(true);
            float percent = (float)index / (float)limit;
            Console.WriteLine("Mem: {0:0,0}, {1} out of {2}, {3}% done ", memory, index, limit, (percent * 100));
        }

        #region ackerman recursion
        private static int ackerman(int m, int n)
        {
            int ans;
            if (m == 0)
            {
                var key = "m = 0; n = " + n;
                ans = n + 1;
                Console.WriteLine(key);
            }
            else if (n == 0)
            {
                var key = "m = " + m + "; n = 0";
                ans = ackerman(m - 1, 1);
                Console.WriteLine(key);
            }
            else
            {
                var key = "m = " + m + "; n = " + n;
                ans = ackerman(m - 1, ackerman(m, n - 1));
                Console.WriteLine(key);
            }
            return ans;
        }

        //solve this with a hashtable
        public static int ackermanHash(int m, int n)
        {
            var ans = 0;
            if (m == 0)
            {
                var key = "m = 0; n = " + n;
                //Console.WriteLine(key);
                if (hash.Contains(key))
                    ans = (int) hash[key];
                else
                {
                    ans = n + 1;
                    hash.Add(key, ans);
                }
            }
            else if (n == 0)
            {
                var key = "m = " + m + "; n = 0";
                //Console.WriteLine(key);
                if (hash.Contains(key))
                    ans = (int) hash[key];
                else
                {
                    ans = ackermanHash(m - 1, 1);
                    hash.Add(key, ans);
                }
            }
            else
            {
                var key = "m = " + m + "; n = " + n;
                Console.WriteLine(key);
                if (hash.Contains(key))
                    ans = (int) hash[key];
                else
                {
                    ans = ackermanHash(m - 1, ackermanHash(m, n - 1));
                    hash.Add(key, ans);
                }

            }

            Console.WriteLine(ans);
            return ans;
        }

        #endregion
    }
}
