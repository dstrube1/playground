/**
 * @author dgayler
 *
 */
public class BooleanSymbolData extends SymbolData
{

	private boolean value;
	
	public BooleanSymbolData (String name)
	{
		super (name);
	}
	
	/**
	 * Returns the value.
	 * @return boolean
	 */
	public Object getValue()
	{
		return new Boolean (value);
	}

	/**
	 * Sets the value.
	 * @param value The value to set
	 */
	public void setValue(Object value)
	{
		this.value = ((Boolean)value).booleanValue();
	}


}
