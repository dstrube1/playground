/*
 * TestMem.java
 *
 * Created on January 23, 2003, 2:23 PM
 */

/**
 *
 * @author  dgayler
 */
public class TestMem
{
    
    /** Creates a new instance of TestMem */
    public TestMem()
    {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args)
    {
        try
        {
            MemoryInterface memory = new MemoryInterface();
            memory.displayMemory();
            memory.allocate(40);
            MemoryBlock b1 = memory.getAllocatedBlock();
            memory.displayMemory();
            memory.allocate(16);
            MemoryBlock b2 = memory.getAllocatedBlock();
            memory.displayMemory();
            memory.deallocate (b1);
            memory.displayMemory();
            memory.deallocate(b2);
            memory.displayMemory();
        }
        catch (AddressOrderException e)
        {
            System.out.println(e.getMessage());
        }
    }
    
}
