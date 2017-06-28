using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using System.Collections;

namespace test
{
    class PasswordEncrypter
    {
        private string _outputPath = @"C:\Users\david.strube\Desktop\temp\out.txt";
        private bool _includePasswordsInOutput = false;

        public void doStuff(string[] args)
        {
            if (args.Length > 0)
            {
                if (args[0] == "includePasswordsInOutput=true")
                {
                    _includePasswordsInOutput = true;
                }
                if (args.Length > 1)
                {
                    //we pop off the 0th arg; then the 1st arg should be the output, let any other arg(s) be input(s)
                    args = Popoff(args);
                    _outputPath = args[0];
                    args = Popoff(args);
                    if (args.Length > 0)
                    {

                        foreach (var arg in args)
                        {
                            //TODO: handle multiple output for multiple inputs; or put output from all inputs into one output
                            ProcessFile(arg);
                        }
                        return;
                    }
                }
            }
            const string inputPath = @"C:\Users\david.strube\Desktop\temp\in.txt";
            ProcessFile(inputPath);
            Console.WriteLine("\nDone. Hit Enter to exit.");
            Console.ReadLine();

        }

        private string[] Popoff(string[] args)
        {
            string content = "";
            foreach (string s in args)
            {
                content += s + " ";
            }
            //this is assuming / hoping no element in the original array contained spaces
            Queue<string> myQueue = new Queue<string>(content.Split(new string[] { " " }, StringSplitOptions.None));
            myQueue.Dequeue();
            return myQueue.ToArray();
        }

        private void ProcessFile(string arg)
        {
            Console.WriteLine("Processing file " + arg);
            if (!File.Exists(arg))
            {
                Console.WriteLine("File not exists: " + arg);
                return;
            }
            Console.WriteLine("Reading lines...");
            string[] dataIn = File.ReadAllLines(arg);
            ArrayList arrayList = new ArrayList();

            Console.WriteLine("Encrypting...");
            foreach (var line in dataIn)
            {
                arrayList.Add(EncryptPassword(line));
            }
            string[] dataOut = (string[])arrayList.ToArray(typeof(string));
            if (File.Exists(_outputPath))
            {
                Console.WriteLine(
                    "WARNING: File at output path already exists. Hit Enter to Overwrite. Press Ctrl+C to cancel.");
                Console.ReadLine();
            }
            Console.WriteLine("Writing encrypted passwords to " + _outputPath);
            File.WriteAllLines(_outputPath, dataOut);
        }

        private string EncryptPassword(string line)
        {
            System.Text.UnicodeEncoding utf8 = new System.Text.UnicodeEncoding();
            Byte[] pBytes = utf8.GetBytes(line);
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            Byte[] oBytes = md5.ComputeHash(pBytes);
            md5 = null;
            string output = "";
            if (_includePasswordsInOutput)
            {
                output = line + " = ";
            }
            output += System.Convert.ToBase64String(oBytes) + "\n";
            return (output);
        }

    }
}
