/*
 * AddressOrderException.java
 *
 * Created on January 23, 2003, 10:47 AM
 */

/**
 *
 * @author  dgayler
 */
public class AddressOrderException extends java.lang.Exception
{
    
    /**
     * Creates a new instance of <code>AddressOrderException</code> without detail message.
     */
    public AddressOrderException()
    {
    }
    
    
    /**
     * Constructs an instance of <code>AddressOrderException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public AddressOrderException(String msg)
    {
        super(msg);
    }
}
