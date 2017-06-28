using System;

namespace rot13
{
	class Class1
	{
		[STAThread]
		static void Main(string[] args)
		{
			string to = "nopqrstuvwxyzabcdefghijklm";
			string from = "abcdefghijklmnopqrstuvwxyz";

			while(true)
			{
				string temp = Console.ReadLine();
				if (temp == "")
					break;
				foreach (char c in temp)
				{
					int place = from.IndexOf(c);
					if (place !=-1)
						Console.Write(to[place]);
					else Console.Write(" ");
				}
				Console.WriteLine();
			}
			Console.WriteLine("Done.");
			Console.ReadLine();
		}
	}
}
