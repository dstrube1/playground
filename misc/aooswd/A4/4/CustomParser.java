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

public class CustomParser extends Object
{
   public String[] parseStrings(String str, String sep)
   {
      if (str != null)
      {
         StringTokenizer st = new StringTokenizer(str, sep);
         String result[] = new String[st.countTokens()];

         for (int i = 0; i < result.length; i++)
         {
            result[i] = st.nextToken();
         }

         return result;
      }

      else
      {
         return null;
      }
   }

   public String[] wordWrap(String str, FontMetrics fm, int width)
   {
      Vector list = new Vector(0, 1);
      String word[] = parseStrings(str, " ");
      String line = null;

      line = word[0];

      for (int i = 1; i < word.length; i++)
      {
         if ((fm.stringWidth(line) + fm.stringWidth(word[i] + " ")) >= (width))
         {
            list.insertElementAt(line, list.size());
            line = word[i];
         }

         else
         {
            line = line + " " + word[i];
         }

         if (i == (word.length - 1))
         {
            list.insertElementAt(line, list.size());
         }
      }

      int num = list.size();
      String result[] = new String[num];

      for (int i = 0; i < num; i++)
      {
         result[i] = (String) (list.elementAt(i));
      }

      return result;
   }
}
