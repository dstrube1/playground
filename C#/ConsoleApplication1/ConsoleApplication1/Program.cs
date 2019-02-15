using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

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

        #region old

        #region Before main
        //////////////////////////////////////////////////////////////////////////////////////////////
        private static EventClass evRaise = null;

        public enum TestEnum
        {
            C, D
        }

        //[Obsolete("blah", true)]
        //static void old(){}


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

        #endregion

        #region From within main

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

        #region refTests
        //int i = 1;
        //Int32 i2 = 2;
        //String s3 = "3";
        //String s4 = "4";
        //refTest(ref i, i2, ref s3, s4);//i2 and s4 are objects, but not passed in by reference, so not affected
        //Console.WriteLine($"i: {i}, i2: {i2}, s3: {s3}, s4: {s4}");
        //    var myObject = new MyObject
        //    {
        //        i = 1,
        //        s = "2"
        //    };
        //refTest0(myObject);//automatically passed in by reference
        //Console.WriteLine($"myObject.i: {myObject.i}; myObject.s: {myObject.s}");
        //    refTest1(ref myObject); //same as passing in without reference; no error or warning
        //Console.WriteLine($"myObject.i: {myObject.i}; myObject.s: {myObject.s}");

        #endregion


        #region async task 1

        //https://blogs.msdn.microsoft.com/pfxteam/2012/02/08/potential-pitfalls-to-avoid-when-passing-around-async-lambdas/
        //const int iterations = 5;
        //Console.WriteLine("After " + iterations + " iterations...");
        //    double secs = Time(() =>
        //    {
        //        Thread.Sleep(1000);
        //    }, iterations);
        //Console.WriteLine("Average Seconds: {0:F7}", secs);

        //    Console.WriteLine("With async (default iterations, " + defaultIterations + "), done incorrectly...");
        //    secs = Time(async () =>
        //    {
        //    await Task.Delay(1000);
        //});
        //    Console.WriteLine("Average Seconds: {0:F7}", secs);
        //    Console.WriteLine("With async (iterations = " + iterations + "), done correctly...");
        //    secs = Time1(async () =>
        //    {
        //    await Task.Delay(1000);
        //}, iterations);
        //Console.WriteLine("Average Seconds: {0:F7}", secs);

        //Console.WriteLine("Done");

        #endregion async task 1

        #region Misc

        //Console.WriteLine(AddN("1", "Two"));

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

        //int a = 1, b = 2;
        //if (++a == 1)
        //  Console.WriteLine("x");
        //else
        //  Console.WriteLine(a-- * b); //4

        //foo();//[year]
        //object x = "x";//object
        //foo(x);
        //dynamic y = "y";//string
        //foo(y);

        /*
        try
        {
            Console.WriteLine(MyClass.MyMethod());
        }
        catch (Exception e)
        {
            Console.WriteLine(e.GetType()); //TypeInitializationException
        }


        */

        /*

        try
        {
            object[] array = new String[10];
            array[0] = 10; //runtime: ArrayTypeMismatchException
        }
        catch(Exception e)
        {
            Console.WriteLine(e.GetType());
        }

        */

        #endregion

        #endregion

        #region everything else

        static void outTest()
        {

            int a = 0;
            int b = 0;
            Console.WriteLine("a = {0}, b = {1}", a, b);
            twoReturns(out a, out b);
            Console.WriteLine("a = {0}, b = {1}", a, b);
        }

        static void twoReturns(out int A, out int B)
        {
            A = 1;
            B = 2;
        }

        static void methodBaseTest() 
        {
            var method = MethodBase.GetCurrentMethod();
            Console.WriteLine($"method name: {method.Name}");
            Console.WriteLine($"method parameters: ");
            var parameters = method.GetParameters();
            foreach (var param in parameters)
            {
                Console.WriteLine(param.ParameterType + " " + param.Name);
            }
        }

        static String AddN(String f, String s)
        {
            int sI = 0;
            try
            {
                return Int32.TryParse(f, out sI).ToString(); // return of TryParse is a bool; output: True
            }
            catch (Exception e)
            {
                Console.WriteLine("E:+ " + e);
            }
            return sI.ToString();
        }


        #region foos

        static void foo(string s) { Console.WriteLine("string"); }
        static void foo(object o) { Console.WriteLine("object"); }
        static void foo(int i = 0)
        {
            if (i == 0)
                Console.WriteLine(DateTime.Now.Year);
            else Console.WriteLine(i);
        }

        #endregion

        #region testEnum
        static void testEnum()
        {
            Console.WriteLine("Testing enum parsing");
            string enumTest = "C";
            TestEnum m;
            if (!Enum.TryParse(enumTest, out m))
            {
                Console.WriteLine("enum not set; error while parsing");
            }
            else
            {
                Console.WriteLine("enum parsed: " + m);
            }
        }
        #endregion testEnum

        #region refTests

        static void refTest(ref int i, Int32 i2, ref String s3, String s4)
        {
            i = 100;
            i2 = 200;
            s3 = "300";
            s4 = "400";
        }

        static void refTest0(MyObject myObject)
        {
            myObject.i = 100;
            myObject.s = "200";
        }

        static void refTest1(ref MyObject myObject)
        {
            myObject.i = 200;
            myObject.s = "300";
        }

        #endregion

        #region Convert
        static void testConvert()
        {
            Console.WriteLine();
            Console.WriteLine("Testing convert. Enter a couple numbers: ");
            string line = Console.ReadLine();
            if (line != null)
            {
                handleLine(line);
            }
            else
            {
                Console.WriteLine("line is null");
                line = "1 2";
                handleLine(line);
            }
        }

        static void handleLine(string line)
        {
            int x = Convert.ToInt32(line.Substring(0, line.IndexOf(" ")));
            line = line.Substring(line.IndexOf(" ") + 1);
            int y = Convert.ToInt32(line);
            Console.WriteLine("x: {0}, y: {1}", x, y);
        }
        #endregion Convert

        #region testLock
        static void testLock()
        {
            Console.WriteLine();
            Console.WriteLine("Testing LockTest where locker is null...");
            try
            {
                LockTest();
            }
            catch (ArgumentNullException)
            {
                Console.WriteLine("Caught ArgumentNullException");
            }
            locker = new object();
            Console.WriteLine("Testing LockTest where locker is not null...");
            LockTest();
        }

        static object locker;
        static bool w = false;
        static void LockTest()
        {
            lock (locker)
            {
                if (!w)
                {
                    Console.WriteLine("LockTest done");
                    w = true;
                }
            }
        }
        #endregion testLock

        #region async task

        static void testAsyncTask()
        {
            Task.Run(async () => await Download());
            Console.WriteLine();
            Console.WriteLine("Testing async task");
            //Task t = Download();
            //t.Start(); //InvalidOperationException: 
            //Start may not be called on a promise-style task

            //Download(); //If method signature is static async Task Download() :
            //Warning: Because this call is not awaited,
            //execution of the current method continues before the call is completed. 
            //Consider applying the 'await' operator to the result of the call

            //This hides the warning:
            //var result = Download();

        }

        //[MethodImpl(MethodImplOptions.Synchronized)]
        static async Task Download()
        { //if return type is void:
          //Asynchronous method should not return void
            Console.WriteLine(await GetUrlContents("http://www.google.com"));
        }

        static async Task<string> GetUrlContents(string url)
        {
            try
            {
                var wc = new WebClient();
                string contents = await wc.DownloadStringTaskAsync(url);
                return contents;
            }
            catch (Exception e)
            {
                Console.WriteLine("Caught exception: " + e.Message);
                throw;
            }
        }

        #endregion async task

        #region async task 1
        const int defaultIterations = 10;

        //This works without async; doesn't work with async
        public static double Time(Action action, int iters = defaultIterations)
        {
            var sw = Stopwatch.StartNew();
            for (int i = 0; i < iters; i++)
            {
                Console.Write(".");
                action();
            }
            return sw.Elapsed.TotalSeconds / iters;
        }

        //This works with async
        public static double Time1(Func<Task> func, int iters = defaultIterations)
        {
            var sw = Stopwatch.StartNew();
            for (int i = 0; i < iters; i++)
            {
                Console.Write(".");
                func().Wait();
            }
            return sw.Elapsed.TotalSeconds / iters;
        }
        #endregion async task 1

        #region TextAdder
        /*
        static void testTextAdder()
        {
            Console.WriteLine();
            Console.WriteLine("Testing text adder");
            try
            {
                StringBuilder sb1 = new StringBuilder("x");
                StringBuilder sb2 = new TextAdder().addText(sb1);
                Console.WriteLine("sb2: " + sb2); //xy, as expected
                Console.WriteLine("sb1: " + sb1); //xy - wth?
            }
            catch (Exception e)
            {
                Console.WriteLine("exception: " + e.GetType());
            }
        }

        //see also class TextAdder below
        */
        #endregion TextAdder

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
                Console.WriteLine("\nMax of int found: " + count);//2147483647
            }
            else
            {
                Console.WriteLine("Authoritative max of int : " + int.MaxValue);//2147483647
                int candidate = getIntMaxEstimate();
                int addend = getIntMaxEstimate();
                intMaxRecursiveAdd(candidate, addend);
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

        private static void LongMax()
        {
            Console.WriteLine("Authoritative max of long: " + long.MaxValue);   //9223372036854775807
            long candidate = getLongMaxEstimate();
            long addend = getLongMaxEstimate();
            longMaxRecursiveAdd(candidate, addend);                             //9223372036854775807
        }

        private static bool longMaxRecursiveAdd(long candidate, long addend)
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
                    long ltemp = candidate;
                    while (ltemp > 0)
                    {
                        candidate = ltemp;
                        ltemp++;
                    }
                    Console.WriteLine("long max found: " + candidate);
                    return true;
                }
            }
            long sum = candidate + addend;
            if (sum > 0)
            {
                return longMaxRecursiveAdd(sum, addend);
            }
            else
            {
                //Console.WriteLine(candidate + " + " + addend + " is too much; trying " + candidate + " + " + (addend / 2));
                return longMaxRecursiveAdd(candidate, addend / 2);
            }
        }

        private static long getLongMaxEstimate()
        {
            long myLong = 1;
            long LTemp = myLong;
            while (LTemp > 0)
            { //when LTemp exceeds the maximum, it loops around to a negative
                myLong = LTemp;
                LTemp *= 10;
                //Console.WriteLine("long max guess = " + myLong);
            }
            return myLong;
        }

        private static void FloatMax()
        {
            Console.WriteLine("Authoritative max of float: " + float.MaxValue);   //3.402823E+38
            float candidate = getFloatMaxEstimate();
            float addend = getFloatMaxEstimate();
            floatMaxRecursiveAdd(candidate, addend);                             //3.402823E+38
        }

        private static bool floatMaxRecursiveAdd(float candidate, float addend)
        {
            //This is not as clean as it is in C++ or Java. There is probably a better way, but this seems to be good enough for now
            if (addend < 1.0f)
            {
                //Console.WriteLine("addend is 1.0");
                if (candidate < 0)
                {
                    Console.WriteLine("something went wrong; candidate is " + candidate);
                    return false;
                }
                else
                {
                    //float ftemp = candidate;
                    //while (ftemp > 0)
                    //{
                    //    candidate = ftemp;
                    //    ftemp++;
                    //}
                    Console.WriteLine("float max found: " + candidate);
                    return true;
                }
            }
            else
            {
                //Console.WriteLine($"addend = {addend}");
            }

            float sum = candidate + addend;
            if (!float.IsInfinity(sum) && !(sum - candidate).Equals(0))
            {
                //Console.WriteLine(candidate + " + " + addend + " is " + sum);
                return floatMaxRecursiveAdd(sum, addend);
            }
            else
            {
                //Console.WriteLine($"sum - candidate = {sum} - {candidate} = {sum - candidate}");
                //Console.WriteLine(candidate + " + " + addend + " is too much; trying " + candidate + " + " + (addend / 2));
                return floatMaxRecursiveAdd(candidate, addend / 2);
            }
        }

        private static float getFloatMaxEstimate()
        {
            float myFloat = 1;
            float fTemp = myFloat;
            while (!float.IsInfinity(fTemp)) //interesting that IsPositiveInfinity didn't catch before a stackoverflow, but IsInfinity did
            { //when fTemp exceeds the maximum, it loops around to a negative
                myFloat = fTemp;
                fTemp *= 10;
                //Console.WriteLine("float max guess = " + myFloat);
            }
            return myFloat;
        }

        private static void DoubleMax()
        {
            Console.WriteLine("Authoritative max of double: " + double.MaxValue); // 1.79769313486232E+308
            double candidate = getDoubleMaxEstimate();
            double addend = getDoubleMaxEstimate();
            doubleMaxRecursiveAdd(candidate, addend);                            // 1.79769313486232E+308
        }

        private static bool doubleMaxRecursiveAdd(double candidate, double addend)
        {
            if (addend < 1.0f)
            {
                //Console.WriteLine("addend is 1.0");
                if (candidate < 0)
                {
                    Console.WriteLine("something went wrong; candidate is " + candidate);
                    return false;
                }
                else
                {
                    //double dtemp = candidate;
                    //while (dtemp > 0)
                    //{
                    //    candidate = dtemp;
                    //    dtemp++;
                    //}
                    Console.WriteLine("double max found: " + candidate);
                    return true;
                }
            }
            else
            {
                //Console.WriteLine($"addend = {addend}");
            }

            double sum = candidate + addend;
            if (!double.IsInfinity(sum) && !(sum - candidate).Equals(0))
            {
                //Console.WriteLine(candidate + " + " + addend + " is " + sum);
                return doubleMaxRecursiveAdd(sum, addend);
            }
            else
            {
                //Console.WriteLine($"sum - candidate = {sum} - {candidate} = {sum - candidate}");
                //Console.WriteLine(candidate + " + " + addend + " is too much; trying " + candidate + " + " + (addend / 2));
                return doubleMaxRecursiveAdd(candidate, addend / 2);
            }
        }

        private static double getDoubleMaxEstimate()
        {
            double myDouble = 1;
            double dTemp = myDouble;
            while (!double.IsInfinity(dTemp))
            {
                myDouble = dTemp;
                dTemp *= 10;
                //Console.WriteLine("double max guess = " + myDouble);
            }
            return myDouble;
        }

        private static void DecimalMax()
        {
            Console.WriteLine("Authoritative max of decimal: " + decimal.MaxValue); //79228162514264337593543950335
            decimal candidate = getDecimalMaxEstimate();                            //1000000000000000000000000000
            decimal addend = getDecimalMaxEstimate();
            decimalMaxRecursiveAdd(candidate, addend);                              //79228162514264337593543950335
        }

        private static bool decimalMaxRecursiveAdd(decimal candidate, decimal addend)
        {
            decimal sum;
            try
            {
                sum = candidate + addend;
                if (sum == candidate)
                {
                    Console.WriteLine($"Found decimal max: {sum}");
                    return true;
                }
                //Console.WriteLine($"sum is not too big: {sum}");
                return decimalMaxRecursiveAdd(sum, addend);
            }
            catch (OverflowException)
            {
                //Console.WriteLine($"sum is too big; trying with addend {addend/2}");
                return decimalMaxRecursiveAdd(candidate, addend / 2);
            }
        }

        private static decimal getDecimalMaxEstimate()
        {
            decimal myDecimal = 1;

            decimal dTemp = myDecimal;
            try
            {
                while (true)
                {
                    myDecimal = dTemp;
                    dTemp *= 10;
                    //Console.WriteLine("decimal max guess = " + myDecimal);
                }
            }
            catch (OverflowException) { }
            return myDecimal;
        }

        #endregion

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

        #endregion

        #endregion //old

    }

/*    class TextAdder
    {
        public StringBuilder addText(StringBuilder input)
        {
            input.Append("y");
            StringBuilder result = new StringBuilder(input.ToString());
            input = null;
            return result;
        }
    }*/
    /*static class MyClass
    {
        static MyClass()
        {
            throw new Exception();
        }

        public static string MyMethod()
        {
            return "My Method";
        }
    }*/
}
