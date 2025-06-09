import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Vector;

/**
 * @author dgayler
 *
 */
public class SymbolTable
{

	private Vector table;

	public SymbolTable()
	{
		table = new Vector();
	}

	public void insert(SymbolData data)
	{
		table.addElement((data));
	}

	public void setValue(String name, Object value)
	{
		int index = getIndexOf(name);
		((SymbolData) table.elementAt(index)).setValue(value);
	}

	public Object getValue(String name)
	{
			int index = getIndexOf(name);
			SymbolData data = (SymbolData) table.elementAt(index);
			return data.getValue();
	}

	private int getIndexOf(String name)
	{
		int index = 0;
		while (index < table.size()
			&& !name.equals(((SymbolData) table.elementAt(index)).getName()))
			index++;
		return index;
	}

}
