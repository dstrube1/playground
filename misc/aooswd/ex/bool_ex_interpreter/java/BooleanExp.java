/**
 * @author dgayler
 *
 */
public interface BooleanExp
{

	boolean evaluate (Context con);
	
	String generateCode (Context con);
	
}
