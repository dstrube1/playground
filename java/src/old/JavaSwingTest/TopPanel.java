import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Font;

import javax.swing.JLabel;

public class TopPanel extends JLabel {

	public TopPanel() {
		setSize(415, 235);
		setLayout(new FlowLayout());
		final String LABEL = "Student Information";
		setText(LABEL);
		setFont(new Font("Courier New", Font.BOLD, 32));
		setForeground(Color.GRAY);

	}

}
