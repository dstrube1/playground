using System;
using System.Collections;
using System.IO;

namespace CrawlingLogFileMover
{
    class Program
    {
        static void Main(string[] args)
        {
            int beginDate = 20130801;
            int endDate = getEndDate(); //20130925; // 
            string fromPath = @"C:\logs\crawling\";
            string toPath = @"E:\crawlingLogArchive\";

            if (args.Length > 0)
            {
                if (args[0].Contains("?") || args[0].ToLower().Contains("help"))
                {
                    Console.WriteLine("Usage: CrawlingLogFileMover [beginDate [endDate [fromPath [toPath]]]]");
                    Console.WriteLine("Date format: YYYYMMDD");
                    Console.WriteLine(@"For example: CrawlingLogFileMover 20130901 20130927 C:\logs\crawlingNew\ E:\crawlingLogArchiveNew\");
                    Console.WriteLine("Defaults:\n beginDate=" + beginDate + ";\n endDate:" + endDate + ";\n fromPath=" + fromPath + ";\n toPath=" + toPath);
                    return;
                }
                beginDate = Int32.Parse(args[0]);
            }
            if (args.Length > 1)
            {
                endDate = Int32.Parse(args[1]);
            }
            if (args.Length > 2)
            {
                fromPath = args[2];
            }
            if (args.Length > 3)
            {
                toPath = args[3];
            }
            Console.WriteLine("Moving files " + beginDate + " - " + endDate);
            Console.WriteLine("Hit enter to continue.");
            Console.ReadLine();
            
            doStuff(fromPath, toPath, beginDate, endDate);
            
            //Console.WriteLine("beginDate: "+beginDate);
            //Console.WriteLine("endDate: " + endDate);
            Console.WriteLine("Hit enter to exit.");
            Console.ReadLine();
        }

        private static void doStuff(string inPath, string outPath, int beginDate, int endDate)
        {
            const string path = @"C:\logs\crawling\";
            if (inPath == null || inPath.Equals(""))
            {
                inPath = path;
            }
            if (!Directory.Exists(inPath))
            {
                Console.WriteLine("Not exists: " + inPath);
                //Console.WriteLine("Hit enter to exit.");
                //Console.ReadLine();
                return;
            }
            string[] filesArray = Directory.GetFiles(inPath);
            ArrayList files = new ArrayList(filesArray);

            int begin = (beginDate != 0 ? beginDate : 20130801);
            int end = (endDate != 0 ? endDate : 20130829);

            for (int j = begin; j <= end; j++)
            {
                for (int i = 0; i <= 19; i++)
                {
                    string fileLookingFor = "si_crawl" + i + ".log" + j;
                    //Console.WriteLine("Looking for " + fileLookingFor);
                    //Console.WriteLine("Hit enter to continue.");
                    //Console.ReadLine();
                    int count = 0;
                    foreach (string file in files)
                    {
                        if (count < 30)
                        {
                            count++;
                            //Console.WriteLine("Checking " + file);
                        }
                        if (file.Contains(fileLookingFor))
                        {
                            string fileTo = (outPath == null || outPath.Equals("")) ? @"E:\crawlingLogArchive\" : outPath;

                            Console.WriteLine("Move file: " + file);
                            fileTo += j;
                            Console.WriteLine(" to " + fileTo);
                            if (!Directory.Exists(fileTo))
                            {
                                Directory.CreateDirectory(fileTo);
                            }
                            string fileName = file.Substring(file.LastIndexOf("\\"));
                            if (File.Exists(fileTo + "\\" + fileName))
                            {
                                Console.WriteLine("File already exists at " + fileTo + "\\" + fileName);
                                Console.WriteLine("You deal with this. I'm skipping it...");
                            }
                            else
                            {
                                File.Move(file, fileTo + "\\" + fileName);
                            }
                        }
                    }
                }
            }
        }

        private static int getEndDate()
        {
            DateTime date = DateTime.Now;
            //Console.WriteLine(date.ToShortDateString());
            TimeSpan span = new TimeSpan(7, 0, 0, 0);
            date = date.Subtract(span);
            //Console.WriteLine(date.ToShortDateString());

            //this works great if your computer is smart enough to put dates in YYYY-MM-DD format; but not all computers are that smart
            //string dateString = date.ToShortDateString().Replace("-", "");
            //Console.WriteLine("dateString: " + dateString);
            //Console.WriteLine("Hit enter to continue.");
            //Console.ReadLine();

            int year = date.Year;
            int month = date.Month;
            int day = date.Day;
            string dateString = year.ToString();
            dateString += (month > 9) ? month.ToString() : "0" + month.ToString();
            dateString += (day > 9) ? day.ToString() : "0" + day.ToString();

            return Int32.Parse(dateString);
        }
    }
}
