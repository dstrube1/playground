public class Singleton
{
	public static Singleton Instance ()
	{
		if (_instance == null)
  			_instance = new Singleton();
 		return _instance;
	}
	protected Singleton (){}
	private static Singleton _instance = null;
}

public class Singleton
{
	public static void Register (String name, Singleton singleton);
	public static Singleton Instance ();
	protected static Singleton Lookup (String name);
	private static Singleton _instance;
	private static Collection _registry;
};
