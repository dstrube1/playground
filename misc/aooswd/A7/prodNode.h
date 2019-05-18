//prodNode.h - a binary operator node representing the product of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/

#ifndef PRODNODE_H
#define PRODNODE_H

#include "binNode.h"

   class prodNode:public binNode{
   public:
      prodNode();
      ~prodNode();
      prodNode(TreeInterface*, TreeInterface*);
      void accept(TreeVisitor*);
   private:
      TreeInterface* left;
      TreeInterface* right;
   };

   inline prodNode::prodNode(){
   }

   inline prodNode::prodNode(TreeInterface* l, TreeInterface* r){
      left=l;
      right=r;   
   }

   inline prodNode::~prodNode(){
   }

   inline void prodNode::accept(TreeVisitor* tv){
      left->accept(tv);
      right->accept(tv);
   	tv->visitProdNode();
   }
#endif