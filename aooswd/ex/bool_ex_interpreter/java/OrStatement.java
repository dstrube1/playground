/**
 * @author Dick Gayler
 *
 */
public class OrStatement extends OneOperandStatement
{

	/**
	 * Constructor for SubStatement.
	 * @param op
	 */
	public OrStatement(String op)
	{
		super(op);
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString()
	{
		return "or " + getOp();
	}

}
