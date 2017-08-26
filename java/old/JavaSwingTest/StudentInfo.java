import javax.swing.JFrame;
import javax.swing.JOptionPane;

import java.awt.BorderLayout;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

public class StudentInfo extends JFrame {

	public StudentInfo() {
		setLayout(new BorderLayout(5, 10));

		MyTabbedPane tabbedPane = new MyTabbedPane();
		add(tabbedPane);
		
//		add(new TopPanel(), BorderLayout.NORTH);
//		add(new Middle(), BorderLayout.CENTER);
//		add(new Bottom(), BorderLayout.SOUTH);
	}

	public static void main(String[] args) {
		StudentInfo frame = new StudentInfo();
		frame.setTitle("Student Information");
		frame.setSize(400, 300);
		frame.setLocationRelativeTo(null);
		frame.setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);// JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
		frame.addWindowListener(frame.new AreYouSure());
	}

	private class AreYouSure extends WindowAdapter {
		public void windowClosing(WindowEvent e) {
			int option = JOptionPane.showOptionDialog(StudentInfo.this,
					"Are you sure you want to quit?", "Exit Dialog",
					JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE,
					null, null, null);
			if (option == JOptionPane.YES_OPTION) {
				System.exit(0);
			}
		}
	}
}
