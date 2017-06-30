using System;

namespace EPIntDaemonLib
{
	/// <summary>
	/// Summary description for BaseDaemon.
	/// </summary>
	public class BaseDaemon
	{
		/// <summary>
		/// The info Dictionary holds attributes specific to this daemon instance
		/// </summary>
		protected System.Collections.Specialized.HybridDictionary info = new System.Collections.Specialized.HybridDictionary(6,false);
		/// <summary>
		/// The db BaseDataSource allows easy access to the Integration DB.
		/// </summary>
		protected BaseDataSource db;
		/// <summary>
		/// debug determines whether to post informational messages to the EventLog
		/// </summary>
		protected bool debug=false;

		// Database connection information
		private string server=null,database=null,user=null,password=null;
		private bool integratedSecurity=true;

		/// <summary>
		/// BaseComm constructor
		/// </summary>
		public BaseDaemon()
		{
		}

		/// <summary>
		/// Method called by SvcManager to provide necessary information to BaseComm
		/// </summary>
		/// <param name="Info">Dictionary of attributes from Addressee row</param>
		/// <param name="Server">Integration server name</param>
		/// <param name="Database">Integration database name</param>
		/// <param name="User">Integration user name</param>
		/// <param name="Password">Integration user password</param>
		/// <param name="IntegratedSecurity">Uses Windows authentication if true</param>
		/// <param name="Debug">If true, BaseComm will post informational 
		/// messages to the EventLog.</param>
		public void SetInfo(System.Collections.Specialized.HybridDictionary Info, string Server, string Database, string User, string Password, bool IntegratedSecurity, bool Debug)
		{
			info = Info;

			server=Server;
			database=Database;
			user=User;
			password=Password;
			integratedSecurity=IntegratedSecurity;
			debug=Debug;
		}

		public void Run()
		{
			run();
		}

		private abstract void run;
	}
}
