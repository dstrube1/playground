public abstract class Equipment
{
    public Equipment (String name);
    public String Name();
    public Watt Power();
    public Currency NewPrice();
    public Currency DiscountPrice();
    public void Add (Equipment e);
    public void Remove (Equipment e);
    public Iterator CreateIterator();
    private String name;
}


public class FloppyDisk extends Equipment
{
    public FloppyDisk (String name);
    public Watt Power ();
    public Currency NetPrice ();
    public Currency DiscountPrice ();
}

public class CompositeEquipment extends Equipment
{
    protected CompositeEquipment (String name);
    public Watt Power ();
    public Currency NetPrice ()
    {
	ListIterator I = equipment.iterator();
	Currency total = 0;
	while (I.hasNext())
	    total += I.next().NetPrice ();
	return total;
    }
    public Currency DiscountPrice ();
    public void Add (Equipment*);
    public void Remove (Equipment*);
    public Iterate <Equipment*>* CreateIterator;
    private  List equipment;
}

public class Chassis extends CompositeEquipment
{
    public Chassis (String name);
    public Watt Power ();
    public Currency NetPrice ();
    public Currency DiscountPrice ();
}

public static void main (String[] args)
{
    Cabinet cabinet = new Cabinet ("PC Cabinet");
    Chassis chassis = new Chassis ("PC Chassis");
    cabinet.Add (chassis);
    Bus bus = new Bus ("MCA Bus");
    bus.Add (new Card ("16Mbs Token Ring"));
    chassis. Add (bus);
    chassis. Add (new FloppyDisk ("3.5in Floppy"));
    System.out.println ("The net price is " + chassis.NetPrice ());
}
