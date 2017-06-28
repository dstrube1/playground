using System;

namespace Assignment6
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			Student student0 = new Student ("Bob Smith", new DateTime(1979,1,1));
			Student student1 = new Student ("Bobby Smith", new DateTime(1980,2,2));
			Student student2 = new Student ("Robert Smith", new DateTime(1981,3,3));
			Course course = new Course ();
			course.name = "Programming with C#";
			course.students = new Student[3];
			course.students [0] = student0;
			course.students [1] = student1;
			course.students [2] = student2;

			Teacher teacher = new Teacher ("Dr. Strangelove");
			course.teachers = new Teacher[1];
			course.teachers [0] = teacher;

			Degree degree = new Degree ("Bachelor");
			degree.course = course;

			UProgram uprogram = new UProgram ("Information Technology");
			uprogram.degree = degree;

			Console.WriteLine ("Program {0} contains this degree: {1}",
				uprogram.name, uprogram.degree.name);

			Console.WriteLine ("Degree {0} contains this course: {1}",
				degree.name, degree.course.name);

			Console.WriteLine ("Course {0} contains this many students: {1}",
				course.name, course.students.Length);	
		}
	}

	public class Person{
		public string name{ get; set;}
		}

	public class Student : Person {
		public DateTime dateOfBirth{ get; set;}

		public Student ()
		{
		}

		public Student (string name, DateTime dateOfBirth)
		{
			this.name = name;
			this.dateOfBirth = dateOfBirth;
		}

		void TakeTest(){
		}
	}

	public class Teacher : Person {

		public Teacher ()
		{
		}

		public Teacher (string name)
		{
			this.name = name;
		}

		void GradeTest(){
		}
	}

	public class Course
	{
		public Course ()
		{
		}
		public string name{ get; set;}
		public Student[] students{ get; set;}
		public Teacher[] teachers{ get; set;}
	}

	public class Degree
	{
		public Degree ()
		{
		}
		public Degree (string name)
		{
			this.name = name;
		}
		public string name{ get; set;}
		public Course course{ get; set;}
	}

	public class UProgram
	{
		public UProgram ()
		{
		}
		public UProgram (string name)
		{
			this.name = name;
		}
		public string name{ get; set;}
		public Degree degree{ get; set;}
	}

	/*
	 * Feedback:
	 * 
	 * 
1- What other objects could benefit from inheritance in this code?
	Nothing I can think of
	
2- Can you think of a different hierarchy for the Person, Teacher, and Student?  What is it?
	Animal -> Person -> Teacher, Student
	
3- Do NOT grade the answers to these two questions, they are merely for discussion and thought.  
	Okay
	
	 */
}
