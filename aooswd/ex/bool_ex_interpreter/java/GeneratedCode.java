import java.util.Vector;

/**
 * @author Dick Gayler
 *
 */
public class GeneratedCode
{
	
	private Vector code;
	
	public GeneratedCode ()
	{
		code = new Vector();
	}

	public void add (CodeStatement stmt)
	{
		code.add(stmt);
	}
	
	public Vector getGeneratedCode ()
	{
		return code;
	}
	
}
