//treeInterface.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/
#ifndef TREEINTERFACE_H
#define TREEINTERFACE_H

#include <string>

   class TreeInterface
   {
   public:
      virtual int eval()=0;
   
      virtual string toString()const =0;
   
   protected:
      TreeInterface();
   };
   inline TreeInterface :: TreeInterface()
   {}


#endif