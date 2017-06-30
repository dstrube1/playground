using System;
//using System.Collections.Generic;
//using System.Text;
using System.IO;

namespace dbInfo
{
    public class Class1
    {
        public string getInfo(string[] args)
        {
            string path = null;
            string label = null;
            string db = null;
            string server = null;
            StreamReader sr = null;
            string contents = null;
            int label_place = 0;
            int server_place = 0;
            int db_place = 0;
            int dbms_place = 0;

            try
            {
                if (args.Length > 0
                    && args[0].IndexOf("Program Files\\JMJ\\EncounterPRO",
                    StringComparison.CurrentCultureIgnoreCase) != -1)
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
