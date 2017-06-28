using System;

namespace Assignment4
{
	public struct Student{
		public string firstName { get; set;}
		public string lastName { get; set;}
		public DateTime dateOfBirth { get; set;}

	}
	public struct Teacher{
		public string name { get; set;}
		public string officeHours { get; set;}
	}
	public struct Program{
		public string name { get; set;}
		public string otherProgramProperty { get; set;}
	} 
	public struct Course{
		public string name { get; set;}
		public string otherCourseProperty { get; set;}
	}

	class MainClass
	{
		public static Student[] studentArray= new Student[5];

		public static void Main (string[] args)
		{
			studentArray [0] = new Student ();
			studentArray [0].firstName = "Bob";
			studentArray [0].lastName = "Smith";
			DateTime dob = new DateTime (1979, 1, 1);
			studentArray [0].dateOfBirth = dob;

			Console.WriteLine ("Student 0 info: {0} {1} born on {2}",studentArray[0].firstName,
				studentArray[0].lastName,studentArray[0].dateOfBirth);
		}
	}
}
