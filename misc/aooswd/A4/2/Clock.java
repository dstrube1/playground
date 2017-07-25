import java.util.*;
import java.text.*;

public class Clock implements Runnable {
    private volatile Thread timer;       // The thread that displays clock
    private int lastxs, lastys, lastxm,
                lastym, lastxh, lastyh;  // Dimensions used to draw hands 
    private SimpleDateFormat formatter;  // Formats the date displayed
    private String lastdate;             // String to hold date displayed
    private Font clockFaceFont;          // Font for number display on clock
    private Date currentDate;            // Used to get date to display
    private Color handColor;             // Color of main hands and dial
    private Color numberColor;           // Color of second hand and numbers

    public void init() {
        int x,y;
        formatter = new SimpleDateFormat ("EEE MMM dd hh:mm:ss yyyy", 
                                          Locale.getDefault());
        currentDate = new Date();
        lastdate = formatter.format(currentDate);
        clockFaceFont = new Font("Serif", Font.PLAIN, 14);
        handColor = Color.blue;
        numberColor = Color.darkGray;

        try {
            setBackground(new Color(Integer.parseInt(getParameter("bgcolor"),
                                                     16)));
        } catch (NullPointerException e) {
        } catch (NumberFormatException e) {
        }
        try {
            handColor = new Color(Integer.parseInt(getParameter("fgcolor1"),
                                                   16));
        } catch (NullPointerException e) {
        } catch (NumberFormatException e) {
        }
        try {
            numberColor = new Color(Integer.parseInt(getParameter("fgcolor2"),
                                                     16));
        } catch (NullPointerException e) {
        } catch (NumberFormatException e) {
        }
        resize(300,300);              // Set clock window size
    }

    // Paint is the main part of the program
    public void paint(Graphics g) {
        int xh, yh, xm, ym, xs, ys;
        int s = 0, m = 10, h = 10;
        int xcenter = 80, ycenter = 55;
        String today;

        currentDate = new Date();
        
        formatter.applyPattern("s");
        try {
            s = Integer.parseInt(formatter.format(currentDate));
        } catch (NumberFormatException n) {
            s = 0;
        }
        formatter.applyPattern("m");
        try {
            m = Integer.parseInt(formatter.format(currentDate));
        } catch (NumberFormatException n) {
            m = 10;
        }    
        formatter.applyPattern("h");
        try {
            h = Integer.parseInt(formatter.format(currentDate));
        } catch (NumberFormatException n) {
            h = 10;
        }
    
        // Set position of the ends of the hands
        xs = (int) (Math.cos(s * Math.PI / 30 - Math.PI / 2) * 45 + xcenter);
        ys = (int) (Math.sin(s * Math.PI / 30 - Math.PI / 2) * 45 + ycenter);
        xm = (int) (Math.cos(m * Math.PI / 30 - Math.PI / 2) * 40 + xcenter);
        ym = (int) (Math.sin(m * Math.PI / 30 - Math.PI / 2) * 40 + ycenter);
        xh = (int) (Math.cos((h*30 + m / 2) * Math.PI / 180 - Math.PI / 2) * 30
                   + xcenter);
        yh = (int) (Math.sin((h*30 + m / 2) * Math.PI / 180 - Math.PI / 2) * 30
                   + ycenter);
    
        // Draw the circle and numbers
        g.setFont(clockFaceFont);
        g.setColor(handColor);
        g.drawArc(xcenter-50, ycenter-50, 100, 100, 0, 360);
        g.setColor(numberColor);
        g.drawString("9", xcenter-45, ycenter+3); 
        g.drawString("3", xcenter+40, ycenter+3);
        g.drawString("12", xcenter-5, ycenter-37);
        g.drawString("6", xcenter-3, ycenter+45);


        // Get the date to print at the bottom
        formatter.applyPattern("EEE MMM dd HH:mm:ss yyyy");
        today = formatter.format(currentDate);

        currentDate = null;
    }

    public void start() {
        timer = new Thread(this);
        timer.start();
    }

    public void stop() {
        timer = null;
    }

    public void run() {
        Thread me = Thread.currentThread();
        while (timer == me) {
            try {
                Thread.currentThread().sleep(100);
            } catch (InterruptedException e) {
            }
            repaint();
        }
    }

    public void update(Graphics g) {
        paint(g);
    }

    public String getAppletInfo() {
        return "Title: A Clock \n"
            + "Author: Rachel Gollub, 1995 \n"
            + "An analog clock.";
    }
  
    public String[][] getParameterInfo() {
        String[][] info = {
            {"bgcolor", "hexadecimal RGB number", 
             "The background color. Default is the color of your browser."},
            {"fgcolor1", "hexadecimal RGB number", 
             "The color of the hands and dial. Default is blue."},
            {"fgcolor2", "hexadecimal RGB number", 
             "The color of the second hand and numbers. Default is dark gray."}
        };
        return info;
    }
}
