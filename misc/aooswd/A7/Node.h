//node.h 
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/

#ifndef NODE_H
#define NODE_H

#include "TreeVisitor.h"

   class Node{
   public:
      Node (); 
      virtual ~Node();
      virtual void accept(TreeVisitor*)=0;
   };


   inline Node::Node(){
   }


   inline Node::~Node(){
   }

#endif
