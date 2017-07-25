//treeInterface.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/
#ifndef TREEINTERFACE_H
#define TREEINTERFACE_H

class TreeVisitor;

   class TreeInterface
   {
   public:
   virtual void accept(TreeVisitor*);
   protected:
      TreeInterface();
   };
   inline TreeInterface :: TreeInterface()
   {}

inline void TreeInterface::accept(TreeVisitor* tv){}
#endif