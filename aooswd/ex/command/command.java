public abstract class Command
{
	protected Command ()
	{
	}

	public abstract void Execute();
}

public class OpenCommand extends Command
{
	private Application _application;

	private String _response;

	public OpenCommand (Application A)
	{
		_application = A;
	}

	public void Execute()
	{
		String name = AskUser ();
		if (name != "")
		{
			Document document = new Document (name);
			_application.Add (document);
			document.Open();
		}
	}

	protected String AskUser();

}

public class PasteCommand extends Command
{
	private Document _document;

	public PasteCommand (Document D)
	{
		_document = D;
	}


	public void Execute()
	{
		_document.Paste();
	}

}

public class SimpleCommand extends Command
{
	private Action _action;
	private Object _receiver;

	public SimpleCommand (Object r, Action a)
	{
		_receiver = r;
		_action = a;
	}

	public void execute ()
	{
		_receiver._action();
	}
}

public class MacroCommand extends Command
{
	private LinkedList _cmds;

	public MacroCommand ()
	{
		_cmds = new LinkedList();
	}

	public void Add (Command C)
	{
		_cmds.addLast (C);
	}

	public void Remove (Command C)
	{
		_cmds.remove(C);
	}

	public void execute ()
	{
		ListIterator I = _cmds.listIterator();
		while (_cmd.hasNext())
			((Command)(_cmd.next())).execute();
	}
}

MyClass receiver = new MyClass();
Command aCommand = new SimpleCommand (receiver, Action);
aCommand.execute();




