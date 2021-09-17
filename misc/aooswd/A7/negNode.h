//negNode.h - a unary operator node representing the negation of one node value

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/

#ifndef NEGNODE_H
#define NEGNODE_H

#include "unaNode.h"

   class negNode:public unaNode{
   public:
      negNode();
      negNode(TreeInterface*);
      ~negNode();
		void accept(TreeVisitor*);
   private:
      TreeInterface* left;
   };

   inline negNode::negNode(){
   }

   inline negNode::negNode(TreeInterface* l){   
      left=l;
   }

   inline negNode::~negNode(){   
   }

   inline void negNode::accept(TreeVisitor* tv){
      left->accept(tv);
      tv->visitNegNode();
   }
#endif