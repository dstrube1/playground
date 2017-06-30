using System;
using System.IO;
using System.Collections;
using System.Diagnostics;
using System.Threading;

namespace mp3Gluer
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class Class1
	{
		#region Global variables
		private static Thread loopThread = null;
		private const string convert_mp3_wav = "\"C:\\Program Files\\aumpel\\lame.exe\"";
		private const string convert_mp3_wav_arg =  " --decode -h \"";
		private const string convert_wav_mp3 = "\"C:\\Program Files\\aumpel\\lame.exe\"";
		private const string convert_wav_mp3_arg = " -b 56 -h \"";
		private const string final_mp3_name_prefix = "Gregory Maguire - Wicked (Unabridged) - ";
		private const string final_mp3_name_suffix = " of 16.mp3";
		private const string concat_command = "\"C:\\david\\music\\file manip\\sox12177\\sox.exe\"";
		//const bool createNoWindow=true;
		//for some reason, this doesnt work:
		//p1a.StartInfo.CreateNoWindow=createNoWindow;
		private const ProcessWindowStyle windowStyle = ProcessWindowStyle.Hidden;//Normal;
		private const string workingDir = @"C:\david\music\Gregory Maguire";
		//on startup each folder does not have to contain an mp3 but must contain at least one wav
		//private bool containsWav = false;
		//private static bool keepLooping = false;
		#endregion // Global variables

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
			///for each folder
			///	1	for each mp3 file: 
			///	1a		convert to wav; 
			///	ex: "C:\Program Files\aumpel\lame.exe" --decode -h "C:\david\music\Gregory Maguire\8\01-Track 01.mp3" "C:\david\music\Gregory Maguire\8\01-Track 01.wav"
			///	1b		delete the mp3; 
			///	ex delete C:\david\music\Gregory Maguire\8\01-Track 01.mp3
			///	
			///	2	concat the wavs to one wav based on folder name; 
			///	ex: C:\david\music\file manip\sox12177\sox.exe 1.wav 2.wav ...out8.wav
			///	3	delete all the prior wavs
			///	4	convert this wav file to mp3, bitrate=56:
			///	"C:\Program Files\aumpel\lame.exe" -b 56 -h "C:\david\music\temp.wav" "C:\david\music\Gregory Maguire\8\temp.mp3"
			///	5	delete the wav
			///	6	rename file : Gregory Maguire - Wicked (Unabridged) - # of 16.mp3 and move this mp3 file to one directory up
			///	 

		static void Main(string[] args)
		{
			Console.WriteLine("Warning: I'm a lazy programmer. The files processed by this program \n"+
								"are processed in alphabetic naming order per folder. I don't take time \n"+
								"to make sure the files processed in numeric order. \n"+
								"I suggest you take the time now to make sure your files are named \n"+
								"alphabetically (Ex: 01.mp3, 02.mp3, 03.mp3, 10.mp3) and not numerically \n"+
								"(Ex: 1.mp3, 2.mp3, 3.mp3, 10.mp3). \n"+
								"If they are not named alphabetically, hit Ctrl+C now. (Otherwise your files \n"+
								"will be glued together like 1,10,2,3.) Else, hit enter. Have a nice day.");
			Console.ReadLine();

			if (null != loopThread && loopThread.IsAlive)
			{
				return;
			}

			loopThread = new Thread(new ThreadStart(loopThreadMethod));
			//keepLooping = true;
			loopThread.Start();

		}

		private static void loopThreadMethod(){
			ArrayList dirs = new ArrayList(Directory.GetDirectories(workingDir));
			dirs.TrimToSize();
			for (int i=0; i< dirs.Count; i++)
			{
				string folder = dirs[i].ToString().Substring(1+ dirs[i].ToString().LastIndexOf("\\"));
				//Console.WriteLine(dirs[i].ToString());
				//1:
				ArrayList mp3files = new ArrayList(Directory.GetFiles(dirs[i].ToString(),"*.mp3"));
				mp3files.TrimToSize();
				if (mp3files.Count == 1){
					//there is only 1 mp3 so this process was previously stopped after doing all the below
				}
				else 
				{
					step1(mp3files);
				
					//2:
					ArrayList wavfiles = new ArrayList(Directory.GetFiles(dirs[i].ToString(),"*.wav"));
					wavfiles.TrimToSize();
					if (wavfiles.Count == 0) 
					{
						Console.WriteLine("Directory "+dirs[i].ToString()+" is empty. Deleting and moving on");
						Directory.Delete(dirs[i].ToString(),true);
						continue;
					}
					if (wavfiles.Count == 1)
					{
						//there is only 1 wav so this process was previously stopped after doing all the below
					}
					else 
					{
						step2and3(wavfiles, dirs[i].ToString());
					}
					//4:
					step4(dirs[i].ToString());

					//5:
					Console.WriteLine("delete \"" + dirs[i].ToString() +"\\"+ folder + ".wav\"");
					//see 1b
					//Process.Start("delete"," \"" + dirs[i].ToString() +"\\"+ folder + ".wav\"");
					File.Delete(dirs[i].ToString() +"\\"+ folder + ".wav"); 
				}

				//6:
				Console.WriteLine("rename \"" + dirs[i].ToString() +"\\"+ folder + ".mp3\" " + workingDir +"\\"+ final_mp3_name_prefix + folder + final_mp3_name_suffix);
				//Process.Start("rename"," \"" + dirs[i].ToString() +"\\"+ folder + ".mp3\" \"" + dirs[i].ToString() +"\\"+ final_mp3_name_prefix + folder + "of 16.mp3\"");
				File.Move(dirs[i].ToString() +"\\"+ folder + ".mp3",workingDir +"\\"+ final_mp3_name_prefix + folder + final_mp3_name_suffix);
				Directory.Delete(dirs[i].ToString(),true);

			}
			//keepLooping = false;
		}
		private static void step1(ArrayList mp3files){
			foreach (string mp3 in mp3files)
			{
				//Console.WriteLine(mp3);
				//1a: 
				Console.WriteLine(convert_mp3_wav + convert_mp3_wav_arg + mp3 + "\" \"" + mp3.Replace(".mp3", ".wav") + "\"");
				Process p1a = new Process();
				p1a.StartInfo.FileName = convert_mp3_wav;
				p1a.StartInfo.WindowStyle = windowStyle;
				p1a.StartInfo.Arguments = convert_mp3_wav_arg + mp3 + "\" \"" + mp3.Replace(".mp3", ".wav") + "\"";
				p1a.Start();
						
				//1b: 
				while (!p1a.HasExited)
				{
					//Console.WriteLine("Process not ended. i'm going to sleep for 5 seconds...");
					Thread.Sleep(5000);
				}
				Console.WriteLine("delete \""+mp3 + "\"");
				File.Delete(mp3);
				//this doesnt work because delete is an OS command, not a process
				//Process.Start("delete"," \""+mp3 + "\"");
			}
			//Console.WriteLine("Pause before reading directory contents of wav files. Hit enter to continue.");
			//Console.ReadLine();
		}
		private static void step2and3(ArrayList wavfiles, string directory){
			string folder = directory.Substring(1+ directory.LastIndexOf("\\"));
			//Console.WriteLine(folder);
			string concat_command_arg = " \"";
			foreach (string wav in wavfiles)
			{
				//Console.WriteLine("Read wav file "+wav);
				concat_command_arg += wav + "\" \"";
			}
			concat_command_arg += directory +"\\"+ folder + ".wav\"";
			Console.WriteLine(concat_command + concat_command_arg);
			Process p2 = new Process();
			p2.StartInfo.FileName = concat_command;
			p2.StartInfo.WindowStyle = windowStyle;
			p2.StartInfo.Arguments = concat_command_arg;
			p2.Start();
				
			while (!p2.HasExited)
			{
				Thread.Sleep(5000);
			}
			//3:
			foreach (string wav in wavfiles)
			{
				Console.WriteLine("delete \"" + wav + "\"");
				//see 1b
				//Process.Start("delete"," \"" + wav + "\"");
				File.Delete(wav); 
			}
		}
	
		private static void step4(string directory)
		{
			string folder = directory.Substring(1+ directory.LastIndexOf("\\"));
			Console.WriteLine(convert_wav_mp3 + convert_wav_mp3_arg + directory +"\\"+ folder + ".wav\" \"" + directory +"\\"+ folder + ".mp3\"");
			Process p4 = new Process();
			p4.StartInfo.FileName = convert_wav_mp3;
			p4.StartInfo.WindowStyle = windowStyle;
			p4.StartInfo.Arguments = convert_wav_mp3_arg + directory +"\\"+ folder + ".wav\" \"" + directory +"\\"+ folder + ".mp3\"";
			p4.Start();
				
			while (!p4.HasExited)
			{
				Thread.Sleep(5000);
			}
		}
	}
}
