using System;
using System.IO;

namespace FTPAccess
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
	/// Summary description for cMain.
	/// </summary>
	class cMain
	{
		private string Help = null;
		private string source = null;
		private string dest = null;
		private Uri sourceUri;
		private Uri destUri;
		private string sourceScheme = null;
		private string destScheme = null;
		private System.Collections.Specialized.ListDictionary argDefs = null;

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
			EproLibNET.Utilities util = new EproLibNET.Utilities();
			util.InitializeEventLog("EproLibNET.FTPAccess");

			System.Reflection.Assembly myAssembly;
			myAssembly = System.Reflection.Assembly.GetExecutingAssembly();
			string[] resources = myAssembly.GetManifestResourceNames();
			StreamReader sr = new StreamReader(myAssembly.GetManifestResourceStream("FTPAccess.Help.txt"));
			Help = sr.ReadToEnd();
			sr.Close();

			try
			{
				setupArgDefs();
				parseArgs(args);

				if(null==source)
					throw new Exception ( "No <SOURCE> specified." );
				
				// Remove trailing backslashes
				source = source.Trim();
				source = source.TrimEnd ( new char[] { Path.DirectorySeparatorChar } );
				
				sourceUri = new Uri(source);
				sourceScheme = sourceUri.Scheme;

				destUri = new Uri(dest);
				destScheme = destUri.Scheme;
				
				util.LogEvent("EproLibNET.FTPAccess.cMain","cMain","Source = "+source+Environment.NewLine+
					"Destination = "+dest+Environment.NewLine+
					"User = "+((ArgDef)argDefs["uid"]).Modifier+Environment.NewLine+
					"Pwd = "+((ArgDef)argDefs["pwd"]).Modifier,1);
				

				if(sourceScheme == "file" && destScheme == "ftp")
				{
					util.LogEvent("EproLibNET.FTPAccess.cMain","cMain","Beginning FTP Put operation",1);
					util.FTPPut(dest,source,((ArgDef)argDefs["uid"]).Modifier, ((ArgDef)argDefs["pwd"]).Modifier, false);
				}
				else if(sourceScheme == "ftp" && destScheme == "file")
				{
					util.LogEvent("EproLibNET.FTPAccess.cMain","cMain","Beginning FTP Get operation",1);
					util.FTPGet(source,dest,((ArgDef)argDefs["uid"]).Modifier, ((ArgDef)argDefs["pwd"]).Modifier, false);
				}
				else
					throw new Exception("Must be either a Get or Put operation.");

			}
			catch(Exception exc)
			{
				util.LogEvent("EproLibNET.FTPAccess.cMain","cMain",exc.ToString(),4);
				Console.WriteLine(exc.Message);
				Console.WriteLine();
				Console.WriteLine(Help);
			}
		}
		private void setupArgDefs()
		{
			argDefs = new System.Collections.Specialized.ListDictionary();
			argDefs.Add("uid",new ArgDef("uid",true));
			argDefs.Add("pwd",new ArgDef("pwd",true));
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
					if(null==source)
						source = args[i];
					else if(null==dest)
						dest = args[i];
				}
			}
		}

	}
}
