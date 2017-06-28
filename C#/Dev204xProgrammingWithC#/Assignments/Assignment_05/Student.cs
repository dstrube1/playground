//Student.cs

using System; //required by DateTime

namespace Assignment5
{
	public class Student
	{
		public Student ()
		{
			count++;
		}
		public Student (string firstName, string lastName, DateTime dateOfBirth)
		{
			this.firstName = firstName;
			this.lastName = lastName;
			this.dateOfBirth = dateOfBirth;
			count++;
		}

		public string firstName{ get; set;}
		public string lastName{ get; set;}
		public DateTime dateOfBirth{ get; set;}
		//Add a static class variable to the Student class 
		//to track the number of students currently enrolled in a school.   
		//Increment a student object count every time a Student is created.
		public static int count{ get; set;}

	}
}

