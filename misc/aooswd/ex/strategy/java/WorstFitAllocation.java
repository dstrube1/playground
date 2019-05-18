/*
 * WorstFitAllocation.java
 *
 * Created on January 23, 2003, 11:56 AM
 */

import java.util.List;

/**
 *
 * @author  dgayler
 */
public class WorstFitAllocation extends MemoryAllocation
{
    
    /** Creates a new instance of WorstFitAllocation */
    public WorstFitAllocation()
    {
    }
    
    public void allocate(List l, int size) throws AddressOrderException
    {
        success = false;
        if (!l.isEmpty())
        {
            int position = 0;
            int worst = 0;
            while (position < l.size())
            {
                if (((MemoryBlock)l.get(position)).size() >= size)
                    if (!success)
                    {
                        success = true;
                        worst = position;
                    }
                    else if (((MemoryBlock)l.get(position)).size() > ((MemoryBlock)l.get(worst)).size())
                        worst = position;
                position++;
            }
            if (success)
                allocateBlock(l, size, worst);
        }
    }

}
