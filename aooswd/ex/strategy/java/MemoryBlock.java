/*
 * MemoryBlock.java
 *
 * Created on January 23, 2003, 10:42 AM
 */

/**
 *
 * @author  dgayler
 */
public class MemoryBlock
{
    
    private int lower;
    
    private int upper;
    
    /** Creates a new instance of MemoryBlock */
    public MemoryBlock(int lower, int upper) throws AddressOrderException
    {
        if (upper < lower || lower < 0 || upper < 0)
            throw new AddressOrderException ("invalid block size");
        this.lower = lower;
        this.upper = upper;
    }
    
    public int size()
    {
        return upper - lower + 1;
    }
    
    /** Getter for property lower.
     * @return Value of property lower.
     */
    public int getLower()
    {
        return lower;
    }
    
    /** Getter for property upper.
     * @return Value of property upper.
     */
    public int getUpper()
    {
        return upper;
    }
    
    /** Setter for property lower.
     * @param lower New value of property lower.
     */
    public void setLower(int lower) throws AddressOrderException
    {
        if (lower > upper)
             throw new AddressOrderException ("invalid block size");       
        this.lower = lower;
    }
    
    /** Setter for property upper.
     * @param upper New value of property upper.
     */
    public void setUpper(int upper) throws AddressOrderException
    {
        if (upper < lower)
             throw new AddressOrderException ("invalid block size");       
        this.upper = upper;
    }
    
    public String toString()
    {
        return "[" + lower + "," + upper + "]";
    }
    
}
