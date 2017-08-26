//import java.awt.GraphicsConfiguration;
import java.awt.GridLayout;
//import java.awt.HeadlessException;


//import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;


public class Middle extends JPanel {
	
	public Middle () {
		setLayout(new GridLayout(5,2));



		add(new JLabel("ID:..........................................................."));
		add(new JTextField(10));
		add(new JLabel("First Name:.........................................."));
		add(new JTextField(10));
		add(new JLabel("Last Name:.........................................."));
		add(new JTextField(10));
		add(new JLabel("Email:...................................................."));
		add(new JTextField(10));
		add(new JLabel("GPA:......................................................"));
		add(new JTextField(5));
		}


}
