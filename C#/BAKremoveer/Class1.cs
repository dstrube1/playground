using System;
using System.IO;

namespace BAKremoveer
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class Class1
	{
		public string dir = @"C:\temp\";//@"D:\jmj\pmshare\bills\";
		public string ext = ".bak";
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			string file1, file2;
			while (isFileWithBak()){
				file1 = getFileWithBak();
				file2 = file1.Substring(0,file1.IndexOf(ext));
				File.Move(file1, file2);
			}

		}

		static bool isFileWithBak(){
			string [] files = Directory.GetFiles(dir, "*"+ext);
			bool answer=false;
			if (files.Length > 0)
				answer=true;
		return answer;
		}

		static string getFileWithBak(){
			string [] files = Directory.GetFiles(dir, "*"+ext);
			return files[0];
		}

	}
}
