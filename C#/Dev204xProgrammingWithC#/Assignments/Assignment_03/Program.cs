using System;

namespace Assignment3
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
			getStudentInfo ();

			getProfInfo ();

			getDegreeInfo ();

			getUniversityProgramInfo ();

			try{
				isStudentBirthdayValid ();
			}catch (NotImplementedException ){
				Console.WriteLine("NotImplementedException caught from isStudentBirthdayValid");
			}

			Console.WriteLine("Hit enter to exit");
			Console.Read();
		}

		static void getStudentInfo(){
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

			printStudentInfo ();
		}

		static bool isStudentBirthdayValid(){
			throw new NotImplementedException ("isStudentBirthdayValid is not yet implemented");
		}

		static bool isStudentOver18(){
			DateTime today = DateTime.Now;

			double totalDays = (today - studentBirthdate).TotalDays;
			const double daysIn18Years = 6574;
			if (totalDays >= daysIn18Years)
				return true;
			else
				return false;
		}

		static void getProfInfo(){
			Console.WriteLine("Enter professor name: " );
			profName = Console.ReadLine();
			Console.WriteLine("Enter professor class name: " );
			profClassName = Console.ReadLine();
			Console.WriteLine("Enter professor office hours: ");
			profOfficeHours = Console.ReadLine();
			Console.WriteLine("Enter professor email: " );
			profEmail = Console.ReadLine();

			printProfInfo ();
		}

		static void getDegreeInfo(){
			Console.WriteLine("Enter degree name: ");
			degree.setDegreeName(Console.ReadLine());


			bool success = false;
			int creditsRequired = 0;
			while (!success)
			{
				Console.WriteLine("Enter credits required: " );
				success = Int32.TryParse(Console.ReadLine(), out creditsRequired);
				if (!success) Console.WriteLine("Error. Try again. ");

			}
			degree.setCreditsRequired (creditsRequired);

			printDegreeInfo ();
		}

		static void getUniversityProgramInfo(){
			Console.WriteLine("Enter program name: ");
			universityProgram.setName(Console.ReadLine());
			Console.WriteLine("Enter program department head: ");
			universityProgram.setDepartmentHead(Console.ReadLine());
			Console.WriteLine("Enter course info: ");
			courseInfo = Console.ReadLine();

			printUniversityProgramInfo ();
		}

		static void printStudentInfo()
		{
			Console.WriteLine("{0} {1} was born on {2}", studentFirstName, studentLastName, studentBirthdate);
			if (isStudentOver18 ())
				Console.WriteLine ("Student is 18 or over");
			else
				Console.WriteLine ("Student is under 18");

			Console.WriteLine("Student address line 1: {0}", studentAddressLine1);
			Console.WriteLine("Student address line 2: {0}", studentAddressLine2);
			Console.WriteLine("Student city: {0}", studentCity);
			Console.WriteLine("Student state: {0}", studentState);
			Console.WriteLine("Student zip: {0}", studentZip);
			Console.WriteLine("Student country: {0}", studentCountry);
			Console.WriteLine("Student GPA: {0}", studentGPA);
		}
		static void printProfInfo(){
			Console.WriteLine("Professor name: {0}", profName);
			Console.WriteLine("Professor class name: {0}", profClassName);
			Console.WriteLine("Professor office hours: {0}", profOfficeHours);
			Console.WriteLine("Professor email: {0}", profEmail);
		}

		static void printDegreeInfo(){
			Console.WriteLine("Degree name: " + degree.getDegreeName());
			Console.WriteLine("Credits required: " + degree.getCreditsRequired());
		}

		static void printUniversityProgramInfo(){
			Console.WriteLine("Univesrity program name: {0}", universityProgram.getName());
			Console.WriteLine("Univesrity program department head: {0}", universityProgram.getDepartmentHead());
			Console.WriteLine("Course info: {0}", courseInfo);
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
		public int getCreditsRequired() { return creditsRequired; }
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
