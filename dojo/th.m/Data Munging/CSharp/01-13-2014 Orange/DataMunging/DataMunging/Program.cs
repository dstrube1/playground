using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace DataMunging
{
    class Program
    {
        private static Regex dataDivider;

        static void Main(string[] args)
        {
            dataDivider = new Regex("([ ]*?)");

            Console.WriteLine("Executing original methods...");

            Weather();
            Football();

            Console.WriteLine("");
            Console.WriteLine("Executing common method...");

            LowestSpread("weather.dat", 0, 1, 2, "1", "30");
            LowestSpread("football.dat", 1, 6, 8, "1.", "20.");

            Console.ReadLine();
        }

        static void LowestSpread(string filename, int nameIndex, int subtractFromIndex, int subtractIndex, string firstDataLineToken , string lastDataLineToken)
        {
            Console.WriteLine("Scanning " + filename + "...");

            string line;
            bool onDataLines = false;
            System.IO.StreamReader file = new System.IO.StreamReader(filename);

            int smallestSpread = 99;
            string smallestSpreadName = "";

            while ((line = file.ReadLine()) != null)
            {
                line = line.Trim();

                if (line.Length < 1) continue;

                // Skip dashed-through lines
                if (line.Substring(0, 2) == "--") continue;

                if (!onDataLines)
                {
                    if (line.Substring(0, firstDataLineToken.Length) == firstDataLineToken)
                    {
                        onDataLines = true;
                    }
                }

                if (onDataLines)
                {
                    if (line.Substring(0, lastDataLineToken.Length) == lastDataLineToken)
                    {
                        onDataLines = false;
                    }

                    var linePieces = Regex.Split(line, @"\s+").Where(s => s != string.Empty).ToArray();

                    linePieces[subtractFromIndex] = linePieces[subtractFromIndex].Replace("*", "");
                    linePieces[subtractIndex] = linePieces[subtractIndex].Replace("*", "");

                    var spread = Int32.Parse(linePieces[subtractFromIndex]) - Int32.Parse(linePieces[subtractIndex]);

                    if (spread < smallestSpread)
                    {
                        smallestSpread = spread;
                        smallestSpreadName = linePieces[nameIndex];
                    }

                }
            }

            Console.WriteLine(smallestSpreadName + " had the lowest spread with " + smallestSpread);
        }

        static void Football()
        {
            Console.WriteLine("Scanning football.dat...");

            string line;
            bool onDataLines = false;
            System.IO.StreamReader file = new System.IO.StreamReader("football.dat");

            int smallestSpread = 99;
            string smallestSpreadTeam = "";

            while ((line = file.ReadLine()) != null)
            {
                line = line.Trim();

                if (line.Length < 1) continue;

                // Skip dashed-through lines
                if (line.Substring(0, 2) == "--") continue;

                if (!onDataLines)
                {
                    if (line.Substring(0, 2) == "1.")
                    {
                        onDataLines = true;
                    }
                }
                
                if(onDataLines)
                {
                    if (line.Substring(0, 3) == "20.")
                    {
                        onDataLines = false;
                    }
                    
                    var linePieces = Regex.Split(line, @"\s+").Where(s => s != string.Empty).ToArray();

                    var spread = Int32.Parse(linePieces[6]) - Int32.Parse(linePieces[8]);

                    if (spread < smallestSpread)
                    {
                        smallestSpread = spread;
                        smallestSpreadTeam = linePieces[1];
                    }
                    
                }
            }

            Console.WriteLine(smallestSpreadTeam + " had the lowest spread with " + smallestSpread);
        }


        static void Weather()
        {
            Console.WriteLine("Scanning weather.dat...");

            string line;
            bool onDataLines = false;
            System.IO.StreamReader file = new System.IO.StreamReader("weather.dat");

            int smallestSpread = 99;
            int smallestSpreadDay = 0;

            while ((line = file.ReadLine()) != null)
            {
                line = line.Trim();

                // Skip empty lines
                if (line.Length < 1) continue;

                if (!onDataLines)
                {
                    if (line.Substring(0, 1) == "1")
                    {
                        onDataLines = true;
                    }
                }
                
                if(onDataLines)
                {
                    if (line.Substring(0, 2) == "mo")
                    {
                        onDataLines = false;
                    }
                    else
                    {
                        var linePieces = Regex.Split(line, @"\s+").Where(s => s != string.Empty).ToArray();

                        linePieces[1] = linePieces[1].Replace("*", "");
                        linePieces[2] = linePieces[2].Replace("*", "");

                        var spread = Int32.Parse(linePieces[1]) - Int32.Parse(linePieces[2]);

                        //Console.WriteLine("Day " + linePieces[0] + ": " + spread);

                        if (spread < smallestSpread)
                        {
                            smallestSpread = spread;
                            smallestSpreadDay = Int32.Parse(linePieces[0]);
                        }
                    }
                }
            }

            Console.WriteLine("Day " + smallestSpreadDay + " had the lowest spread: " + smallestSpread);
        }
    }
}
