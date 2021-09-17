//expNode.h - a binary operator node representing the exponetiation of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/

#ifndef EXPNODE_H
#define EXPNODE_H

#include "binNode.h"

   class expNode:public binNode{
   public:
      expNode();
      expNode(TreeInterface*, TreeInterface*);
      ~expNode();
      void accept(TreeVisitor*);
   private:
      TreeInterface* left;
      TreeInterface* right;
   };

   inline expNode::expNode(){
   }

   inline expNode::expNode(TreeInterface* l, TreeInterface* r){
      left=l;
      right=r;   
   }

   inline expNode::~expNode(){
   }

   inline void expNode::accept(TreeVisitor* tv){
      left->accept(tv);
      right->accept(tv);
   	tv->visitExpNode();
   }
#endif