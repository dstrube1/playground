//Degree.cs

namespace Assignment5
{
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
}

