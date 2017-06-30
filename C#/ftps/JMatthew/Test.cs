/*

File : Test.cs
Better view with tab space=4
use the following line to compile
C:\WINDOWS\Microsoft.NET\Framework\v1.1.4322\csc.exe /t:exe /r:System.DLL /r:FTPLib.dll /out:"Test.exe" "Test.cs"

*/
using System;
using FtpLib;

public class Test 
{

	public static void Main() 
	{
		bool debug = false;
		try 
		{

			if (debug) Console.WriteLine("Starting...");

			FTPFactory ff = new FTPFactory();
			if (debug) Console.WriteLine("Created the facotry");
			ff.setDebug(true);
			ff.setRemoteHost("ftp.jmjtech.com");
			ff.setRemoteUser(@"jmj\david.strube");
			ff.setRemotePass("");
			if (debug) Console.WriteLine("Set credentials");
			ff.login();
			if (debug) Console.WriteLine("logged in");
			ff.chdir("temp");
			if (debug) Console.WriteLine("changed dir");

			string[] fileNames = ff.getFileList("*.*");
			for(int i=0;i < fileNames.Length;i++) 
			{
				Console.WriteLine(fileNames[i]);
			}

			ff.setBinaryMode(true);
			ff.upload(@"c:\david\music\old\burned\perl.txt");
			if (debug) 
			{
				Console.WriteLine("Hit enter after you confirm the file was sent");
				Console.ReadLine();
			}

			ff.deleteRemoteFile("perl.txt");
			if (debug) 
			{
				Console.WriteLine("Hit enter after you confirm the file was deleted");
				Console.ReadLine();
			}

			ff.close();

		}
		catch(Exception e) 
		{
			Console.WriteLine("Caught Error :"+e.Message);
		}
	}
}