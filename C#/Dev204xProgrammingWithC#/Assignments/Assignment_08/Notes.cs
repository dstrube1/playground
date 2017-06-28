using System;
using System.Collections;
using System.Collections.Generic;

namespace Assignment8
{
	public class Notes
	{
		public Notes ()
		{
		}

		public static void doStuff(){
			Coffee c = new Coffee ();
			Tea t = new Tea ();

			var list = new ArrayList ();
			list.Add (c);
			list.Add (t);
			try{
				list.Sort ();
			}catch(InvalidOperationException ){
				Console.WriteLine ("InvalidOperationException while trying to sort");
			}
			try{
				Coffee c0 = (Coffee)list [1];
			}catch (InvalidCastException ){
				Console.WriteLine ("InvalidCastException while trying to cast Tea as Coffee");
			}

			var genericList = new List<Coffee> ();
			genericList.Add (c);
			Coffee c1 = genericList [0];
			Console.WriteLine ("No error after getting coffee from generic list of coffee: {0}",(c1!=null));

			//This won't even compile:
//			genericList.Add(t);

			int i = 0;
			list = new ArrayList ();
			list.Add (i);
			//must cast back to int to get it out:
			int j = (int)list [0];
			//how to?
//			Console.WriteLine ("typeof list [0]: {0}",typeof(list[0]));
		}
	}

	public class CustomList<T> : IEnumerable<T>
	{
		private List<T> data = new List<T>();

		//broken crap from "Creating and Using Generic Classes"
		//		public T this [int index]{ get; set;} //error: get & set must have a body because they're not abstract
		public void Add(T item){}
		public void Remove(T item){}

		public void FillList(params T [] items)
		{
			foreach (var datum in items)
				data.Add(datum);
		}

		#region IEnumerable implementation

		public IEnumerator<T> GetEnumerator ()
		{
			foreach (var datum in data)
			{
				yield return datum;
			}
		}

		#endregion

		#region IEnumerable implementation

		IEnumerator IEnumerable.GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		#endregion
	}

	public class Coffee{}
	public class Tea{}
}

