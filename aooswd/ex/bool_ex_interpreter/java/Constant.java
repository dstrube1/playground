/**
 * @author dgayler
 *
 */
public class Constant implements BooleanExp
{

	private boolean value;
	
	public Constant (boolean value)
	{
		this.value = value;;
	}
		
	/**
	 * @see BooleanExp#Evaluate(Context)
	 */
	public boolean evaluate(Context con)
	{
		return value;
	}

	/**
	 * @see BooleanExp#generateCode(Context)
	 */
	public String generateCode(Context con)
	{
		return "#" + new Boolean(value).toString();
	}

}
