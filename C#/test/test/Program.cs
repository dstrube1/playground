using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

//using System.Collections;

namespace test
{
    class Program
    {
        
        static void Main(string[] args)
        {
            //Console.WriteLine("beginDate: "+beginDate);
            //Console.WriteLine("endDate: " + endDate);
            Console.WriteLine("Hit enter to exit.");
            Console.ReadLine();

        }

        private static void moveAllOneUp()
        {
            string inPath = @"E:\crawlingLogArchive\";

            string[] foldersArray = Directory.GetDirectories(inPath);
            ArrayList folders = new ArrayList(foldersArray);
            foreach (string folder in folders)
            {
                string[] filesArray = Directory.GetFiles(folder);
                ArrayList files = new ArrayList(filesArray);
                foreach (string file in files)
                {
                    string fileName = file.Substring(file.LastIndexOf("\\"));
                    string fileTo = inPath + "\\" + fileName;
                    Console.WriteLine("Moving " + fileTo + " up one...");
                    File.Move(file, fileTo);
                    //Console.WriteLine("Look good? If so, hit enter to proceed");
                    //Console.ReadLine();
                }
            }

        }
        private static void TenPerLine()
        {
            //from main:             TenPerLine();

            // http://jira.dentsunetwork.com/browse/SIOPS-9392
            const string inPath = @"C:\Users\david.strube\Desktop\temp\in.txt";
            const string outPath = @"C:\Users\david.strube\Desktop\temp\out.txt";
            string[] content = File.ReadAllLines(inPath);
            //string output = "";
            int lineCount = 0;
            string outputLine = "";
            ArrayList list = new ArrayList();
            foreach (string line in content)
            {
                if (!line.Contains(","))
                {
                    if (line.Contains(")"))
                    {
                        list.Add(outputLine + line);
                    }
                    else
                    {
                        list.Add(line);
                    }
                    //output += line + "\n";

                }
                else
                {
                    if (lineCount >= 10)
                    {
                        lineCount = 1;
                        //output += outputLine + "\n";
                        list.Add(outputLine);
                        outputLine = line;
                    }
                    else
                    {
                        outputLine += line;
                        lineCount++;
                    }
                }
            }
            //Console.WriteLine("Hit enter for output.");
            //Console.ReadLine();
            //Console.WriteLine(output);
            //Console.WriteLine("Hit enter for outputLine. (and to write out to out.txt");
            //Console.ReadLine();
            //Console.WriteLine(outputLine);

            //File.WriteAllText(outPath, output + outputLine, Encoding.Unicode);
            File.WriteAllLines(outPath, (string[])list.ToArray(typeof(string)));
        }

        private static void PrintArray(string[] abcd)
        {
            //usage:
            //string[] abcd = { "a", "b", "c", "d" };

            //Console.Write("abcd: ");
            //PrintArray(abcd);
            //abcd = Popoff(abcd);
            //Console.Write("bcd?: ");
            //PrintArray(abcd);
            //Console.WriteLine("\nDone. Hit Enter to exit.");
            //Console.ReadLine();
            foreach (var s in abcd)
            {
                Console.Write(s + " ");
            }
            Console.WriteLine();
        }

        private static string[] Popoff(string[] args)
        {
            string content = "";
            foreach (string s in args)
            {
                content += s + " ";
            }
            Queue<string> myQueue = new Queue<string>(content.Split(new string[] { " " }, StringSplitOptions.None));
            myQueue.Dequeue();
            return myQueue.ToArray();
        }

        private static void Remove1From2()
        {
            const string path1 = @"C:\Users\david.strube\Desktop\temp\1.txt";
            const string path2 = @"C:\Users\david.strube\Desktop\temp\2.txt";
            
            const string path3 = @"C:\Users\david.strube\Desktop\temp\3.txt";
            
            File.WriteAllLines(path3,File.ReadAllLines(path2).Except(File.ReadAllLines(path1)));
        }

        private static void DateTimeTester()
        {
            try
            {
                DateTime now = DateTime.Now;
                Console.WriteLine("now = " + now);
                TimeSpan span = new TimeSpan(31, 0, 0, 0);
                now = now + span;
                Console.WriteLine("next month = " + now);

                span = new TimeSpan(3653, 0, 0, 0); //10 years
                DateTime lastDecade = DateTime.Now;
                lastDecade = lastDecade - span;
                Console.WriteLine("10 years ago = " + lastDecade);

                exceptionThrower();
            }
            catch (Exception)
            {
                Console.WriteLine("Hey look, we caught an exception and we don't have to do anything with it.");
            }
        }

        private static void exceptionThrower()
        {
            throw new NotImplementedException();
        }


        private static void Main_CryptoTest(string[] args)
        {
            //C:\repo\IgnitionOne\stable\middleware\source\SearchIgnite.Services\SearchIgnite.Services.Gateway\Wrapper\SecurityWrapper.cs
            //public UserBO AuthenticateUser(String userName, String password, string sessionGuid)
            //User user = UasmFacade.GetUser(userName, password, false);
            //->
            //C:\repo\IgnitionOne\stable\middleware\source\ADMP\SearchIgnite.UASM\Action\UserAction.cs
            //internal  User GetUser( String username , String password , Boolean includeUserClientRoleMap ) 
            //if (SymmCrypto.CreateHashCode(password) == user.EncryptedPassword)
            //->
            //C:\repo\IgnitionOne\stable\middleware\source\ADMP\SearchIgnite.Utility\Crypto\Crypto.cs
            //public static String CreateHashCode(String sInput)
            // :
            string input = "Password2";
            string encryptedPassword = "CcFkqRmrUkRWfO5zeK+kng==";

            if (CreateHashCode(input) == encryptedPassword)
            {
                System.Console.WriteLine("correct");
            }
            else
            {
                System.Console.WriteLine("incorrect");
            }
            System.Console.WriteLine("Hit enter to close.");
            System.Console.ReadLine();
        }

        private static String CreateHashCode(String sInput)
        {
            System.Text.UnicodeEncoding utf8 = new System.Text.UnicodeEncoding();
            Byte[] pBytes = utf8.GetBytes(sInput);
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            Byte[] oBytes = md5.ComputeHash(pBytes);
            md5 = null;
            return (System.Convert.ToBase64String(oBytes));
        }
    }
}
