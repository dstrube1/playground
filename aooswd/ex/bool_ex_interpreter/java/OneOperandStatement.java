/**
 * @author Dick Gayler
 *
 */
public abstract class OneOperandStatement implements CodeStatement
{

	private String op;
	
	/**
	 * Constructor for OneOperandStatement.
	 */
	public OneOperandStatement(String op)
	{
		this.op = op;
	}


	/**
	 * Returns the op.
	 * @return String
	 */
	public String getOp()
	{
		return op;
	}

}
