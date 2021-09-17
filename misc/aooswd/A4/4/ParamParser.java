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

import java.applet.*;
import java.awt.*;
import java.util.*;

public class ParamParser extends Object
{
   public CustomParser parser;
   private Applet applet;

   public ParamParser(Applet applet)
   {
      this.applet = applet;
      parser = new CustomParser();
   }

   // Parse an integer from a string.

   public int parseInt(String name, int def)
   {
      String value = applet.getParameter(name);

      // The parameter is defined.

      if (value != null)
      {
         return Integer.parseInt(value);
      }

      // Return the default value.

      else
      {
         return def;
      }
   }

   public int[] parseInts(String value, String sep)
   {
      if (value != null)
      {
         String[] str = parser.parseStrings(value, sep);
         int[] data = new int[str.length];

         for (int i = 0; i < str.length; i++)
         {
            data[i] = Integer.parseInt(str[i]); 
         }

         return data;
      }

      else
      {
         return null;
      }
   }

   public long parseLong(String name, long def)
   {
      String value = applet.getParameter(name);

      if (value != null)
      {
         return Long.parseLong(value);
      }

      else
      {
         return def;
      }
   }

   public Color parseColor(String name, Color def)
   {
      String value = applet.getParameter(name);

      if (value != null)
      {
         return new Color(Integer.parseInt(value, 16));
      }

      else
      {
         return def;
      }
   }

   public Color parseColor(String name, String def)
   {
      String value = applet.getParameter(name);

      if (value != null)
      {
         return new Color(Integer.parseInt(value, 16));
      }

      else
      {
         return new Color(Integer.parseInt(def, 16));
      }
   }

   public Font parseFont(String name, String fname, int style, int size)
   {
      String value = applet.getParameter(name);

      if (value != null)
      {
         String[] str = parser.parseStrings(value, "|");
         int fsize = Integer.parseInt(str[2]);
         int fstyle = Font.PLAIN;

         if (str[1].equalsIgnoreCase("PLAIN"))
         {
            fstyle = Font.PLAIN;
         }

         if (str[1].equalsIgnoreCase("BOLD"))
         {
            fstyle = Font.BOLD;
         }

         if (str[1].equalsIgnoreCase("ITALIC"))
         {
            fstyle = Font.ITALIC;
         }

         return new Font(str[0], fstyle, fsize);
      }

      else
      {
         return new Font(fname, style, size);
      }
   }

   public boolean parseBoolean(String name, boolean def)
   {
      String value = applet.getParameter(name);

      if (value != null)
      {
         return (Boolean.valueOf(value)).booleanValue();
      }

      else
      {
         return def;
      }
   }

   public String parseString(String name, String def)
   {
      String value = applet.getParameter(name);

      if (value != null)
      {
         return value;
      }

      else
      {
         return def;
      }
   }

   public String[] parseStrings(String name, String sep)
   {
      String value = applet.getParameter(name);

      if (value != null)
      {
         return parser.parseStrings(value, sep);
      }

      else
      {
         System.err.println("name=\"" + name + "\" not defined.");
         return null;
      }
   }

   public String[] parseStrings(String name, String sep, int num)
   {
      String value = applet.getParameter(name);

      if (value != null)
      {
         String result[] = parser.parseStrings(value, sep);

         if (result.length == num)
         {
            return result;
         }

         else
         {
            System.err.println("name=\"" + name + "\" format incorrect.");
            return null;
         }
      }

      else
      {
         System.err.println("name=\"" + name + "\" not defined.");
         return null;
      }
   }
}
