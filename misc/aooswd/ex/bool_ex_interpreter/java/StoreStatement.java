/**
 * @author Dick Gayler
 *
 */
public class StoreStatement extends OneOperandStatement
{

	/**
	 * Constructor for StoreStatement.
	 * @param op
	 */
	public StoreStatement(String op)
	{
		super(op);
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString()
	{
		return "store " + getOp();
	}

}
