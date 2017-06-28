using System;
using System.Collections.Generic;

/*
 * Same stoey as Temp
 */

namespace Edx_Csharp1
{

	class MainClass
	{

		public static void Main(){
			// Instantiate three Student objects.
			Student s0 = new Student ();
			s0.Name = "Bill";
			s0.Birthday = new DateTime (1974, 1, 16);

			Student s1 = new Student ();
			s1.Name = "Jack";
			s1.Birthday = new DateTime (1974, 1, 16);

			Student s2 = new Student ();
			s2.Name = "Tom";
			s2.Birthday = new DateTime (1974, 1, 16);

			// Instantiate a Course object called Programming with C#.
			Course course = new Course ();
			course.Name = "Programming with C#";

			// Add your three students to this Course object.
			course.addStudent (s0);
			course.addStudent (s1);
			course.addStudent (s2);

			//Instantiate at least one Teacher object.
			Teacher t = new Teacher();
			t.Name = "Mr. Teacher";
			t.Birthday = new DateTime (1950, 3, 4);

			//Add that Teacher object to your Course object
			course.addTeacher(t);

			//Instantiate a Degree object, such as Bachelor.
			Degree d = new Degree();
			d.Name = "Bachelor";
			//Add your Course object to the Degree object.
			d.addCourse (course);

			//Instantiate a UProgram object called Information Technology.
			UProgram p = new UProgram();
			p.Name = "Information Technology";
			//Add the Degree object to the UProgram object.
			p.addDegree(d);

			//Using Console.WriteLine statements, output the following information to the console window:
			p.PrintDetails();

		}
	}
	//}

	//using System;

	//namespace Edx_Csharp1
	//{
	public abstract class Person
	{
		private string _name;
		DateTime _birthday;

		public string Name {
			get { return _name; }

			set { _name = value; }
		}

		public DateTime Birthday {
			get { return _birthday; }

			set { _birthday = value; }
		}

		public override string ToString() 
		{
			return Name + " " + Birthday.ToShortDateString();
		}

		public Person ()
		{
		}
	}
	//}

	//using System;

	//namespace Edx_Csharp1
	//{
	public class Student : Person
	{
		public override string ToString() 
		{
			return "Student: " + base.ToString();
		}

		public void TakeTest(){
			Console.WriteLine ("Student takes test");
		}

		public Student ()
		{
		}
	}
	//}

	//using System;

	//namespace Edx_Csharp1
	//{
	public class Teacher : Person
	{
		public override string ToString() 
		{
			return "Teacher: " + base.ToString();
		}

		public void GradeTest(){
			Console.WriteLine ("Teacher grades test");
		}

		public Teacher ()
		{
		}
	}
	//}

	//using System;
	//using System.Collections.Generic;

	//namespace Edx_Csharp1
	//{
	public class Course
	{
		private string _name;
		private List<Student> _students = new List<Student> ();
		private List<Teacher> _teachers = new List<Teacher> ();

		public string Name {
			get {
				return _name;
			}
			set {
				_name = value;
			}
		}

		public void addStudent(Student s)
		{
			_students.Add (s);
		}

		public void addTeacher(Teacher s)
		{
			_teachers.Add (s);
		}

		public void PrintDetails(string prefix="")
		{
			Console.WriteLine ("{0}The {1} course, that contains {2} student(s)", prefix, Name, _students.Count);
		}

		public Course ()
		{
		}
	}
	//}

	//using System;
	//using System.Collections.Generic;

	//namespace Edx_Csharp1
	//{
	public class Degree
	{
		private string _name;
		private List<Course> _courses = new List<Course> ();

		public string Name {
			get {
				return _name;
			}
			set {
				_name = value;
			}
		}

		public void addCourse(Course c)
		{
			_courses.Add (c);
		}

		public void PrintDetails(string prefix=""){
			Console.WriteLine ("{0}The {1} degree, which contains following cources:", prefix, Name);
			foreach (Course c in _courses) {
				c.PrintDetails (prefix+" ");
			}
		}

		public Degree ()
		{
		}
	}
	//}

	//using System;
	//using System.Collections.Generic;

	//namespace Edx_Csharp1
	//{
	public class UProgram
	{	
		private string _name;
		private List<Degree> _degree = new List<Degree> ();

		public string Name {
			get {
				return _name;
			}
			set {
				_name = value;
			}
		}

		public void addDegree(Degree d)
		{
			_degree.Add (d);
		}

		public void PrintDetails(string prefix="")
		{
			Console.WriteLine ("{0}The {1} program contains following degrees:", prefix, Name);
			foreach (Degree d in _degree) {
				d.PrintDetails (prefix+" ");
			}
		}

		public UProgram ()
		{
		}
	}
}