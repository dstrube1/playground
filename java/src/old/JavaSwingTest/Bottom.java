//import java.awt.GraphicsConfiguration;
import java.awt.GridLayout;
//import java.awt.HeadlessException;

import java.awt.event.ActionListener;
import java.awt.event.ComponentListener;
import java.awt.event.ContainerListener;
import java.awt.event.FocusListener;
import java.awt.event.HierarchyBoundsListener;
import java.awt.event.HierarchyListener;
import java.awt.event.InputMethodListener;
import java.awt.event.ItemListener;
import java.awt.event.KeyListener;
import java.awt.event.MouseListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.beans.PropertyChangeListener;
import java.beans.VetoableChangeListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
//import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.event.AncestorListener;
import javax.swing.event.ChangeListener;

public class Bottom extends JPanel {

	private JFrame app;

	public Bottom(){//JFrame jframe) {

//		app = jframe;
		JPanel mp1 = new JPanel();// new FlowLayout(FlowLayout.LEFT, 1, 1));
		JPanel mp2 = new JPanel();// new FlowLayout(FlowLayout.LEFT, 3, 2));
		JButton bOne = new JButton("Find ");
		JButton bTwo = new JButton("Insert");
		JButton bThree = new JButton("Delete");
		JButton bFour = new JButton("Update ");
		JButton bFive = new JButton("Exit");
		// ActionListener, ComponentListener, AncestorListener, ChangeListener,
		// ContainerListener, FocusListener, HierarchyBoundsListener,
		// HierarchyListener, InputMethodListener, ItemListener,
		//KeyListener, MouseListener, PropertyChangeListener,
		//VetoableChangeListener
//		bFive.addFocusListener((FocusListener) new AreYouSure());
//		bFive.addHierarchyBoundsListener((HierarchyBoundsListener) new AreYouSure());
//		bFive.addHierarchyListener((HierarchyListener) new AreYouSure());
//		bFive.addInputMethodListener((InputMethodListener) new AreYouSure());
//		bFive.addItemListener((ItemListener) new AreYouSure());
//		bFive.addKeyListener((KeyListener) new AreYouSure());
//		bFive.addMouseListener((MouseListener) new AreYouSure());
//		bFive.addPropertyChangeListener((PropertyChangeListener) new AreYouSure());
//		bFive.addVetoableChangeListener((VetoableChangeListener) new AreYouSure());
		

		mp1.add(bOne);
		mp1.add(bTwo);
		mp1.add(bThree);
		mp1.add(bFour);
		mp1.add(bFive);

		setLayout(new GridLayout(2, 1, 5, 5));
		add(mp1);

	}

//	private class AreYouSure extends WindowAdapter {
//		public void windowClosing(WindowEvent e) {
//			int option = JOptionPane.showOptionDialog(app,
//					"Are you sure you want to quit?", "Exit Dialog",
//					JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE,
//					null, null, null);
//			if (option == JOptionPane.YES_OPTION) {
//				System.exit(0);
//			}
//		}
//	}

}
