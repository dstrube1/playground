/**
 * @author dgayler
 *
 */
public class OrExp implements BooleanExp
{

	private BooleanExp left;
	
	private BooleanExp right;
	
	public OrExp (BooleanExp left, BooleanExp right)
	{
		this.left = left;
		this.right = right;
	}
	
	/**
	 * @see BooleanExp#Evaluate(Context)
	 */
	public boolean evaluate(Context con)
	{
		return left.evaluate (con) || right.evaluate (con);
	}

	/**
	 * @see BooleanExp#generateCode(Context)
	 */
	public String generateCode(Context con)
	{
		String leftName = left.generateCode (con);
		String rightName = right.generateCode (con);
		con.addCodeStatement(new LoadStatement (leftName));
		con.addCodeStatement(new OrStatement (rightName));
		String temp = con.getTemp();
		con.addCodeStatement (new StoreStatement (temp));
		return temp;
	}
	
}
