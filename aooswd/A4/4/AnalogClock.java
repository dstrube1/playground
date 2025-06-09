/*
* Copyright (c) 1994-1998 Sun Microsystems, Inc. All Rights Reserved.
*
* Permission to use, copy, modify, and distribute this software and its
* documentation for NON-COMMERCIAL or COMMERCIAL purposes and without fee is
* hereby granted. Please refer to the file
* http://java.sun.com/nav/business/trademark_guidelines.html for further
* important copyright and trademark information and to
* http://java.sun.com/nav/business/index.html for further important licensing
* information for the Java (tm) Technology.
* 
* SUN MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF THE
* SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
* IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR
* NON-INFRINGEMENT. SUN SHALL NOT BE LIABLE FOR ANY DAMAGES SUFFERED BY
* LICENSEE AS A RESULT OF USING, MODIFYING OR DISTRIBUTING THIS SOFTWARE OR
* ITS DERIVATIVES.
* 
* THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
* CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE PERFORMANCE,
* SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR
* COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE SUPPORT MACHINES, OR
* WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE SOFTWARE COULD LEAD DIRECTLY TO
* DEATH, PERSONAL INJURY, OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH
* RISK ACTIVITIES"). SUN SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED
* WARRANTY OF FITNESS FOR HIGH RISK ACTIVITIES.
*/

   import java.awt.*;
   import java.util.*;

   public class AnalogClock extends Object
   {
      private ParamParser param;
      private Dimension size;
      private FontMetrics fm;
   
      private Point start;
      private Point cen;
      private int rad;
      private int diam;
   
      private Point[] cn;
      private String[] ns;
   
      private int sr;
      private int mr;
      private int hr;
   
      private double sa = Math.PI / 2;
      private double sda = Math.PI / 30;
      private double mda = sda / 60;
      private double hda = mda / 12;
   
      private Color ccolor;
      private Color ncolor;
      private Color shcolor;
      private Color mhcolor;
      private Color hhcolor;
      private Color bgcolor;
   
      public AnalogClock(Rectangle rect, ParamParser param, FontMetrics fm)
      {
         this.param = param;
         this.fm = fm;
      
         ccolor = param.parseColor("ccolor", Color.lightGray);
         ncolor = param.parseColor("ncolor", Color.black);
         shcolor = param.parseColor("shcolor", Color.red);
         mhcolor = param.parseColor("mhcolor", Color.blue);
         hhcolor = param.parseColor("hhcolor", Color.green);
         bgcolor = param.parseColor("bgcolor", Color.white);
      
         size = new Dimension(rect.width, rect.height);
         diam = Math.min(rect.width, rect.height);
         rad = diam / 2;
         start = new Point(rect.x, rect.y);
         cen = new Point(start.x + rad, start.y + rad);
      
         sr = rad;
         mr = (int) (.9 * rad);
         hr = (int) (.7 * rad);
      
         setClockNumbers((int) ((param.parseInt("nradius", 80) * rad) / 100));
      }
   
      public void draw(Graphics g)
      {
         Date date = new Date();
      
         int s = date.getSeconds();
         int m = date.getMinutes();
         int h = date.getHours() % 12;
      
         int ms = m * 60;
         int hs = h * 60 * 60;
      
      // Clear the background.
      
         g.setColor(bgcolor);
         g.fillRect(start.x, start.y, size.width, size.height);
      
      // Draw the clock circle.
      
         g.setColor(ccolor);
         g.fillOval(start.x, start.y, diam, diam);
      
      // Draw the clock numbers.
      
         g.setColor(ncolor);
         g.drawOval(start.x, start.y, diam, diam);
      
         for (int i = 0; i < cn.length; i++)
         {
            g.drawString(ns[i], cn[i].x, cn[i].y);
         }
      
      // Draw the second hand.
      
         g.setColor(shcolor);
         int sx = (int) ((Math.cos((s * sda) - sa) * sr) + cen.x);
         int sy = (int) ((Math.sin((s * sda) - sa) * sr) + cen.y);
         g.drawLine(cen.x, cen.y, sx, sy);
      
      // Draw the minute hand.
      
         g.setColor(mhcolor);
         int mx = (int) ((Math.cos(((ms + s) * mda) - sa) * mr) + cen.x);
         int my = (int) ((Math.sin(((ms + s) * mda) - sa) * mr) + cen.y);
         g.drawLine(cen.x, cen.y - 1, mx, my);
         g.drawLine(cen.x - 1, cen.y, mx, my);
      
      // Draw the hour hand.
      
         g.setColor(hhcolor);
         int hx = (int) ((Math.cos(((hs + ms + s) * hda) - sa) * hr) + cen.x);
         int hy = (int) ((Math.sin(((hs + ms + s) * hda) - sa) * hr) + cen.y);
         g.drawLine(cen.x, cen.y - 1, hx, hy);
         g.drawLine(cen.x - 1, cen.y, hx, hy);
      	
      	System.out.println(date);
      }
   
      private void setClockNumbers(int r)
      {
         cn = new Point[12];
         ns = new String[12];
         double nda = Math.PI / 6;
      
         ns[0] = "12";
      
         for (int i = 1; i < cn.length; i++)
         {
            ns[i] = Integer.toString(i);
         }
      
         int a = fm.getMaxAscent();
         int h = (fm.getMaxAscent() + fm.getMaxDescent()) / 2;
      
         for (int i = 0; i < cn.length; i++)
         {
            int nx = (int) ((Math.cos((i * nda) - sa) * r) + cen.x);
            int ny = (int) ((Math.sin((i * nda) - sa) * r) + cen.y);
         
            int w = fm.stringWidth(ns[i]) / 2;
            cn[i] = new Point(nx - w, ny + a - h);
         }
      }
   }
