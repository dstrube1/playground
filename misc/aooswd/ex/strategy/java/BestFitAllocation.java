/*
 * BestFitAllocation.java
 *
 * Created on January 23, 2003, 11:25 AM
 */

import java.util.List;

/**
 *
 * @author  dgayler
 */
public class BestFitAllocation extends MemoryAllocation
{
    
    /** Creates a new instance of BestFitAllocation */
    public BestFitAllocation()
    {
    }
      
    public void allocate(List l, int size) throws AddressOrderException
    {
        success = false;
        if (!l.isEmpty())
        {
            int position = 0;
            int best = 0;
            while (position < l.size())
            {
                if (((MemoryBlock)l.get(position)).size() >= size)
                    if (!success)
                    {
                        success = true;
                        best = position;
                    }
                    else if (((MemoryBlock)l.get(position)).size() < ((MemoryBlock)l.get(best)).size())
                        best = position;
                position++;
            }
            if (success)
                allocateBlock (l, size, best);
        }
    }

}
