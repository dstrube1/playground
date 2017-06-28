using System;

namespace Assignment5
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			//type inference
			var student0 = new Student ("Bob", "Smith", new DateTime(1979,1,1));
			var student1 = new Student ("Bobby", "Smith", new DateTime(1980,2,2));
			var student2 = new Student ("Robert", "Smith", new DateTime(1981,3,3));
			var course = new Course ();
			course.name = "Programming with C#";
			course.students = new Student[3];
			course.students [0] = student0;
			course.students [1] = student1;
			course.students [2] = student2;

			var teacher = new Teacher ("Dr. Strangelove");
			course.teachers = new Teacher[1];
			course.teachers [0] = teacher;

			var degree = new Degree ("Bachelor");
			degree.course = course;

			var uprogram = new UProgram ("Information Technology");
			uprogram.degree = degree;

			Console.WriteLine ("Program {0} contains this degree: {1}",
				uprogram.name, uprogram.degree.name);

			Console.WriteLine ("Degree {0} contains this course: {1}",
				degree.name, degree.course.name);

			Console.WriteLine ("Course {0} contains this many students: {1}",
				course.name, course.students.Length);	




		}
	}
}
//	#region notes
//			var dm = new DrinksMachine ();

//			var anAnonymousObject = new { Name = "Tom", Age = 65, blah = 1.5 };
//			anAnonymousObject.Name = "Bob"; // = error
//			Console.WriteLine ("Hello World!: anAnonymousObject.name = {0}",
//				anAnonymousObject.Name);


//	public partial class DrinksMachine
//	{
//
//		public void MakeCappuccino()
//		{
//			// Method logic goes here.
//		}
//	}
//
//	public partial class DrinksMachine
//	{
//
//		public void MakeEspresso()
//		{
//			// Method logic goes here.
//		}
//	}
//	#endregion
