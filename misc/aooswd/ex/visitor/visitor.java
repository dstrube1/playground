/* inventory calculations on Equipment */

public class Equipment
{
	public String Name ()
	{
		return _name;
	}
	public Watt Power ();
	public Currency NetPrice ();
	public Currency DiscountPrice ();
	public void Accept (EquipmentVisitor);
	protected Equipment (String);
	private String _name;
}

public class EquipmentVisitor
{
	public void VisitFloppyDisk (FloppyDisk);
	public void VisitCard (Card);
	public void VisitChassis (Chassis);
	public void VisitBus (Bus);
	protected	EquipmentVisitor ();
}

public class FloppyDisk extends Equipment
{
	public void Accept (EquipmentVisitor visitor)
	{
		visitor.VisitFloppyDisk (this);
	}
}

public class Chassis extends Equipment
{

	public void Accept (EquipmentVisitor visitor)
	{
		for (ListIterator<Equipment> I(_parts); !I.IsDone (); I.Next ())
			I.CurrentItem ().Accept (visitor);
		visitor.VisitChassis (this);
	}
}

public class PricingVisitor extends EquipmentVisitor
{
	public PricingVisitor ();
	public Currency GetTotalPrice ();
	public void VisitFloppyDisk (FloppyDisk)
	{
		_total += e.NetPrice ();
	}
	public void VisitCard (Card);
	public void VisitChassis (Chassis)
	{
		_total += e.DiscountPrice ();
	}
	public void VisitBus (Bus);
	private Currency _total;
}

public class InventoryVisitor extends EquipmentVisitor
{
	public InventoryVisitor ();
	public Inventory GetInventory ();
	public void VisitFloppyDisk (FloppyDisk)
	{
		_inventory.Accumulate (e);
	}
	public void VisitCard (Card);
	public void VisitChassis (Chassis)
	{
		_inventory.Accumulate (e);
	}
	public void VisitBus (Bus);
	private	Inventory _inventory;
};

static void main()
{
	...
	Equipment* component;
	InventoryVisitor visitor;
	component.Accept (visitor);
	System.out.print ("Inventory ");
	System.out.print (component.Name ());
	System.out.print (visitor.GetInventory ());