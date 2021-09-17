   import java.applet.Applet;
   import java.applet.AppletContext;
   import java.awt.*;
   import java.io.PrintStream;
   import java.net.MalformedURLException;
   import java.net.URL;
   import java.util.*;

   public class Clock extends Applet
   {
   
      String printtijd;
      int IntClocktype;
      String hh;
      String mm;
      String ss;
      String clocktype;
      Image offscreenImg;
      Graphics offscreen;
      int fontKleur;
      String hhmm;
      String hhmmss;
      Color kleurArray[] = {
         new Color(255, 255, 255), new Color(255, 255, 127), new Color(255, 255, 0), new Color(255, 127, 0), new Color(255, 0, 0), new Color(127, 0, 0), new Color(255, 127, 255), new Color(255, 0, 255), new Color(127, 0, 255), new Color(0, 0, 255), 
         new Color(0, 0, 127), new Color(0, 255, 255), new Color(0, 255, 127), new Color(0, 255, 0), new Color(0, 127, 0), new Color(0, 0, 0)
      };
      Font f;
   
      public void init()
      {
         String s = getParameter("font");
         String s1 = null;
         String s2 = null;
         String s3 = null;
         String s4 = null;
         String s5 = null;
         String s6 = null;
         int i = 0;
         int j = 0;
         int k = 0;
         if(s == null)
         {
            s = "TimesRoman";
         }
         s1 = getParameter("fontset");
         if(s1 == null)
         {
            s = "361";
         }
         clocktype = getParameter("clocktype");
         if(clocktype == null)
         {
            clocktype = "0";
         }
         IntClocktype = Integer.parseInt(clocktype);
         s2 = getParameter("colors");
         if(s2 == null)
         {
            s2 = "0015";
         }
         s3 = s1.substring(0, 2);
         s4 = s1.substring(2, 3);
         s5 = s2.substring(0, 2);
         s6 = s2.substring(2, 4);
         i = Integer.parseInt(s3);
         j = Integer.parseInt(s4);
         fontKleur = Integer.parseInt(s5);
         k = Integer.parseInt(s6);
         setBackground(kleurArray[k]);
         f = new Font(s, j, i);
         bepaalTijd();
      }
   
      void bepaalTijd()
      {
         Date date = new Date();
         GregorianCalendar gregoriancalendar = new GregorianCalendar();
         int i = 0;
         int j = 0;
         int k = 0;
         ((Calendar)gregoriancalendar).setTime(date);
         i = ((Calendar)gregoriancalendar).get(11);
         j = ((Calendar)gregoriancalendar).get(12);
         k = ((Calendar)gregoriancalendar).get(13);
         hh = String.valueOf(i);
         if(hh.length() == 1)
         {
            hh = "0" + hh;
         }
         mm = String.valueOf(j);
         if(mm.length() == 1)
         {
            mm = "0" + mm;
         }
         ss = String.valueOf(k);
         if(ss.length() == 1)
         {
            ss = "0" + ss;
         }
         hhmm = String.valueOf(hh) + ":" + mm;
         hhmmss = String.valueOf(hhmm) + ":" + ss;
         if(IntClocktype == 1)
         {
            printtijd = hhmmss;
         }
         if(IntClocktype == 0)
         {
            printtijd = hhmm;
         }
         offscreenImg = createImage(size().width, size().height);
         offscreen = offscreenImg.getGraphics();
         offscreen.setFont(f);
         offscreen.setColor(kleurArray[fontKleur]);
         int l = size().height / 10;
         offscreen.drawString(printtijd, 2, size().height - l);
         repaint();
      }
   
      public void update(Graphics g)
      {
         paint(g);
      }
   
      public void paint(Graphics g)
      {
         g.drawImage(offscreenImg, 0, 0, this);
         pause(100);
         bepaalTijd();
      }
   
      public boolean mouseDown(Event event, int i, int j)
      {
         try
         {
            URL url = new URL("http://home.wxs.nl/~gwbrink/JavaClockMaker.htm");
            getAppletContext().showDocument(url);
         }
            catch(MalformedURLException _ex)
            {
               System.out.println("Bad clockURL: http://home.wxs.nl/~gwbrink/JavaClockMaker.htm");
            }
         return true;
      }
   
      void pause(int i)
      {
         try
         {
            Thread.sleep(i);
            return;
         }
            catch(InterruptedException _ex)
            {
               return;
            }
      }
   
      public Clock()
      {
         hhmm = "00:00";
         hhmmss = "00:00:00";
         f = new Font("TimesRoman", 3, 1);
      }
   }
