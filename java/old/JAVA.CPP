// Class Part for Point of sale terminal simulation
// Created: 22:04, 11/20/97
// Modified: 21:21, 12/29/97

import java.io.*;
import java.sql.*;

/**
 *  A <code>Part</code> object represents the information kept
 *  about one kind of item in stock.
 *  <br> The data represented for each part:
 *  <dl>
 *  <dt> <code>number</code> <dd> The part number.  
 *          Unique for each part.
 *  <dt> <code>name</code> 
 *  <dd> A description of the part.  Up to 25 characters.
 *
 *  <dt> <code> price</code>
 *  <dd>The unit price of this item.
 * 
 *  <dt> <code> discountLevel</code>
 *  <dd> The number of items bought at which the customer gets a
 *  discount.
 *
 *  <dt> <code> discountAmount</code>
 *  <dd> The amount of the discount, given as a decimal.
 *
 *  <dt> <code> numberOnHand</code>
 *  <dd> The number of the item currently in stock.
 *
 *  <dt> <code> reorderLevel</code>
 *  <dd> If the number of items on hand falls below this  amount,
 *  reorder the item.
 *
 *  <dt> <code> reorderAmount</code>
 *  <dd> The number to reorder at any one time.
 *  </dl>
 *  @author Ben Setzer, Kennesaw State University
 */
public class Part
{
//	private final int nameLength = 25;
	private int partID;				// part number
	private String name;			// description of part
	private float price;			// unit price
	private int discountLevel;		// number at which discount applies
	private float discountAmount;	// amount of discount, as a decimal
	private int numberOnHand;
	private int reorderLevel;		// reorder
									// if numberOnHand < reorderLevel
	private int reorderAmount;		// how many to reorder

	 /**
	  *  Creates a <code>Part</code> with all fields filled
	  */
	 public Part( int number, String name, float price,
				int discountLevel, float discountAmount,
				int numberOnHand,
				int reorderLevel, int reorderAmount )
	{
		this.partID = number;
		this.name = name;
		this.price = price;
		this.discountLevel = discountLevel;
		this.discountAmount = discountAmount;
		this.numberOnHand = numberOnHand;
		this.reorderLevel = reorderLevel;
		this.reorderAmount = reorderAmount;
	}

	 /**
	  *  Creates a multi-line string with all data from the
	  *  object.
	  */
	public String toString()
	{
		return "(" + partID + ") " +  name + " @ " + price + "\n"
			+ " discount level: " + discountLevel
			+ " discount amount: " + discountAmount + "\n"
			+ " on hand: " + numberOnHand
			+ " reorder at: "  + reorderLevel
			+ " reorder amount: " + reorderAmount;
	}

	 /**
	  *  Removes <code> n</code> items from inventory if they are
	  *  available.
	  *  <br> If the number left falls below the reorder level,
	  *      more items are ordered
	  */
	public void withdraw( int n )
	{
		if( numberOnHand >= n ) {
			numberOnHand -= n;
			if( numberOnHand <= reorderLevel )
				reorder();
		}
	}

	 /**
	  *  Restocks the inventory of the part.
	  *  Uses the member data <code>reorderAmount</code> to
	  *  determine how much to order.
	  */
	public void reorder()
	{
		numberOnHand += reorderAmount;
	}


	public int getPartID() { return partID; }
	public String getName() { return name; }
	public float getPrice() { return price; }
	public int getDiscountLevel() { return discountLevel; }
	public float getDiscountAmount() { return discountAmount; }
	public int getNumberOnHand() { return numberOnHand; }
	public int getReorderLevel() { return reorderLevel; }
	public int getReorderAmount() { return reorderAmount; }


	/**
		* Used for the <code>Hashtable</code> functions
		*/
	public int hashCode()
	{
		return partID;
	}

	 /**
	  *  Used for the <code> Hashtable</code> functions.
	  *  Two <code>Partt</code>s are considered the same if they
	  *  have the same part number.
	  */
	public boolean equals( Object o )
	{
		return (o instanceof Part) && (((Part)o).partID == partID);
	}

	 /**
	  *    This function takes a result set and gets out the
	  *    various fields, returning a new Part object
	  */
	 public static Part fromResultSet( ResultSet rs )
	 {
		  try {
				int partID = rs.getInt(1);
				String name = rs.getString(2);
				float price = rs.getFloat(3);
				int discountLevel = rs.getInt(4);
				float discountAmount = rs.getFloat(5);
				int numberOnHand = rs.getInt(6);
				int reorderLevel = rs.getInt(7);
				int reorderAmount = rs.getInt(8);
				return new Part(partID,name,price,discountLevel,
						  discountAmount, numberOnHand, reorderLevel,
						  reorderAmount);
		  }
		  catch( SQLException sqle ) {
				System.out.println("Error creating Part: " + sqle);
				return null;
		  }
	 }


	 // Create the sequel command string to add the part
	 // pre:     tableName is the name of the table into which the
	 //          part will be inserted
	 // post:    returns sql command to do the insertion
	 public String composeInsertCommand( String tableName )
	 {
		  String cmd = "insert into " + tableName
				+ "(partID, name, price, discountLevel, discountAmount,"
				+ " numberOnHand, reorderLevel, reorderAmount)"
				+ " values (";
		  cmd = cmd + partID + ",";
		  cmd = cmd + "'" + name + "'" +  ",";
		  cmd = cmd + price + ",";
		  cmd = cmd + discountLevel+ ",";
        cmd = cmd + discountAmount + ",";
        cmd = cmd + numberOnHand + ",";
        cmd = cmd + reorderLevel + ",";
        cmd = cmd + reorderAmount;
        cmd = cmd + ")";
        return cmd;
    }

    /**
     *  Creates a string for the dump tables program
     *  object.
     */
	public String dump()
	{
		return partID + " \"" +  name + "\" " 
            + price + " "
			+ discountLevel + " "
			+ discountAmount + " "
			+ numberOnHand + " "
			+ reorderLevel + " "
			+ reorderAmount +"\n";
	}
   
    /* 
     * loads a part from a StreamTokenizer
     */
    public static Part load( StreamTokenizer st )
        throws IOException
    {
        Part p = null;
        int partID = loadInt(st);
        String name = loadString(st);
        float price = (float)loadDouble(st);
        int discountLevel = loadInt(st);
        float discountAmount = (float)loadDouble(st);
        int numberOnHand = loadInt(st);
        int reorderLevel = loadInt(st);
        int reorderAmount = loadInt(st);
        return new Part(partID,name,price,discountLevel,
                discountAmount,numberOnHand,
                reorderLevel,reorderAmount);
    }

    private static double loadDouble(StreamTokenizer st)
        throws IOException
    {
        int type = st.nextToken();
        if( type != StreamTokenizer.TT_NUMBER )
            throw new IOException("Invalid load file format");
        return st.nval;
    }

    private static int loadInt( StreamTokenizer st)
        throws IOException
    {
        int type = st.nextToken();
        if( type != StreamTokenizer.TT_NUMBER )
            throw new IOException("Invalid load file format");
        return (int)st.nval;
    }

    private static String loadString( StreamTokenizer st)
        throws IOException
    {
        int type = st.nextToken();
        if( type != '"' )
            throw new IOException(
                "Invalid load file format, string expected");
        return st.sval;
    }
}

