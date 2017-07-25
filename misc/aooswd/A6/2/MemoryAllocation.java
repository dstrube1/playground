/*
 * MemoryAllocation.java
 *
 * Created on January 23, 2003, 10:59 AM
 */

import java.util.List;
/**
 *
 * @author  dgayler
 */
public abstract class MemoryAllocation
{
    
    protected boolean success;
    
    protected MemoryBlock allocatedBlock;
    
    /** Creates a new instance of MemoryAllocation */
    public MemoryAllocation()
    {
        success = false;
    }
    
    public abstract void allocate (List l, int size) throws AddressOrderException;
    
    public boolean isSuccessful()
    {
        return success;
    }
    
    public MemoryBlock getAllocatedBlock ()
    {
        return allocatedBlock;
    }

    protected void allocateBlock (List l, int size, int position) throws AddressOrderException
    {
        if (size == ((MemoryBlock)l.get(position)).size())
        {
            allocatedBlock = (MemoryBlock)l.get(position);
            l.remove (position);
        }
        else
        {
            int addr = ((MemoryBlock)l.get(position)).getLower();
            allocatedBlock = new MemoryBlock (addr, addr + size - 1);
            ((MemoryBlock)l.get(position)).setLower (addr + size);
        }
    }

}
