using System;
using System.IO;

namespace dbInfo
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	public class Class1
	{
		#region class variables
		private string path;
		private string label;
		private string db;
		private string server;
		private StreamReader sr;
		private string contents;
		private int label_place;
		private int server_place;
		private int db_place;
		private int dbms_place;
		#endregion //class variables

		public Class1()
		{
			path = null;
			label = null;
			db = null;
			server = null;
			sr = null;
			contents = null;
			label_place = 0;
			server_place = 0;
			db_place = 0;
			dbms_place = 0;
		}
	
		public string getInfo(string[] args)
		{
			try
			{
				if (args.Length > 0
					&& args[0].ToLower().IndexOf("program files\\jmj\\encounterpro") != -1)
					path = args[0];
				else
					return null;//"dbInfo doesn't contain good arg[0]";
				//Console.WriteLine("Success1");
				if (!path.EndsWith("\\"))
					path += "\\";
				//Console.WriteLine("Success2");
				if (args.Length > 1 && args[1].StartsWith("[")
					&& args[1].EndsWith("]"))
					label = args[1];
				//Console.WriteLine("Success3");
				if (File.Exists(path + "EncounterPRO.ini"))
				{
					sr = new StreamReader(File.Open(path + "EncounterPRO.ini", FileMode.Open));
					contents = sr.ReadToEnd();
					sr.Close();
					if (label != null && contents.IndexOf(label) != -1)
					{
						label_place = contents.IndexOf(label);
					}
					server_place = 9 + contents.IndexOf("dbserver=", label_place);
					db_place = contents.IndexOf("dbname=", label_place);
					dbms_place = contents.IndexOf("dbms=", label_place);

					server = contents.Substring(server_place, db_place - (server_place + 1));
					db = contents.Substring(db_place + 7, dbms_place - (db_place + 8));
				}
				else return null;//"dbInfo doesn't contain good file path: " + path + "EncounterPRO.ini";

				return "Server=" + server + ";Database=" + db + ";";
			}
			catch (Exception e)
			{
				Console.WriteLine(e.ToString());
				return null;//"error:"+e.ToString();
			}
		}
	}
}
