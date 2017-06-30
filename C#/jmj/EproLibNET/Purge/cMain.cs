using System;
using System.IO;

namespace Purge
{
	struct ArgDef
	{
		private string argName;
		private bool active;
		private bool canModify;
		private string modifier;

		public string Name
		{
			get
			{
				return argName;
			}
		}
		public bool Active
		{
			get
			{
				return active;
			}
			set
			{
				active = value;
			}
		}
		public bool CanModify
		{
			get
			{
				return canModify;
			}
		}
		public string Modifier
		{
			get
			{
				return modifier;
			}
			set
			{
				modifier = value;
			}
		}

		public ArgDef(string Name, bool CanModify)
		{
			argName = Name;
			canModify = CanModify;
			active = false;
			modifier = null;
		}
	}
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class cMain
	{
		private string PurgeHelp = null;
		private System.Collections.Specialized.ListDictionary argDefs = null;
		private string target = null;
		private string filter = null;
		private ICSharpCode.SharpZipLib.Zip.ZipOutputStream archive = null;
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			cMain app = new cMain(args);
		}

		public cMain(string[] args)
		{
			System.Reflection.Assembly myAssembly;
			myAssembly = System.Reflection.Assembly.GetExecutingAssembly();
			string[] resources = myAssembly.GetManifestResourceNames();
			StreamReader sr = new StreamReader(myAssembly.GetManifestResourceStream("Purge.Help.txt"));
			PurgeHelp = sr.ReadToEnd();
			sr.Close();

			try
			{
				setupArgDefs();
				parseArgs(args);
				if(((ArgDef)argDefs["archive"]).Active)
				{
					archive = new ICSharpCode.SharpZipLib.Zip.ZipOutputStream(new FileStream(((ArgDef)argDefs["archive"]).Modifier,FileMode.Create));
					archive.SetLevel(5);
				}
				processFolder(target);
				if(null!=archive)
				{
					archive.Finish();
					archive.Close();
				}
			}
			catch(Exception exc)
			{
				Console.WriteLine(exc.Message);
				Console.WriteLine();
				Console.WriteLine(PurgeHelp);
			}
		}

		private void processFolder(string folder)
		{
			string[] fileList = null;
			
			if(null==filter)
				fileList = Directory.GetFiles(folder);
			else
				fileList = Directory.GetFiles(folder,filter);

			foreach(string file in fileList)
			{
				if(((ArgDef)argDefs["age"]).Active)
				{
					string ageMod = ((ArgDef)argDefs["age"]).Modifier;
					if(ageMod.ToLower().EndsWith("m"))
					{ // interpret age modifier as minutes
						ageMod = ageMod.TrimEnd(new char[]{'m','M','h','H'});
						if(File.GetCreationTime(file).AddMinutes(Int32.Parse(ageMod))>DateTime.Now)
						{
							continue;
						}
					}
					else if(ageMod.ToLower().EndsWith("h"))
					{ // interpret age modifier as hours
						ageMod = ageMod.TrimEnd(new char[]{'m','M','h','H'});
						if(File.GetCreationTime(file).AddHours(Int32.Parse(ageMod))>DateTime.Now)
						{
							continue;
						}
					}
					else
					{ // interpret age modifier as days
						if(File.GetCreationTime(file).AddDays(Int32.Parse(ageMod))>DateTime.Now)
						{
							continue;
						}
					}
				}
				if(((ArgDef)argDefs["ignorero"]).Active)
				{
					File.SetAttributes(file,FileAttributes.Normal);	
				}
				
				// WRITE FILE TO ARCHIVE
				try
				{
					if(null!=archive)
					{
						Console.WriteLine("Archiving: "+file);
						FileStream fs = File.OpenRead(file);
						byte[] data = new byte[fs.Length];
						fs.Read(data,0,data.Length);
						fs.Close();
						archive.PutNextEntry(new ICSharpCode.SharpZipLib.Zip.ZipEntry(file.Substring(target.Length).TrimStart(new char[]{'\\'})));
						archive.Write(data,0,data.Length);
						archive.CloseEntry();
					}
				}
				catch(Exception exc)
				{
					Console.WriteLine("\tError archiving file: "+file+Environment.NewLine+"\t"+exc.Message);
				}
				
				if(((ArgDef)argDefs["move"]).Active)
				{
					Console.WriteLine("Moving: "+file);
					try
					{
						string movebase = ((ArgDef)argDefs["move"]).Modifier;
						string subdir = folder.Substring(target.Length).TrimStart(new char[]{'\\'});
						string movefolder = Path.Combine(movebase,subdir);
						if(!Directory.Exists(movefolder))
							Directory.CreateDirectory(movefolder);
						File.Move(file,Path.Combine(movefolder,Path.GetFileName(file)));
					}
					catch(Exception exc)
					{
						Console.WriteLine("\tError moving file: "+file+Environment.NewLine+"\t"+exc.Message);
					}
				}
				else
				{
					Console.WriteLine("Deleting :"+file);
					try
					{
					File.Delete(file);
					}
					catch(Exception exc)
					{
						Console.WriteLine("\tError deleting file: "+file+Environment.NewLine+"\t"+exc.Message);
					}
				}
			}

			if(((ArgDef)argDefs["subdir"]).Active)
			{
				foreach(string subdir in Directory.GetDirectories(folder))
				{
					//if(null!=archive)
						//archive.PutNextEntry(new ICSharpCode.SharpZipLib.Zip.ZipEntry(subdir));
					processFolder(subdir);
					//if(null!=archive)
						//archive.CloseEntry();
				}
			}
		}

		private void setupArgDefs()
		{
			argDefs = new System.Collections.Specialized.ListDictionary();
			argDefs.Add("age",new ArgDef("age",true));
			argDefs.Add("subdir",new ArgDef("subdir",false));
			argDefs.Add("ignorero",new ArgDef("ignorero",false));
			argDefs.Add("archive",new ArgDef("archive",true));
			argDefs.Add("move",new ArgDef("move",true));
		}

		private void parseArgs(string[] args)
		{
			for(int i=0; i<args.Length; i++)
			{
				if(args[i][0]=='-' || args[i][0]=='/')
				{
					string arg = args[i].Substring(1).ToLower();
					ArgDef def = ((ArgDef)argDefs[arg]);
					def.Active=true;
					if(def.CanModify)
					{
						i++;
						def.Modifier=args[i];
					}
					argDefs[arg] = def;
					continue;
				}
				else
				{
					filter = null;
					if(Directory.Exists(args[i]))
						target = args[i];
					else
					{
						target = Path.GetDirectoryName(args[i]);
						filter = Path.GetFileName(args[i]);
					}
				}
			}
		}
	}
}
