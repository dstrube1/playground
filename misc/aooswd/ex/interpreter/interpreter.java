public class BooleanExp
{
	public BooleanExp ();
	public abstract boolean Evaluate (context);
	public abstract BooleanExp Replace (String, BooeanExp);
	public abstract BooleanExp Copy ();
}

public class Context
{
	public boolean Lookup (String);
	public void Assign (VariableExp, boolean);
}

public class VariableExp :extends BooleanExp
{
	public VariableExp (String name)
	{
		_name = name.toUpperCase();
	}
	public boolean Evaluate (context aContext)
	{
		return aContext.Lookup (_name);
	}
	public BooleanExp Replace (String name, BooleanExp exp)
	{
		if (name != _name)
			return exp.Copy ();
		else
			return new VariableExp (_name);
	}
	public BooleanExp Copy ()
	{
		return new VariableExp (_name);
	}
	private String _name;
}

public class AndExp extends BooleanExp
{
	public AndExp (BooleanExp op1, BooleanExp op2)
	{
		_operand1 = op1;
		_operand2 = op2;
	}
	public bool Evaluate (Context aContext)
	{
		return _operand1.Evaluate (aContext) && _operand2.Evaluate (aContext);
	}
	public BooleanExp Replace (string, BooleanExp);
	public BooleanExp Copy ()
	{
		return new AndExp (_operand1.Copy (), _operand2.Copy ());
	}
	private BooleanExp _operand1;
	private BooleanExp _operand2;
}

BooleanExp expression;
Context context;
VariableExp x = new VariableExp ("X");
VariableExp y = new VariableExp ("Y");
expression = new OrExp (new AndExp (new Constant (true, x), new
	AndExp (y, new notExp (X)));
context.Assign (x, false);
context.Assign (y, true);
boolean result = expression.Evaluate (context);
