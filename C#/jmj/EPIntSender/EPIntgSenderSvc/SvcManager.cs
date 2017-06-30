using System;
using System.Data;
using System.IO;
using System.Threading;
using System.Reflection;
using System.Data.SqlClient;
using EPIntSenderLib;

namespace EPIntSenderSvc
{
	/// <summary>
	/// The different methods of scheduling available:
	/// "Always" means the process will be run again each time it exits.
	/// "Scheduled" means that the process runs on a timer.
	/// </summary>
	public enum ScheduleMethod
	{
		Always,
		Scheduled
	}

	/// <summary>
	/// The intended direction of message movement for a particular BaseComm instance.
	/// </summary>
	public enum Direction
	{
		Send,
		Receive
	}

	/// <summary>
	/// A class containing all important and identifying information about a
	/// single BaseComm instance.
	/// </summary>
	public class ComponentInstance
	{
		BaseComm component;
		Direction direction;
		Thread thread;
		Timer timer;

		/// <summary>
		/// ComponentInstance Constructor
		/// </summary>
		/// <param name="Component">A BaseComm instance</param>
		/// <param name="Direction">Intended direction of message flow</param>
		/// <param name="Thread">Thread to start when schedule is due</param>
		/// <param name="Timer">Timer to control schedule</param>
		public ComponentInstance(BaseComm Component, 
			Direction Direction, Thread Thread, Timer Timer)
		{
			component = Component;
			direction = Direction;
			thread = Thread;
			timer = Timer;
		}

		/// <summary>
		/// A BaseComm instance
		/// </summary>
		public BaseComm Component
		{
			get{return component;}
			set{component=value;}
		}
		/// <summary>
		/// Direction of intended message flow
		/// </summary>
		public Direction Direction
		{
			get{return direction;}
		}
		/// <summary>
		/// Thread to start when schedule is due
		/// </summary>
		public Thread Thread
		{
			get{return thread;}
			set{thread=value;}
		}
		/// <summary>
		/// Timer to control schedule
		/// </summary>
		public Timer Timer
		{
			get{return timer;}
			set{timer=value;}
		}
	}

	/// <summary>
	/// SvcManager controls the instantiation and scheduling of all
	/// communication processes.
	/// </summary>
	public class SvcManager
	{
		/// <summary>
		/// Static SvcManager instance
		/// </summary>
		private static SvcManager mgr = null;
		/// <summary>
		/// Keep monitoring while this is true
		/// </summary>
		private bool cont = false;
		/// <summary>
		/// Thread to monitor processes with "Always" schedule
		/// </summary>
		private Thread runThread = null;
		/// <summary>
		/// Access to Integration DB
		/// </summary>
		private EPIntSenderLib.BaseDataSource db = null;

		// Integration DB connection information
		private string server=null, database=null, user=null, password=null,instanceId;
		private bool integratedSecurity=false;

		/// <summary>
		///  Dictionary of all ComponentInstance classes instantiated
		/// </summary>
		private System.Collections.Specialized.HybridDictionary componentInstance=null;


		private SvcManager()
		{
			ReadSvcConfigXML();
		}

		/// <summary>
		/// Method instantiates BaseComm classes and begins scheduling
		/// </summary>
		public static void Run()
		{
			// If mgr has already been instantiated, we don't want to do it again.
			if(null!=mgr)
				throw new Exception("SvcManager is already running.");
				
			mgr = new SvcManager();
			mgr.cont=true;
			// Initialize componentInstance members and activate schedules
			mgr.init();
			// Begin monitor thread for "Always" scheduled instances
			mgr.runThread = new Thread(new ThreadStart(mgr.monitorThreads));
			mgr.runThread.Start();
#if (DEBUG)
			Event.LogInformation("Done with Run()");
#endif
		}

		/// <summary>
		/// Method stops all monitoring and scheduling
		/// </summary>
		public static void Stop()
		{
			try
			{
				// If mgr has not been instantiated, it does not need to be stopped.
				if(null==mgr)
					throw new Exception("SvcManager is not running.");

				// Set all timers to infinite start delay and interval
				foreach(System.Collections.DictionaryEntry de in mgr.componentInstance)
				{
					ComponentInstance inst = (ComponentInstance) de.Value;
					if(null!=inst.Timer)
						inst.Timer.Change(Timeout.Infinite,Timeout.Infinite);
				}
				// set cont=false to let monitorThreads() exit its loop
				mgr.cont=false;

				// max time to wait for monitorThreads() to exit = 60 seconds
				TimeSpan maxWait = TimeSpan.FromSeconds(30d);
				// starting.... NOW
				DateTime start = DateTime.Now;
				// Keep sleeping for up to maxWait for IsAlive to return false
				while(mgr.runThread.IsAlive && DateTime.Now.Subtract(maxWait)<start)
				{
					// Sleep for 1 second to avoid tight CPU loop
					Thread.Sleep(TimeSpan.FromSeconds(1));
				}
				// If the thread is still running after maxWait has expired, abort thread
				if(mgr.runThread.IsAlive)
					mgr.runThread.Abort();
			}
			catch (Exception e)
			{
				Event.LogError(e.ToString());
			}
		}

		/// <summary>
		/// Monitors all BaseComm classes running on an "Always" schedule
		/// and restarts them if they exit.
		/// </summary>
		private void monitorThreads()
		{
			int alwaysRunCount = 0;
			// Find number of components with "Always" schedule (no timer)
			foreach(ComponentInstance inst in componentInstance.Values)
			{
				if (inst.Timer==null)
					alwaysRunCount++;
			}
			// Create instances array to hold "Always" components
			ComponentInstance[] instances = new ComponentInstance[alwaysRunCount];
			alwaysRunCount=0;

			// populate instances array
			foreach(ComponentInstance inst in componentInstance.Values)
			{
				if (inst.Timer==null)
				{
					instances[alwaysRunCount] = inst;
					alwaysRunCount++;
				}
			}


			while (cont)
			{
				// Loop through instances array
				foreach(ComponentInstance inst in instances)
				{
					// If the thread associated with this ComponentInstance
					// has exited, determine its Direction and restart the thread
					if(!inst.Thread.IsAlive)
					{
						if(inst.Direction==Direction.Receive)
						{
							inst.Thread = new Thread(new ThreadStart(inst.Component.Recv));
						}
						else
						{
							inst.Thread = new Thread(new ThreadStart(inst.Component.Send));
						}
						inst.Thread.Start();
					}
				}

				// Sleep for 5 seconds at end of loop to avoid tight CPU loop
				Thread.Sleep(TimeSpan.FromSeconds(5d));
			}
		}


		/// <summary>
		/// Initializes the database connection and Dictionary of
		/// ComponentInstance objects, which contains Timers and Threads and
		/// BaseComm objects.
		/// </summary>
		private void init()
		{
#if (DEBUG)
			Event.LogInformation("Debugging, from init()");
#endif
			
			componentInstance = new System.Collections.Specialized.HybridDictionary();
			db = new EPIntSenderLib.BaseDataSource(server,database,integratedSecurity,user,password);
#if (DEBUG)
			Event.LogInformation("Initialized BaseDataSource db");
#endif
			//Initialize Event class
			Event.Initialize(server,database,user,password,integratedSecurity);
#if (DEBUG)
			Event.LogInformation("Initialized Event class");
#endif
			// get the instance id
//			instanceId = getInstanceId();
			if(instanceId!=null)
				Event.LogInformation("InstanceID = "+instanceId);

			// Get Addressee table
			DataSet dsAddressee = db.getAddressee();
#if (DEBUG)
			Event.LogInformation("Got Addressee table");
#endif
				
			// loop through all Addressee rows captured
			foreach(DataRow row in dsAddressee.Tables[0].Rows)
			{
				// If instanceId is null, do not process any non-null instanceIds
				if(instanceId==null && !row.IsNull("instanceId"))
					continue;
				// If instanceId is non-null, only process matching addressees
				else if (instanceId!=null && (row.IsNull("instanceId") || row["instanceId"].ToString().ToLower() !=instanceId.ToLower()))
					continue;

#if (DEBUG)
				Event.LogInformation("processing addressee: "+row["addresseeId"].ToString());
#endif
				// Dictionary to hold attributes to pass to BaseComm
				System.Collections.Specialized.HybridDictionary dict = new System.Collections.Specialized.HybridDictionary();
				Direction direction;
				string BaseCommClass = null;
				bool debug=false;

				// Assign a new Guid to the ComponentInstance
				Guid id = Guid.NewGuid();
				// Thread to run a BaseComm method
				Thread thread = null;
				// Timer to schedule running of thread
				Timer timer = null;
					
				// Determine direction of message flow
				if(row["directionFlag"].ToString() == "I")
					direction = Direction.Receive;
				else
					direction = Direction.Send;

				// Get class name for this instance of BaseComm
				try 
				{
					object commClass = db.getComponent(row["commComponent"].ToString());
					BaseCommClass = commClass.ToString();
				}
				catch (NullReferenceException)
				{
					Event.LogError("No class found for Component "+row["commComponent"]);
					continue;
				}

				// set debug attribute to pass to BaseComm instance
				if(!row.IsNull("debug"))
					debug=(bool)row["debug"];

				// send addressee_id to BaseComm instance
				dict.Add("addressee_id",row["addresseeId"]);

				// send documenttype to BaseComm instance
				dict.Add("documenttype",row["documenttype"]);
				
				// run process all the time.
				dict.Add("always",row["always"]);

				// if scheduled process
				dict.Add("freq",row["freq"]);
				dict.Add("start",row["start"]);
				dict.Add("address",row["address"]);
				dict.Add("owner_id",row["owner_id"]);

				// Get records from Addressee Property table for a given addressee Id
				DataSet dsAddrAttr = db.getAddresseeProperty(row["addresseeId"].ToString());

				foreach(DataRow attrow in dsAddrAttr.Tables[0].Rows)
				{
					dict.Add(attrow["property"].ToString().ToLower(),attrow["value"]);
				}
				try 
				{
					// Get Location of the file containing this code
					string assemblyLocation = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
					// Load the EPIntSenderLib assembly from same location
					Assembly assm = Assembly.LoadFile(Path.Combine(assemblyLocation,"EPIntSenderLib.dll"));
					// Get the EPIntSenderLib.dll module
					Module module = assm.GetModule("EPIntSenderLib.dll");
					// Get the Type of the BaseComm descendent to instantiate
					Type commClassType = module.GetType("EPIntSenderLib."+BaseCommClass);
					// Get the ConstructorInfo for this Type
					ConstructorInfo constr = commClassType.GetConstructor(new Type[]{});
					// Invoke the constructor and assign the returned object
					// to a variable of type BaseComm
					BaseComm comm = (BaseComm)constr.Invoke(null);
					// Now we can access the descended methods of our instance,
					// starting with SetInfo() to provide all the information we
					// have gathered so far.
					comm.SetInfo(dict,server,database,user,password,integratedSecurity,debug);
#if (DEBUG)
					Event.LogInformation("assemblyLocation="+assemblyLocation+"\n"+
						"assm="+assm.ToString()+"\n"+
						"module="+module.ToString()+"\n"+
						"commClassType="+commClassType.ToString()+"\n"+
						"constr="+constr.ToString()+"\n"+
						"comm="+comm.ToString());
#endif
					// Create thread to run either comm.Recv() or comm.Send()
					// depending on our determined message flow direction
					if(direction == Direction.Receive)
						thread = new Thread(new ThreadStart(comm.Recv));
					else
						thread = new Thread(new ThreadStart(comm.Send));

					// If "Always" schedule, start thread now
					if((bool)dict["always"] == true)
					{// Always run
						thread.Start();
					}
						// Otherwise, create a Timer to control the schedule as
						// defined in the Addressee row
					else
					{
						int dueTime=0;
						int interval=0;
						interval = (int)TimeSpan.FromHours((double)dict["freq"]).TotalMilliseconds;
						DateTime start = (DateTime)dict["start"];
						TimeSpan span = DateTime.Now.Subtract(start);
						dueTime = interval - (int)(span.TotalMilliseconds % interval);

						// Instantiate timer to call TimerCallback() method on "tick"
						timer = new Timer(new TimerCallback(TimerCallback),id,dueTime,interval);	
					}
					// Instantiate ComponentInstance variable and add it to the collection
					ComponentInstance compInst = new ComponentInstance(comm,direction,thread,timer);
					componentInstance.Add(id,compInst);
				}
				catch(Exception e)
				{
					Event.LogError("Found the source of Exception !: "+e.ToString()+"\r\n"+"BaseCommClass="+BaseCommClass);
				}		
			}//end 1st foreach
#if (DEBUG)
			Event.LogInformation("End of init()");
#endif
		}//end init()
		
		private string getInstanceId()
		{
			try
			{
				string exeLoc = System.Reflection.Assembly.GetExecutingAssembly().Location;
				exeLoc = exeLoc.Substring(0, exeLoc.LastIndexOf(System.IO.Path.DirectorySeparatorChar));

				System.Xml.XmlDocument settingsDoc = new System.Xml.XmlDocument();
				settingsDoc.Load(System.IO.Path.Combine(exeLoc, "settings.xml"));

				foreach(System.Xml.XmlNode Property in settingsDoc.DocumentElement.ChildNodes)
				{
					if(Property.Name!="Property")
						continue;
					if(Property.Attributes["Name"].Value.ToUpper()=="INSTANCEID")
						return Property.InnerText;
				}
			}
			catch(Exception exc)
			{
				Event.LogError(exc.ToString());
			}
			return null;
		}


		/// <summary>
		/// Timer callback method.  Activated when a component is scheduled to run.
		/// </summary>
		/// <param name="ID">The Guid ID of the scheduled component</param>
		private void TimerCallback(object ID)
		{
			// Determine the ID of the ComponentInstance to activate
			Guid id = (Guid)ID;
			// Retrieve the ComponentInstance from the collection
			ComponentInstance compInst = (ComponentInstance)componentInstance[id];
			// If current thread is still active, return
			if(compInst.Thread.IsAlive)
				return;
			// Declare a new thread with which to activate the instance
			Thread newThread = null;
			// Determine the method to call based on Direction and start the thread
			switch(compInst.Direction)
			{
				case Direction.Send:
					newThread = new Thread(new ThreadStart(compInst.Component.Send));
					compInst.Thread=newThread;
					newThread.Start();
					break;
				case Direction.Receive:
					newThread = new Thread(new ThreadStart(compInst.Component.Recv));
					compInst.Thread=newThread;
					newThread.Start();
					break;
			}
		}

		/// <summary>
		/// This method reads from SvcConfig.xml in the EXE directory and 
		/// populates local variables with information to connect to the
		/// Integration DB.
		/// </summary>
		private void ReadSvcConfigXML()
		{
			DataSet configDS = new DataSet();

			configDS.ReadXml(Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location),"SvcConfig.xml"));

			if(configDS.Tables.Count>0 && configDS.Tables["connection"].Rows.Count>0)
			{
				if(configDS.Tables.Contains("connection"))
				{
					if(configDS.Tables["connection"].Columns.Contains("Server") 
						&& !configDS.Tables["connection"].Rows[0].IsNull("Server"))
						server = (string)configDS.Tables["connection"].Rows[0]["Server"];

					if(configDS.Tables["Connection"].Columns.Contains("Database") 
						&& !configDS.Tables["connection"].Rows[0].IsNull("Database"))
						database = (string)configDS.Tables["connection"].Rows[0]["Database"];

					if(configDS.Tables["connection"].Columns.Contains("User") 
						&& !configDS.Tables["connection"].Rows[0].IsNull("User"))
						user = (string)configDS.Tables["connection"].Rows[0]["User"];

					if(configDS.Tables["connection"].Columns.Contains("Password") 
						&& !configDS.Tables["connection"].Rows[0].IsNull("Password"))
						password = (string)configDS.Tables["connection"].Rows[0]["Password"];

					if(configDS.Tables["connection"].Columns.Contains("IntegratedSecurity") 
						&& !configDS.Tables["connection"].Rows[0].IsNull("IntegratedSecurity"))
						integratedSecurity = "Y"==configDS.Tables["connection"].Rows[0]["IntegratedSecurity"].ToString();
				}
				if(configDS.Tables.Contains("settings"))
				{
					if(configDS.Tables["settings"].Columns.Contains("InstanceId") 
						&& !configDS.Tables["settings"].Rows[0].IsNull("InstanceId"))
						instanceId = (string)configDS.Tables["settings"].Rows[0]["InstanceId"];
				}


				configDS = null;
			}
		}
	}
}
