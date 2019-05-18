/**
 * @author dgayler
 *
 */
public class NotExp implements BooleanExp
{

	private BooleanExp child;
	
	public NotExp (BooleanExp child)
	{
		this.child = child;
	}
	
	/**
	 * @see BooleanExp#Evaluate(Context)
	 */
	public boolean evaluate(Context con)
	{
		return !child.evaluate(con);
	}

	/**
	 * @see BooleanExp#generateCode(Context)
	 */
	public String generateCode(Context con)
	{
		String childName = child.generateCode (con);
		con.addCodeStatement(new LoadStatement (childName));
		con.addCodeStatement (new NotStatement());
		String temp = con.getTemp();
		con.addCodeStatement (new StoreStatement (temp));
		return temp;
	}

}
