using System;

namespace Assignment6
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			InherittingClass i = new InherittingClass ();
			Console.WriteLine ("implementedMethod : "+i.implementedMethod());
			Console.WriteLine ("virtualMethod : "+i.virtualMethod());
			Console.WriteLine ("abstractMethod : "+i.abstractMethod());
		}
	}

	public abstract class AbstractClass{
		//can have some or no methods; must not be instantiated

		public string implementedMethod(){
			return "this method has been implemented";
		}

		public virtual string virtualMethod(){
			return "this method may or may not be imlemented; & may or may not be overridden";
		}

		public abstract string abstractMethod();
		//must not be implemented here; must be implemented in any inheritting class
	}

	sealed class InherittingClass : AbstractClass{ //sealed means can't be inheritted from
		public InherittingClass(){}

		//what happens if we don't put this here? warning
		//cannot be private; must not use override keyword;
		//must use "new" to hide AbstractClass's implementation
		public new string implementedMethod(){
			return "this method has been implemented by inherittingClass";
		}

		//what happens if we don't put this here? warning
//		public virtual string virtualMethod(){
//			return "really virtual virtualMethod";
//		}

		//what happens if we don't put this here? 
		//error, unless i comment out the above method; then it's just a warning
		public new string virtualMethod(){
			return "implemented inherited virtualMethod";
		}

		//what happens if we put this here? error
//		public abstract string abstractMethod();

		//error, unless i comment out the above method; then it's just an error 
		//wtf? oh, because i didn't say override
		public override string abstractMethod(){
			return "implemented inherited abstractMethod";
		}

	}

	public interface IInterface1{
		//public modifier here = error
		string implementedMethod();
		//also errors:
		//		virtual string virtualMethod();
		//		abstract string abstractMethod();
		//in java, interfaces can have constants; not in C#
		//		const int myInt = 0;

		bool property { get; set; }
		event EventHandler myEvent;
		string this[int index] { get; set; }
	}
	public interface IInterface2{
	}

	//if interfaces are public, then this has to be public
	//if abstract class is public, then this has to be public
	public class Implementer : AbstractClass, IInterface1, IInterface2, IDisposable{
		public Implementer(){
			myEvent = null;
		}
		private bool _isDisposed;
		public bool property { get; set; }
		public event EventHandler myEvent;
		string[] myArray = null;
		public string this[int index] { 
			get{ return myArray[index];} 
			set{ myArray[index] = value;} 

		}

		public override string abstractMethod(){
			if (!_isDisposed)
				throw new ObjectDisposedException ("Implementer : abstractMethod");
			return "implementing this because i have to";
		}

		#region IDisposable implementation

		public void Dispose ()
		{
			Dispose(true);
			//instructs the GC that resources have already been released 
			//and the GC does not need to waste time running the finalization code.
			GC.SuppressFinalize(this);
		}

		#endregion

		protected virtual void Dispose(bool isDisposing)
		{
			if (this._isDisposed)
				return;
			if (isDisposing)
			{
				// Release only managed resources.
				}
			// Always release unmanaged resources.
			//???
				// Indicate that the object has been disposed.
				this._isDisposed = true;
		}
		//Destructor
		~Implementer(){
			Dispose(false);
		}
	}
}
