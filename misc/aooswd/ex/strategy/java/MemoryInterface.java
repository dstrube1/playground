/*
 * MemoryInterface.java
 *
 * Created on January 23, 2003, 1:55 PM
 */

/**
 *
 * @author  dgayler
 */
public class MemoryInterface
{
    private MemoryManager manager;
    
    /** Creates a new instance of MemoryInterface */
    public MemoryInterface() throws AddressOrderException
    {
        manager = new MemoryManager (new FirstFitAllocation());
    }
    
    public void allocate (int size) throws AddressOrderException
    {
        manager.allocate (size);
    }
    
    public void deallocate (MemoryBlock b) throws AddressOrderException
    {
        manager.deallocate(b);
    }
    
    public void displayMemory ()
    {
        manager.displayMemory();
    }
    
    public void changeAllocation (int choice)
    {
        MemoryAllocation a;
        if (choice == 1)
            a = new BestFitAllocation();
        else if (choice == 2)
            a = new WorstFitAllocation ();
        else if (choice == 3)
            a = new FirstFitAllocation ();
        else
            a = new RandomFitAllocation();
        manager.changeAllocation(a);
    }
    
    public boolean isSuccessful()
    {
        return manager.isSuccessful();
    }
    
    public MemoryBlock getAllocatedBlock()
    {
        return manager.getAllocatedBlock();
    }
    
}
