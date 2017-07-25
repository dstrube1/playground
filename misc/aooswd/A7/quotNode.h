//quotNode.h - a binary operator node representing the quotient of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/

#ifndef QUOTNODE_H
#define QUOTNODE_H

#include "binNode.h"

   class quotNode:public binNode{
   public:
      quotNode();
      ~quotNode();
      quotNode(TreeInterface*, TreeInterface*);
      void accept(TreeVisitor*);
   private:
      TreeInterface* left;
      TreeInterface* right;
   };

   inline quotNode::quotNode(){
   }

   inline quotNode::quotNode(TreeInterface* l, TreeInterface* r){
      left=l;
      right=r;   
   }

   inline quotNode::~quotNode(){
   }

   inline void quotNode::accept(TreeVisitor* tv){
      left->accept(tv);
      right->accept(tv);
   	tv->visitQuotNode();
   }
#endif