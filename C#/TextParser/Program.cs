using System;
using System.IO;
namespace TextParser
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			int lineNum = 0;
			string path = "/Users/dstrubex/Desktop/logs/7003-a.txt";
//			string[] lookFors = { "", "" };
			string lookFor = "com.intel.sed.sdk.sample.debug";
			string[] lines = File.ReadAllLines (path);
			foreach (string line in lines) {
				lineNum++;
//				foreach (string lookFor in lookFors) {
				if (line.Contains (lookFor) ) {
					String myLine = line.Substring (line.IndexOf (lookFor) + lookFor.Length);
					Console.WriteLine (myLine);
					}
//				}
			}
		}
	}
}
