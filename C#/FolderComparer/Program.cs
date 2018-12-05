using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;

namespace FolderComparer
{
    public class Program
    {
        static void Main(string[] args)
        {
            #region Driver

            //const string path2 = @"C:\git\E-BW-dstrube-x\Mobile";
            //const string path1 = @"C:\git\E-BW-dstrube-w\Mobile";

            //if (!phase1(path1, path2))
            //{
            //    Console.WriteLine("Phase 1 failed");
            //    Console.ReadLine();
            //    return;
            //}

            //Console.WriteLine("Phase 1 passed. Moving on to phase 2...");

            //if (!phase2(path1, path2))
            //{
            //    Console.WriteLine("Phase 2 failed");
            //    Console.ReadLine();
            //    return;
            //}

            //Console.WriteLine("Phase 2 passed. ");

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

            linqXample();

            Console.WriteLine("Done");

            Console.ReadLine();
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
                    break;
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

        private static bool BaseChecks(string path1, string path2)
        {
            if (string.IsNullOrEmpty(path1))
            {
                Console.WriteLine("Null or empty path 1");
                return false;
            }

            if (string.IsNullOrEmpty(path2))
            {
                Console.WriteLine("Null or empty path 2");
                return false;
            }
            //if (!File.Exists(path1))
            //{
            //    Console.WriteLine("Path 1 not exists: " + path1);
            //    return false;
            //}
            //if (!File.Exists(path2))
            //{
            //    Console.WriteLine("Path 2 not exists: " + path2);
            //    return false;
            //}

            string[] dirs1;
            string[] dirs2;
            try
            {
                dirs1 = Directory.GetDirectories(path1);
            }
            catch (DirectoryNotFoundException)
            {
                Console.WriteLine("Directory not found: \n" + path1 );
                return false;
            }
            try
            {
                dirs2 = Directory.GetDirectories(path2);
            }
            catch (DirectoryNotFoundException)
            {
                Console.WriteLine("Directory not found: \n" + path2);
                return false;
            }
            if (dirs1.Length != dirs2.Length)
            {
                Console.WriteLine("Count of dirs in path 1 ("+ dirs1.Length + ") != path 2 ("+ dirs2.Length + "): \n" + path1 + "; \n" + path2);
                return false;
            }

            var files1 = Directory.GetFiles(path1);
            var files2 = Directory.GetFiles(path2);
            if (files1.Length != files2.Length)
            {
                Console.WriteLine("Count of files in path 1 (" + files1.Length + ") != path 2 (" + files2.Length + "): \n" + path1 + "; \n" + path2);
                //return false;
            }

            return true;
        }

        private static bool Phase1(string path1, string path2)
        {
            if (!BaseChecks(path1, path2))
            {
                Console.WriteLine("Failed phase 1 : \n" + path1 + "; \n" + path2);
                return false;
            }

            var dirs1 = Directory.GetDirectories(path1);
            var dirs2 = Directory.GetDirectories(path2);
            for (var i = 0; i < dirs1.Length; i++)
            {
                if (!Phase1(dirs1[i], dirs2[i]))
                {
                    Console.WriteLine("Failed recursion of phase 1 : \n" + path1 + "; \n" + path2);
                    return false;
                }
            }
            return true;
        }

        private static bool Phase2(string path1, string path2)
        {
            var dirs1 = Directory.GetDirectories(path1);
            var dirs2 = Directory.GetDirectories(path2);
            for (var i = 0; i < dirs1.Length; i++)
            {
                if (!Phase2(dirs1[i], dirs2[i]))
                {
                    Console.WriteLine("Failed recursion of phase 1 : \n" + path1 + "; \n" + path2);
                    return false;
                }
            }

            var files1 = Directory.GetFiles(path1);
            var files2 = Directory.GetFiles(path2);
            for(var i = 0; i < files1.Length && i < files2.Length; i++)
            {
                var iFor1 = i;
                try
                {
                    var fileName1 = files1[i].Substring(files1[i].LastIndexOf("\\", StringComparison.CurrentCulture));
                    var fileName2 = files2[i].Substring(files2[i].LastIndexOf("\\", StringComparison.CurrentCulture));
                    while (!fileName1.Equals(fileName2) && iFor1 < files1.Length)
                    {
                        iFor1++;
                        fileName1 = files1[iFor1].Substring(files1[iFor1].LastIndexOf("\\", StringComparison.CurrentCulture));
                    }

                    if (iFor1 == files1.Length)
                    {
                        Console.WriteLine("Couldn't find fileName2: \n" + fileName2);
                        return false;
                    }

                    var content1 = File.ReadAllText(files1[iFor1]);
                    var content2 = File.ReadAllText(files2[i]);

                    if (!content1.Equals(content2))
                    {
                        Console.WriteLine("Content of file 1 != file 2: \n" + fileName1 );
                        //This is fine. Continue on to the next files
                        //return false;
                    }
                }
                catch (IOException exception)
                {
                    Console.WriteLine("Caught IOException: " + exception.Message);
                    return false;

                }
            }

            return true;
        }
    }
}
