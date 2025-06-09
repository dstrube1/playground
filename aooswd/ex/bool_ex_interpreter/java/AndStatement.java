/**
 * @author Dick Gayler
 *
 */
public class AndStatement extends OneOperandStatement
{

	/**
	 * Constructor for AddStatement.
	 * @param op
	 */
	public AndStatement(String op)
	{
		super(op);
	}

	public String toString ()
	{
		return "add " + getOp();
	}
	
}
