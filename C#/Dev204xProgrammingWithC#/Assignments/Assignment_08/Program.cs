using System;
using System.Collections.Generic;
using System.Collections;

namespace Assignment8
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			Student student0 = new Student ("Robert", "Smith", new DateTime(1981,3,3),  getGrades ());
			Student student2 = new Student ("Bob","Smith", new DateTime(1979,1,1),  getGrades ());
			Student student1 = new Student ("Bobby","Smith", new DateTime(1980,2,2),  getGrades ());
			Course course = new Course ();
			course.name = "Programming with C#";

			var students = new List<Student> ();
			students.Add(student0);
			students.Add(student1);
			students.Add(student2);
			course.students = students;

			course.ListStudents ();


			Console.WriteLine ("Course {0} contains this many students: {1}",
				course.name, course.students.Count);	

			student0.bonusChallenge ();
		}

		public static Stack<Int32> getGrades(){
			var grades = new Stack<Int32> ();
			Random random = new Random ();
			for (int i = 0; i < 5; i++) {
				grades.Push (random.Next (0, 100));
			}
			return grades;
		}
	}

	public class Person{
		public string firstName{ get; set;}
		public string lastName{ get; set;}
	}

	public class Student : Person, IComparer {
		public DateTime dateOfBirth{ get; set;}
		public Stack<Int32> grades{ get; set;}

		public Student ()
		{
		}

		public Student (string firstName, string lastName, DateTime dateOfBirth, Stack<Int32> grades)
		{
			this.firstName = firstName;
			this.lastName = lastName;
			this.dateOfBirth = dateOfBirth;
			this.grades = grades;
		}

		public void TakeTest(){
		}

		void changeLastGrade(){
			Random random = new Random ();
			grades.Pop ();
			grades.Push (random.Next (0, 100));
		}

		public void bonusChallenge(){
			//Ensure you have added at least 5 grades to the stack.
			Console.WriteLine ("Count of grades: {0}",grades.Count);
			if (grades.Count < 5) {
				Console.WriteLine ("Failure in bonusChallenge: grade count is less than 5.");
				return;
			}
			Console.WriteLine ("Here are the grades before the change: ");
			foreach (int grade in grades){
				Console.WriteLine (grade);
			}

			Console.WriteLine ("Now we remove the last entered grade and replace it with a new one. ");

			int gradeToChange = (int)grades.Pop ();
			Console.WriteLine ("Changing this grade: {0}",gradeToChange);
			Random random = new Random ();
			gradeToChange = random.Next (0, 100);
			Console.WriteLine ("to this: {0}",gradeToChange);
			grades.Push (gradeToChange);

			Console.WriteLine ("Here are the grades after the change: ");
			foreach (int grade in grades){
				Console.WriteLine (grade);
			}
		}

		public int Compare( object a, object b ){
			//good example:
			//			http://www.java2s.com/Tutorial/CSharp/0220__Data-Structure/SortarraylistusingcustomIComparer.htm
			Student sA = (Student)a;
			Student sB = (Student)b;
			int lNameCmp;
			int fNameCmp;

			lNameCmp = String.Compare( sA.lastName, sB.lastName );
			if( lNameCmp != 0 ) return lNameCmp;

			fNameCmp = String.Compare( sA.firstName, sB.firstName );

			return fNameCmp;
		}
	}

	public class Course
	{
		public Course ()
		{
		}
		public string name{ get; set;}
		public List<Student> students{ get; set;}

		public void ListStudents(){
//			students.Sort (new Student());
			foreach (Student student in students) {
				Console.WriteLine ("Student in course: {0} {1}", student.firstName, student.lastName);
			}
		}
	}


}
