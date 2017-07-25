import java.util.Vector;

/**
 * @author dgayler
 *
 */
public class TestBoolExp
{

	public static void main(String[] args)
	{
		VariableExp x = new VariableExp ("X");
		VariableExp y = new VariableExp ("Y");
		BooleanExp expression = new OrExp 
			(new AndExp(new Constant (true), x),
			new AndExp (y, new NotExp(x)));
		SymbolTable table = new SymbolTable();
		GeneratedCode code = new GeneratedCode();
		table.insert(new BooleanSymbolData ("X"));
		table.insert(new BooleanSymbolData ("Y"));
		Context c = new Context(table, code);
		c.assign (x, false);
		c.assign (y, true);
		String location = expression.generateCode(c);
		Vector assmCode = c.getCode();
		displayCode (assmCode);
//		boolean value = expression.evaluate(c);
//		System.out.println ("result is " + value); 
	}
	
	private static void displayCode (Vector code)
	{
		for (int i = 0; i < code.size(); i++)
			System.out.println (code.elementAt(i).toString());
	}
	
}
