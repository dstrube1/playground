/**
 * @author Dick Gayler
 *
 */
public class TempVarFactory
{

	private int num;
	
	public TempVarFactory ()
	{
		num = 0;
	}
	
	String getTemp ()
	{
		num++;
		return "temp" + num;
	}
}
