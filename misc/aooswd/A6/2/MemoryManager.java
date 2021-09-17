/*
 * MemoryManager.java
 *
 * Created on January 23, 2003, 12:17 PM
 */

import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author  dgayler
 */
public class MemoryManager
{
    private List l;
    
    private MemoryAllocation allocation;
    
    /** Creates a new instance of MemoryManager */
    public MemoryManager(MemoryAllocation allocationChoice) throws AddressOrderException
    {
        allocation = allocationChoice;
        l = new ArrayList();
        l.add (new MemoryBlock (0, 9999));
    }
    
    public void allocate (int size) throws AddressOrderException
    {
        allocation.allocate(l, size);
    }
    
    public void displayMemory()
    {
        System.out.println (l.toString());
    }
    
    public void changeAllocation (MemoryAllocation newAllocation)
    {
        allocation = newAllocation;
    }

    private void coalesceFront (int position, MemoryBlock b) throws AddressOrderException
    {
        ((MemoryBlock)l.get(position)).setLower(b.getLower());
    }

    private void coalesceRear (int position, MemoryBlock b) throws AddressOrderException
    {
        ((MemoryBlock)l.get(position)).setUpper(b.getUpper());
    }
    
    private void coalesceBoth (int position) throws AddressOrderException
    {
        int upper = ((MemoryBlock)l.get(position + 1)).getUpper();
        ((MemoryBlock)l.get(position)).setUpper(upper);
        l.remove (position + 1);
    }

    private void insertBefore (int position, MemoryBlock b) throws AddressOrderException
    {
        if (position == 0)
            if (b.getUpper() + 1 == ((MemoryBlock)l.get(position)).getLower())
                coalesceFront (position, b);
            else
                l.add (position, b);
        else if (b.getUpper() + 1 == ((MemoryBlock)l.get(position)).getLower())
            coalesceBoth (position - 1);
        else
            coalesceRear (position - 1, b);
    }

    public void deallocate(MemoryBlock block) throws AddressOrderException
    {
        int position = 0;
        while (position < l.size() && block.getUpper() >= ((MemoryBlock)l.get(position)).getLower())
            position++;
        if (position == l.size())
            l.add (block);
        else
            insertBefore (position, block);
    }
    
    public MemoryBlock getAllocatedBlock()
    {
        return allocation.getAllocatedBlock();
    }
    
    public boolean isSuccessful()
    {
        return allocation.isSuccessful();
    }
    
 }
