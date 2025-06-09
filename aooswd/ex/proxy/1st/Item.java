/**
 * @author dgayler
 *
 */
public class Item
{

	private Product p;
	
	private int qty;
		
	public Item (Product p, int qty)
	{
		this.p = p;
		this.qty = qty;
	}
	
	/**
	 * @return Product
	 */
	public Product getProduct()
	{
		return p;
	}

	/**
	 * @return int
	 */
	public int getQuantity()
	{
		return qty;
	}

}
