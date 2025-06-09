/*
 * FirstFitAllocation.java
 *
 * Created on January 23, 2003, 11:46 AM
 */

import java.util.List;

/**
 *
 * @author  dgayler
 */
public class FirstFitAllocation extends MemoryAllocation
{
    
    /** Creates a new instance of FirstFitAllocation */
    public FirstFitAllocation()
    {
    }
    
    public void allocate(List l, int size) throws AddressOrderException
    {
        int i = 0;
        while (i < l.size() && ((MemoryBlock)l.get(i)).size() < size)
            i++;
        success = i < l.size();
        if (success)
            allocateBlock (l, size, i);
    }

}
