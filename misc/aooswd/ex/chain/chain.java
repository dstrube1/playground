typedef int Topic;
const Topic NO_HELP_TOPIC = -1;

public class HelpHandler
{
	public HelpHandler (HelpHandler H = null, Topic t = NO_HELP_TOPIC)
	{
		_successor = h;
		_topic = t;
	}
	public boolean HasHelp ()
	{
		return _topic = NO_HELP_TOPIC;
	}
	public void SetHandler (HelpHandler H, Topic t);
	public void HandleHelp ();
	private HelpHandler _successor;
	private Topic _topic;
}

public class Widget extends HelpHandler
{
	protected Widget (Widget parent, Topic t = NO_HELP_TOPIC)
	{
		super (parent, t);
		_parent = parent;
	}
	private Widget _parent;
}

public class Button extends Widget
{
	public Button (Widget h, Topic t = NO_HELP_TOPIC)
	{
		super (h, t);
	}
	public void HandleHelp ()
	{
		if (HasHelp())
			/* offer help */
		else
			HelpHander.HandleHelp();
	}
}

public class Dialog extends Widget
{
	public Dialog (HelpHandler h, Topic t = NO_HELP_TOPIC)
	{
		super (null);
		SetHandler (h, t);
	}
	public void HandleHelp ()
	{
		if (HasHelp())
			/* offer help */
		else
			HelpHandler.HandleHelp();
	}
}

public class Application extends HelpHandler
{
	public Application (Topic t)
	{
		super (null, t);
	}
	public void HandleHelp ();
};
