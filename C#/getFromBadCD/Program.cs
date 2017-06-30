using System;
using System.IO;

namespace getFromBadCD
{
    class Program
    {
        private const bool debug = true;
        static void Main(string[] args)
        {
            if (debug)
                Console.WriteLine("Starting...");
            try
            {

                string pathFrom = @"D:\Support";

                string pathTo = @"C:\Documents and Settings\david.strube\Desktop\temp\burn\PB10\Support\temp";
                //Verify all directories are valid before running this.
                if (!Directory.Exists(pathFrom))
                    Console.WriteLine("Path from doesn't exist");
                else if (!Directory.Exists(pathTo))
                    Console.WriteLine("Path to doesn't exist");
                else
                    dostuffForeachDir(pathFrom, pathTo);


                if (debug)
                {
                    Console.WriteLine("done");
                    Console.ReadLine();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Caught Error :" + e.Message);
                Console.ReadLine();
            }
        }

        static void dostuffForeachDir(string pathFrom, string pathTo)
        {
            string folder = "";
            string file = "";
            foreach (string s in Directory.GetFiles(pathFrom))
            {
                file = s.Substring(1 + s.LastIndexOf("\\"));
                try
                {
                    if (debug)
                        Console.WriteLine("Copying from " + s + " \nto " + pathTo + file);
                    else
                        File.Copy(s, pathTo + file, true);
                }
                catch (Exception e)
                {
                    Console.WriteLine("Caught Error at " + pathFrom + file + " : " + e.Message);
                }
            }
            foreach (string t in Directory.GetDirectories(pathFrom))
            {
                folder = t.Substring(1 + t.LastIndexOf("\\"));

                if (debug)
                    Console.WriteLine("CREATING dir " + pathTo + folder);
                else
                    Directory.CreateDirectory(pathTo + folder);
                    
                    dostuffForeachDir(t, pathTo + "\\" + folder+ "\\");                
            }
        }
    }
}
