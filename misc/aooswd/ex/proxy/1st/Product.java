/**
 * @author dgayler
 *
 * To change this generated comment edit the template variable "typecomment":
 * Window>Preferences>Java>Templates.
 * To enable and disable the creation of type comments go to
 * Window>Preferences>Java>Code Generation.
 */
public class Product
{

	private int itsPrice;

	public Product(String name, int price)
	{
		itsPrice = price;
	}

	/**
	 * Returns the itsPrice.
	 * @return int
	 */
	public int getPrice()
	{
		return itsPrice;
	}

}
