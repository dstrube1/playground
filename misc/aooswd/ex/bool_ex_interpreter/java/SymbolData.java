/**
 * @author dgayler
 *
 */
public abstract class SymbolData
{

	private String name;
	
	public SymbolData (String name)
	{
		this.name = name;
	}
	
	public abstract Object getValue();
	
	public abstract void setValue (Object value);
	
	/**
	 * Returns the name.
	 * @return String
	 */
	public String getName()
	{
		return name;
	}

}
