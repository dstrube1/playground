using System;

namespace SingletonExample
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			Console.WriteLine ("Creating non singletons...");
			NonSingleton ns1 = new NonSingleton ("ns1");
			Console.WriteLine ("instance name = "+ns1.getName());
			NonSingleton ns2 = new NonSingleton ("ns2");
			Console.WriteLine ("instance name = "+ns2.getName());

			if (ns1 == ns2){
				Console.WriteLine ("ns1 == ns2");	
			}else{
				Console.WriteLine ("ns1 != ns2");	
			}

			Console.WriteLine ();	//blank line for spacing
			Console.WriteLine ("Creating singleton...");
			MySingleton mySingleton1 = MySingleton.getInstance ("mySingleton1");
			Console.WriteLine ("singleton name: " + mySingleton1.getName());
			MySingleton mySingleton2 = MySingleton.getInstance ("mySingleton2");
			Console.WriteLine ("singleton name: " + mySingleton2.getName());

			if (mySingleton1 == mySingleton2){
				Console.WriteLine ("mySingleton1 == mySingleton2");	
			}else{
				Console.WriteLine ("mySingleton1 != mySingleton2");	
			}

		}
	}

	class NonSingleton{
		private string name;
		public NonSingleton(string name){
			Console.WriteLine ("Created instance " + name);
			this.name = name;
		}
		public string getName(){
			return name;
		}

	}

	class MySingleton
	{
		//All singletons share 3 characteristics:
		//1: private instance variable that represents the instance of the class being created
		//This is used to ensure that there is only one instance of the class
		private static MySingleton _instance;

		//2: private constructor
		//can only be called from methods from within the class
		private MySingleton(){
			Console.WriteLine ("Instance does not already exists. Creating instance " + _name);
		}

		//3: public static method for getting the instance.
		//Put here the logic that checks to see whether or not the instance already exists.
		//If it doesn't exist, create the instance,
		//If it does exist, return the already existing instance.
		public static MySingleton getInstance(string name){
			if (_instance == null) {
				_name = name;
				_instance = new MySingleton ();
			} else {
				Console.WriteLine ("Instance already exists. Returning already existing insance " + _name);
			}
			return _instance;
		}

		//Unnecessary; only useful to illustrating a detail
		private static string _name;

		public string getName(){
			return _name;
		}
	}
}
