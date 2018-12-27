using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading;

//
// a place to test stuff
//

namespace ConsoleApplication1
{
    class Program
    {

        public static void Main(string[] args)
        {
            //linqXample();

            IntMax(true);
            //TODO 
            //LongMax();
            //FloatMax();
            //DoubleMax();
            //DecimalMax();?
            //java: BigIntegerMax();?

            Console.WriteLine("Done");

            //Console.ReadLine();
        }

        private static void linqXample()
        {
            //1 - where 
            //string[] words = { "hello", "wonderful", "LINQ", "beautiful", "world" };
            ////Get only short words
            //var shortWords = from word in words where word.Length <= 5 select word;
            ////Print each word out
            //foreach (var word in shortWords)
            //{
            //    Console.WriteLine(word);
            //}

            //2 - select 
            //var words = new List<string> { "an", "apple", "a", "day" };
            //const int start = 0;
            //const int size = 1;
            //var query = from word in words select word.Substring(start, size);
            //foreach (var s in query)
            //{
            //    Console.WriteLine(s);
            //}

            //3- groupBy
            var numbers = new List<int>() { 35, 44, 200, 84, 3987, 4, 199, 329, 446, 208 };
            var /*IEnumerable<IGrouping<int, int>>*/ query = from number in numbers
                                                             group number by number % 2;
            foreach (var group in query)
            {
                Console.WriteLine(group.Key == 0 ? "\nEven numbers:" : "\nOdd numbers:");
                //Either way, this ends up looking a little weird
                //Console.WriteLine(group.Key == 0 ? "Even numbers:\n" : "Odd numbers:\n");
                foreach (var i in group)
                {
                    Console.WriteLine(i);
                }
            }
        }

        #region Maximums

        private static void ByteMax() 
        {
            //Was going to do chars here, but chars aren't numbers in C# (?!)
            byte c = 1;
            byte c_p = 0;
            long count = 0;
            while (c_p < c)
            {
                c++;
                c_p++;
                count++;
            }
            Console.WriteLine($"Max of byte found: {count}");//255
            Console.WriteLine($"See also: {byte.MaxValue}");//255

        }

        private static void ShortMax() 
        {
            short s = 1;
            short s_p = 0;
            long count = 0;
            while (s_p < s)
            {
                s++;
                s_p++;
                count++;
            }
            Console.WriteLine($"Max of short found: {count}");//32767
            Console.WriteLine($"See also: {short.MaxValue}");//32767
        }

        private static void IntMax(bool isFast)
        {
            if (!isFast)
            {
                //Damn slow
                int i = 1;
                int i_p = 0;
                long count = 0;
                while (i_p < i)
                {
                    i++;
                    i_p++;
                    count++;
                    if (count % 100000000 == 0)
                        Console.Write(".");
                }
                Console.WriteLine("\nMax of int found : " + count);//2147483647
            }
            else
            {
                Console.WriteLine("Authoritative max of int : " + int.MaxValue);//2147483647
                intMaxRecursive(1, 10);
            }
        }

        private static bool intMaxRecursive(int candidate, int factor) 
        {
            if (factor < 2)
            {
                if (candidate < 0)
                {
                    Console.WriteLine("something went wrong; candidate is " + candidate);
                    return false;
                }
                else
                {
                    //Console.WriteLine("Narrowed down to factor " + factor + " and candidate is " + candidate);
                    int estimate = getIntMaxEstimate();
                    return intMaxRecursiveAdd(candidate, estimate);
                }
            }
            int product = candidate * factor;
            if (product > 0)
            {
                return intMaxRecursive(product, factor);
            }
            else
            {
                return intMaxRecursive(candidate, factor - 1);
            }
        }

        private static bool intMaxRecursiveAdd(int candidate, int addend) 
        {
            if (addend == 1)
            {
                if (candidate < 0)
                {
                    Console.WriteLine("something went wrong; candidate is " + candidate);
                    return false;
                }
                else
                {
                    int ltemp = candidate;
                    while (ltemp > 0)
                    {
                        candidate = ltemp;
                        ltemp++;
                    }
                    Console.WriteLine("int max found (quickly): " + candidate);
                    return true;
                }
            }
            int sum = candidate + addend;
            if (sum > 0)
            {
                return intMaxRecursiveAdd(sum, addend);
            }
            else
            {
                //Console.WriteLine(candidate + " + " + addend + " is too much; trying " + candidate + " + " + (addend / 2));
                return intMaxRecursiveAdd(candidate, addend / 2);
            }
        }

        private static int getIntMaxEstimate()
        {
            int myInt = 1;
            int iTemp = myInt;
            while (iTemp > 0)
            { //when iTemp exceeds the maximum, it loops around to a negative
                myInt = iTemp;
                iTemp *= 10;
                //Console.WriteLine("int max guess = " + myInt);
            }
            return myInt;
        }
        #endregion

        #region old
        //////////////////////////////////////////////////////////////////////////////////////////////
        //Before main:
        //////////////////////////////////////////////////////////////////////////////////////////////
        private static EvClass evRaise = null;

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

        //////////////////////////////////////////////////////////////////////////////////////////////
        //From within main:
        //////////////////////////////////////////////////////////////////////////////////////////////
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
        //hash = new Hashtable();

        //const int maxStackSize = 10000000;
        //var newThread = new Thread(() => ackermanHash(4, 1), maxStackSize);
        //10000000 works for 4,1; crashes with 10,000,000 for 4,2 at about 38,832k, works with 100,000,000
        //newThread.Start();

        #endregion

        #region Misc

        //how to handle null array:
        //string[] strings = null;
        //foreach (var s in strings ?? new string[0])
        //{
        //    Console.WriteLine("x");
        //}

        //string s = null;
        //Console.WriteLine("safely calling method on null object?: " + s?.Substring(0));

        //var r = "1111111111111111111111111111";
        //var message = $"Error gathering disclaimers.\r {r}"; //carriage return
        //Console.WriteLine("Done: " + message);

        #endregion

        //////////////////////////////////////////////////////////////////////////////////////////////
        //everything else:
        //////////////////////////////////////////////////////////////////////////////////////////////

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
                    ans = (int)hash[key];
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
                    ans = (int)hash[key];
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
                    ans = (int)hash[key];
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

        private static void splitTest()
        {
            var s = "1|2|3";
            var s0 = s.Split('|');
            foreach (var s1 in s0)
            {
                Console.WriteLine($"s1 = {s1}");
            }
        }

        private static void substringLength()
        {
            var test = "1";
            var caughtException = true;
            while (caughtException)
            {
                try
                {
                    Console.WriteLine($"test.Length = {test.Length}; test.Substring(7): {test.Substring(7)}");
                    caughtException = false;
                }
                catch (ArgumentOutOfRangeException)
                {
                    caughtException = true;
                    test += "1";
                }
            }
        }

        private static void fileDownloader()
        {
            using (var client = new WebClient())
            {
                for (var i = 2; i <= 25; i++)
                {
                    var filename = "0";
                    if (i < 10)
                    {
                        filename += $"{i}.mp3";
                    }
                    else
                    {
                        filename = $"{i}.mp3";
                    }
                    Console.WriteLine($"Downloading {filename}...");
                    //These files have already been downloaded
                    //client.DownloadFile("http://noliesplease.com/LonggameTech/mindtech/0001_to_0025/LonggameTech_mindtech_00" + filename, filename);
                    Console.WriteLine($"client.BaseAddress: {client.BaseAddress}");
                    //break;
                }
            }

        }

        private static void memoryManagement()
        {
            //TODO Memory management
            var currentProcess = Process.GetCurrentProcess();
            var array = new ArrayList();
            var s = "string";
            var i = 0;
            int index;
            var array1 = new ArrayList();
            for (index = 0; index < 100000; index++)
            {
                array.Add(s);
                array.Add(i);
                array.Add(array1);
            }
            var totalBytesOfMemoryUsed = currentProcess.WorkingSet64;

            Console.WriteLine($"Os in the a: {array.Count}; memUsage: {totalBytesOfMemoryUsed}");

            for (index = 0; index < array.Count; index++)
            {
                var o = array[index];
                //Console.WriteLine($"o in the a: {o}");
                array[index] = null;
                index++;
            }

            array = null;

            Console.WriteLine($"array is null; memUsage: {totalBytesOfMemoryUsed}");
        }

        private static void fractionToDouble()
        {
            const string s = "1/2";
            var s0 = s.Substring(0, s.IndexOf("/", StringComparison.Ordinal));
            var s1 = s.Substring(1 + s.IndexOf("/", StringComparison.Ordinal));
            var d0 = double.Parse(s0);
            var d1 = double.Parse(s1);
            var d = d0 / d1;

            Console.WriteLine($"s: {s} = d: {d}");

        }

        private static void TrailingZeroes()
        {
            decimal? zero = new decimal(0.00);
            var d = 0.010;
            var d0 = "0.010";
            var d1 = double.Parse(d0);
            if ((double.Parse(d.ToString(CultureInfo.InvariantCulture)) % 1).Equals(0))
            {
                Console.WriteLine("It's not, but just in case");
            }
            else if (d.ToString(CultureInfo.InvariantCulture).Contains("."))
            {
                Console.WriteLine($"d: {d}; zero: {zero}; d0: {d0}; d1: {d1}");
            }
            else
            {
                Console.WriteLine("Huh?");
            }
        }

        private static void NullOrEmptyList()
        {
            IList list = null;
            if (list == null || list.Count == 0)
            {
                Console.WriteLine("Empty list");
            }
        }

        private static bool IsWholeNumber(string s)
        {
            /*
             * Test:
             *                                      //14 zeroes - false     15 zeroes - trues
               string[] s1 = {"1.0","1.1","1.001", "1.000000000000001", "1.0000000000000001" };
               foreach (var s in s1)
               {
               Console.WriteLine($"isWholeNumber({s}) : {IsWholeNumber(s)} ");
               }

            //currency parsing
               const string s = "xxxxxxxxxxxx $100.000. ";
               var begin = s.IndexOf("$", StringComparison.Ordinal);
               var length = s.LastIndexOf(".", StringComparison.Ordinal) - begin;
               var s1 = s.Substring(begin, length);
               var s2 = s1.Substring(0, s1.IndexOf(".", StringComparison.Ordinal) + 3);
               Console.WriteLine($"s2: '{s2}'");
             */
            var d = double.Parse(s);

            var d1 = d % 1;
            if (d1 > 0)
                return false;
            return true;
        }

        private static void RandomBytes()
        {
            var ticks = (int)DateTime.Now.Ticks;

            var bytes = new byte[1];
            var random = new Random(ticks);
            random.NextBytes(bytes);
            Console.WriteLine("ticks : " + ticks);
            Console.WriteLine("1: bytes[0] : " + bytes[0]);
            random.NextBytes(bytes);
            Console.WriteLine("2: bytes[0] : " + bytes[0]);
            ticks = (int)DateTime.Now.Ticks;
            random = new Random(ticks);
            random.NextBytes(bytes);
            Console.WriteLine("ticks : " + ticks);
            Console.WriteLine("3: bytes[0] : " + bytes[0]);
            random.NextBytes(bytes);
            Console.WriteLine("4: bytes[0] : " + bytes[0]);
        }

        #endregion //old

    }
}
