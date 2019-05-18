//posNode.h - a unary operator node representing the positifying of a node value

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/

#ifndef POSNODE_H
#define POSNODE_H

#include "unaNode.h"

   class posNode:public unaNode{
   public:
      posNode();
      ~posNode();
      posNode(TreeInterface*);
		void accept(TreeVisitor*);
   private:
      TreeInterface* left;
   };

   inline posNode::posNode(){
   }

   inline posNode::posNode(TreeInterface* l){
      left=l;
   }

   inline posNode::~posNode(){
   }

   inline void posNode::accept(TreeVisitor* tv){
      left->accept(tv);
      tv->visitPosNode();
   }
#endif