using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

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
