using System;

namespace Assignment1
{
	class MainClass
	{
		//Student info
		private static string studentFirstName = "Bob";
		private static string studentLastName = "Smith";
		private static DateTime studentBirthdate = new DateTime(1979, 3, 17);
		private static string studentAddressLine1 = "1234 Happy Ln";
		private static string studentAddressLine2 = "Apt 5";
		private static string studentCity = "Atlanta";
		private static string studentState = "GA";
		private static string studentZip = "30309";
		private static string studentCountry = "USA";
		private static Double studentGPA = 4.0F;

		//Prof info
		private static string profName = "Dr. Strangelove";
		private static string profClassName = "World Politics 101";
		private static string profOfficeHours = "M-F, 11:00AM - 12:30PM";
		private static string profEmail = "dstranglo@microsoft.edu";

		private static Degree degree = new Degree();
		private static UniversityProgram universityProgram = new UniversityProgram();

		private static string courseInfo = "In this course, we shall learn to stop worrying and love the bomb";

		public static void Main (string[] args)
		{
			Console.WriteLine("Here's the info we have so far:");
			printInfo();

			getInfo();

			Console.WriteLine("Here's the info you entered:");
			printInfo();

			Console.WriteLine("Hit enter to exit");
			Console.Read();
		}

		static void printInfo()
		{
			Console.WriteLine("Student first name: " + studentFirstName);
			Console.WriteLine("Student last name: " + studentLastName);
			Console.WriteLine("Student birthdate: " + studentBirthdate);
			Console.WriteLine("Student address line 1: " + studentAddressLine1);
			Console.WriteLine("Student address line 2: " + studentAddressLine2);
			Console.WriteLine("Student city: " + studentCity);
			Console.WriteLine("Student state: " + studentState);
			Console.WriteLine("Student zip: " + studentZip);
			Console.WriteLine("Student country: " + studentCountry);
			Console.WriteLine("Student GPA: " + studentGPA);
			Console.WriteLine("Professor name: " + profName);
			Console.WriteLine("Professor class name: " + profClassName);
			Console.WriteLine("Professor office hours: " + profOfficeHours);
			Console.WriteLine("Professor email: " + profEmail);
			Console.WriteLine("Degree name: " + degree.getDegreeName());
			Console.WriteLine("Univesrity program name: " + universityProgram.getName());
			Console.WriteLine("Univesrity program department head: " + universityProgram.getDepartmentHead());
			Console.WriteLine("Course info: " + courseInfo);

		}
		static void getInfo()
		{
			Console.WriteLine("Enter student first name: ");
			studentFirstName = Console.ReadLine();
			Console.WriteLine("Enter student last name: ");
			studentLastName = Console.ReadLine();

			bool success = false;
			int year = 0, month = 0, day = 0;
			while (!success)
			{
				Console.WriteLine("Enter student birthdate year: ");
				success = Int32.TryParse(Console.ReadLine(), out year);
				if (!success) Console.WriteLine("Error. Try again. ");

			}
			success = false;
			while (!success)
			{
				Console.WriteLine("Enter student birthdate month: ");
				success = Int32.TryParse(Console.ReadLine(), out month);
				if (!success) Console.WriteLine("Error. Try again. ");

			}
			success = false;
			while (!success)
			{
				Console.WriteLine("Enter student birthdate day: ");
				success = Int32.TryParse(Console.ReadLine(), out day);
				if (!success) Console.WriteLine("Error. Try again. ");

			}

			studentBirthdate = new DateTime(year, month, day);
			Console.WriteLine("Enter student address line 1: " );
			studentAddressLine1 = Console.ReadLine();
			Console.WriteLine("Enter student address line 2: " );
			studentAddressLine2 = Console.ReadLine();
			Console.WriteLine("Enter student city: " );
			studentCity = Console.ReadLine();
			Console.WriteLine("Enter student state: " );
			studentState = Console.ReadLine();
			Console.WriteLine("Enter student zip: " );
			studentZip = Console.ReadLine();
			Console.WriteLine("Enter student country: " );
			studentCountry = Console.ReadLine();
			success = false;
			while (!success)
			{
				Console.WriteLine("Enter student GPA: " );
				success = Double.TryParse(Console.ReadLine(), out studentGPA);
				if (!success) Console.WriteLine("Error. Try again. ");

			}
			Console.WriteLine("Enter professor name: " );
			profName = Console.ReadLine();
			Console.WriteLine("Enter professor class name: " );
			profClassName = Console.ReadLine();
			Console.WriteLine("Enter professor office hours: ");
			profOfficeHours = Console.ReadLine();
			Console.WriteLine("Enter professor email: " );
			profEmail = Console.ReadLine();
			Console.WriteLine("Enter degree name: ");
			degree.setDegreeName(Console.ReadLine());
			Console.WriteLine("Enter program name: ");
			universityProgram.setName(Console.ReadLine());
			Console.WriteLine("Enter program department head: ");
			universityProgram.setDepartmentHead(Console.ReadLine());
			Console.WriteLine("Enter course info: ");
			courseInfo = Console.ReadLine();
		}

	}

	class Degree
	{
		private string degreeName;
		private int creditsRequired;
		private string[] courseList;
		private string[] prerequisites;

		public Degree() { 
			setDegreeName("Bachelor");

			setCreditsRequired (12);

			string[] courses = new string[2];
			courses [0] = "World Politics 101";
			courses [1] = "World Politics 102";
			setCourseList(courses);

			string[] prereqs = new string[2];
			prereqs [0] = "World History 101";
			prereqs [1] = "World Politics 100";
			setPrerequisites (prereqs);


		}
		public void setDegreeName(string degreeName) { this.degreeName = degreeName; }
		public string getDegreeName() { return degreeName; }
		public void setCreditsRequired(int creditsRequired) { this.creditsRequired = creditsRequired; }
		public void setCourseList(string[] courseList) { this.courseList = courseList; }
		public string[] getCourseList() { return courseList; }
		public void setPrerequisites(string[] prerequisites) { this.prerequisites = prerequisites; }
		public string[] getPrerequisites() { return prerequisites; }
	}

	class UniversityProgram
	{
		private string name;
		private Degree[] degrees;
		private string departmentHead;

		public UniversityProgram() {
			setName("Computer Science");

			Degree[] degrees = new Degree[2];
			Degree degree0 = new Degree ();
			degree0.setDegreeName ("Bachelors");
			Degree degree1 = new Degree ();
			degree1.setDegreeName ("Ph.D");
			degrees [0] = degree0;
			degrees [1] = degree1;
			setDegrees (degrees);

			setDepartmentHead("Dr. Strangelove");
			}

		public void setName(string name) { this.name = name; }
		public string getName() { return name; }
		public void setDegrees(Degree[] degrees) { this.degrees = degrees; }
		public Degree[] getDegrees() { return degrees; }
		public void setDepartmentHead(string departmentHead) { this.departmentHead = departmentHead; }
		public string getDepartmentHead() { return departmentHead; }
	}

}
