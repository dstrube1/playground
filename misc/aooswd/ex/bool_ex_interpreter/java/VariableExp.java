/**
 * @author dgayler
 *
 */
public class VariableExp implements BooleanExp
{

	private String name;
	
	public VariableExp (String lexeme)
	{
		name = lexeme;
	}
	
	/**
	 * @see BooleanExpression#Evaluate(Context)
	 */
	public boolean evaluate(Context con)
	{
		return con.lookup(name);
	}

	/**
	 * Returns the name.
	 * @return String
	 */
	public String getName()
	{
		return name;
	}

	/**
	 * @see BooleanExp#generateCode(Context)
	 */
	public String generateCode(Context con)
	{
		return name;
	}

}
