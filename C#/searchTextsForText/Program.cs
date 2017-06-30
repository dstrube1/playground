using System;
//using System.Collections.Generic;
//using System.Text;
using System.IO;

namespace searchTextsForText
{
    class Program
    {
        private string[] files;
        private const string path = @"C:\david\music\";

        static void Main(string[] args)
        {
            Program p = new Program();
            p.doStuff();
            Console.ReadLine();
        }

        private void doStuff()
        {
            files = new string[5] { "1 - rock.txt", "2 - and.txt", "3 - roll.txt", 
                "4 - hoochie.txt", "5 - coo.txt" };
            string compare = "out.txt";
            string[] comparelines = File.ReadAllLines
                                (path + compare);

            foreach (string file in files) {
                Console.WriteLine("Reading "+path+file);
                try {
                    string[] lines = File.ReadAllLines(path + file);
                    foreach (string line in lines) {
                        if (line.EndsWith(".mp3")) {
                            foreach (string compareline in comparelines) {
                                if (compareline.EndsWith(".mp3")) {
                                    if (line.Contains(compareline)) {
                                        Console.WriteLine
                                            (file + " contains " + compareline);
                                    }
                                }
                            }
                        }
                    }
                }
                catch (Exception e) { 
                    Console.WriteLine("Error: "+e.ToString());
                }
            }
        }
    }
}
