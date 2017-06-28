using System;

/*
 * This is code submitted by another student.
 * Seems pretty good.
 */

namespace Module6
{

	/// <summary>
	/// NOTE: I decide not to use something in the student class to create 
	/// student counts as it is not a good design and should not be used 
	/// when creating real projects. Especially if the class was going to be 
	/// shared in another projects.
	/// 
	/// This is a better design for the future and keeps the student/teacher 
	/// classes as clean as possible
	/// 
	/// </summary>
	public class UniversitySystem
	{
		// Create a student
		public static Student EnrollStudent(string firstName, string middleName, string lastName, DateTime dateOfBirth)
		{
			Student.StudentCount += 1;
			Student s = new Student
			{
				FirstName = firstName,
				MiddleName = middleName,
				LastName = lastName,
				DateOfBirth = dateOfBirth
			};
			return s;
		}

		// create a teacher
		public static Teacher EnrollTeacher(string firstName, string middleName, string lastName)
		{
			Teacher t = new Teacher
			{
				FirstName = firstName,
				MiddleName = middleName,
				LastName = lastName
			};
			return t;
		}
	}

	// our Person object
	public class Person
	{
		public string FirstName { get; set; }
		public string MiddleName { get; set; }
		public string LastName { get; set; }
		public DateTime DateOfBirth { get; set; }

		// the age of this person
		public int Age()
		{
			return DateTime.Now.Year - DateOfBirth.Year;
		}
	}

	// Our student object
	public class Student : Person
	{
		public static int StudentCount = 0;

		public void TakeTest()
		{
			throw new NotImplementedException();
		}
	}

	// Our teacher object
	public class Teacher : Person 
	{
		public void GradeTest()
		{
			throw new NotImplementedException();
		}
	}

	// The university program object
	public class UProgram
	{
		public string ProgramName { get; set; }
		public Degree Degree { get; set; }

	}

	// The degree object
	public class Degree
	{
		public string DegreeName { get; set; }
		public Course Course { get; set; }
	}

	// The course object
	public class Course
	{

		// only allow read-only access to external users
		// that way you can only add students and teachers via the public functions
		// this abstracts/hides from the user the memory management of these arrays
		public Student[] Students { get; private set; }
		public Teacher[] Teachers { get; private set; }

		public string CourseName { get; set; }
		public int CourseCredit { get; set; }

		public int StudentCount
		{
			get { return Students == null ? 0 : Students.Length; }
		}

		// Ensure the array can hold as many students as required
		private void ResizeStudentArray()
		{
			if (Students == null)
			{
				Students = new Student[1];
			}
			else
			{
				// create a new array with a new size
				// and use this as our new data structure
				int currentSize = Students.Length;
				Student[] temp = new Student[currentSize + 1];
				for (int i = 0; i < currentSize; i++)
				{
					temp[i] = Students[i];
				}
				Students = temp;

			}
		}

		// Ensure the array can hold as many teachers as required
		private void ResizeTeacherArray()
		{
			if (Teachers == null)
			{
				Teachers = new Teacher[1];
			}
			else
			{
				// create a new array with a new size
				// and use this as our new data structure
				int currentSize = Teachers.Length;
				Teacher[] temp = new Teacher[currentSize + 1];
				for (int i = 0; i < currentSize; i++)
				{
					temp[i] = Teachers[i];
				}
				Teachers = temp;
			}
		}

		// Add a student to the course
		public void AddStudent(Student student)
		{
			if (student != null)
			{
				ResizeStudentArray();
				int i = Students.Length - 1;
				Students[i] = student;
			}
		}

		// Add a teacher to the course
		public void AddTeacher(Teacher teacher)
		{
			if (teacher != null)
			{
				ResizeTeacherArray();
				int i = Teachers.Length - 1;
				Teachers[i] = teacher;
			}
		}
	}

	class Temp //Program
	{
		private static void Main(string[] args)
		{
			// 1. Instantiate three Student objects.
			Student s1 = UniversitySystem.EnrollStudent("Roger", "J", "Rabbit", new DateTime(1970, 1, 1));
			Student s2 = UniversitySystem.EnrollStudent("Donald", string.Empty, "Ducklet", new DateTime(1976, 5, 23));
			Student s3 = UniversitySystem.EnrollStudent("Gabrielle", "Olivier", "Gable", new DateTime(1983, 7, 15));

			// 2. Instantiate a Course object called Programming with C#.
			Course defaultCourse = new Course { CourseName = "Programming with C#" };

			// 3. Add your three students to this Course object.
			defaultCourse.AddStudent(s1);
			defaultCourse.AddStudent(s2);
			defaultCourse.AddStudent(s3);

			// 4. Instantiate at least one Teacher object.
			Teacher t1 = UniversitySystem.EnrollTeacher("Mr", String.Empty, "Deeds");

			// 5. Add that Teacher object to your Course object
			defaultCourse.AddTeacher(t1);

			// 6. Instantiate a Degree object, such as Bachelor.
			Degree batchelorDegree = new Degree { DegreeName = "Batchelor of Science" };

			// 7. Add your Course object to the Degree object.
			batchelorDegree.Course = defaultCourse;

			// 8. Instantiate a UProgram object called Information Technology.
			UProgram program = new UProgram { ProgramName = "Information Technology" };

			// 9. Add the Degree object to the UProgram object.
			program.Degree = batchelorDegree;

			// Using Console.WriteLine statements, output the following information to the console window:
			// The name of the program and the degree it contains
			// The name of the course in the degree
			// The count of the number of students in the course.
			Console.WriteLine(string.Format("The {0} program contains the {1} degree", program.ProgramName,
				program.Degree.DegreeName));
			Console.WriteLine();
			Console.WriteLine(string.Format("The {0} degree contains the course {1}", batchelorDegree.DegreeName,
				batchelorDegree.Course.CourseName));
			Console.WriteLine();

			// NOTE: At time of writing Module 5 instructions are a little ambigous
			// The instructor really wants the count of students on the course 
			// and not the count of students created (ie: NOT the static variable)
			// See: https://courses.edx.org/courses/course-v1:Microsoft+DEV204x+2015_T2/discussion/forum/i4x-Microsoft-MSFT_CSHARP_201-course-course/threads/55330a6278f733803e003b14
			Console.WriteLine("The {0} course contains {1} student(s)", defaultCourse.CourseName,
				defaultCourse.StudentCount);

			Console.WriteLine("Press any ket to contine . . .");
			Console.ReadKey();
		}
	}
}