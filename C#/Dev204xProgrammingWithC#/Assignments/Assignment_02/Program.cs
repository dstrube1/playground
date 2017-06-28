using System;

namespace Assignment2
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			bool startWithX = true;
			for (int row = 0; row < 8; row++) {
				for (int column = 0; column < 8; column++) {
					if (startWithX) {
						if (column % 2 == 0) {
							Console.Write ("X");
						} else {
							Console.Write ("O");
						}
					} else {
						if (column % 2 == 0) {
							Console.Write ("O");
						} else {
							Console.Write ("X");
						}
					}
					if (column == 7) {
						Console.WriteLine ();
					}
				}
				if (startWithX) {
					startWithX = false;
				} else {
					startWithX = true;
				}
			}

		}
	}
}
