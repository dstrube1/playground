//inventory calculations on Equipment

class Equipment
{
public:
	virtual ~Equipment ();
	const char* Name () {return _name;}
	virtual Watt Power ();
	virtual Currency NetPrice ();
	virtual Currency DiscountPrice ();
	virtual void Accept (EquipmentVisitor&);
protected:
	Equipment (const char*);
private:
	const char* _name;
};

class EquipmentVisitor
{
public:
	virtual ~EquipmentVisitor ();
	virtual void VisitFloppyDisk (FloppyDisk*);
	virtual void VisitCard (Card*);
	virtual void VisitChassis (Chassis*);
	virtual void VisitBus (Bus*);
protected:
	EquipmentVisitor ();
};

void FloppyDisk::Accept (EquipmentVisitor& visitor)
{
	visitor.VisitFloppyDisk (this);
}

void Chassis::Accept (EquipmentVisitor& visitor)
{
	for (ListIterator<Equipment*> I(_parts); !I.IsDone (); I.Next ())
		I.CurrentItem () -> Accept (visitor);
	visitor.VisitChassis (this);
}

class PricingVisitor : public EquipmentVisitor
{
public:
	PricingVisitor ();
	Currency& GetTotalPrice ();
	virtual void VisitFloppyDisk (FloppyDisk*);
	virtual void VisitCard (Card*);
	virtual void VisitChassis (Chassis*);
	virtual void VisitBus (Bus*);
private:
	Currency _total;
};

void PricingVisitor::VisitFloppyDisk (FloppyDisk* e)
{
	_total += e -> NetPrice ();
}

void PricingVisitor::VisitChassis (Chassis* e)
{
	_total += e -> DiscountPrice ();
}

class InventoryVisitor : public EquipmentVisitor
{
public:
	InventoryVisitor ();
	Inventory& GetInventory ();
	virtual void VisitFloppyDisk (FloppyDisk*);
	virtual void VisitCard (Card*);
	virtual void VisitChassis (Chassis*);
	virtual void VisitBus (Bus*);
private:
	Inventory _inventory;
};

void InventoryVisitor::VisitFloppyDisk (FloppyDisk* e)
{
	_inventory.Accumulate (e);
}

void InventoryVisitor::VisitChassis (Chassis* e)
{
	_inventory.Accumulate (e);
}

Equipment* component;
InventoryVisitor visitor;
component -> Accept (visitor);
cout << "Inventory " << component -> Name (); << visitor.GetInventory ();