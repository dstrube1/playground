/*
 * RandomAllocation.java
 *
 * Created on January 23, 2003, 12:04 PM
 */

import java.util.List;
import java.util.Random;

/**
 *
 * @author  dgayler
 */
public class RandomFitAllocation extends MemoryAllocation
{
    
    private Random numHitGenerator;
    
    private final int hitLimit = 6;
    
    /** Creates a new instance of RandomAllocation */
    public RandomFitAllocation()
    {
        numHitGenerator = new Random();
    }
    
    public void allocate(List l, int size) throws AddressOrderException
    {
        success = false;
        if (!l.isEmpty())
        {
            int position = 0;
            int choice = 0;
            int numHits = 0;
            int maxHits = 1 + numHitGenerator.nextInt() % (hitLimit + 1);
            while (position < l.size() && numHits < maxHits)
            {
                if (((MemoryBlock)l.get(position)).size() >= size)
                {
                    numHits++;
                    if (!success)
                    {
                        success = true;
                        choice = position;
                    }
                    else if (((MemoryBlock)l.get(position)).size() < ((MemoryBlock)l.get(choice)).size())
                        choice = position;
                }
                position++;
                if (success)
                    allocateBlock (l, size, choice);
            }
        }
    }

}
