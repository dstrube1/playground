using System;

namespace Assignment4
{
	public class notes
	{
		// This is an example of a property and its indexer:
		private string[] beverages; 
		public string this[int index] 
		{ 
			get { return this.beverages[index]; } 
			set { this.beverages[index] = value; } 
		} 
		// Enable client code to determine the size of the collection. 
		public int Length 
		{ 
			get { return beverages.Length; } 
		}

		//default first value is 0; default type is int
		enum Days : byte {Yesterday=1, Today, Tomorrow};

		int[] uninstantiatedArray;
		int[] instantiatedArray = new int[2];
		int[,] array2D = new int[2,2];
		int[,,] array3D = new int[1,2,3];
		//array of arrays; first bracket must have value; second must not
		int[][] jaggedArray = new int[2][];


		public notes ()
		{
			jaggedArray [0] = new int[2];
			jaggedArray [1] = new int[3];

		}
	}
}

