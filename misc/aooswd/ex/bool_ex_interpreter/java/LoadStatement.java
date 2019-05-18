/**
 * @author Dick Gayler
 *
 */
public class LoadStatement extends OneOperandStatement
{

	/**
	 * Constructor for LoadStatement.
	 * @param op
	 */
	public LoadStatement(String op)
	{
		super(op);
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString()
	{
		return "load " + getOp();
	}

}
