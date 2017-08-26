import java.awt.BorderLayout;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;

public class MyTabbedPane extends JTabbedPane {

	private JPanel panel1;
	private JPanel panel2;

	public MyTabbedPane() {
		// Create the tab pages
		createPage1();
		createPage2();
		
		addTab( "1", panel1 );
		addTab( "2", panel2 );
	}

	private void createPage1() {
		panel1 = new JPanel();
		panel1.setLayout( new BorderLayout() );
		panel1.add(new TopPanel(), BorderLayout.NORTH);
		panel1.add(new Middle(), BorderLayout.CENTER);
		panel1.add(new Bottom(), BorderLayout.SOUTH);
	}
	private void createPage2() {
		panel2 = new JPanel();
		JLabel label = new JLabel();
		final String LABEL = "Hello";
		label.setText(LABEL);
		panel2.add(label);
		
	}

}
